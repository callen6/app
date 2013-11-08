class User < ActiveRecord::Base
  has_and_belongs_to_many :movies

  after_create :fetch_movie_history
# need a better find_or_create method
  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]      	
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
      user.first_name = auth["info"]["first_name"]
      user.token = auth["credentials"]["token"]
      user.refresh_token = auth["credentials"]["refresh_token"]
      user.expires_at = auth["credentials"]["expires_at"]
    end
   end

  def youtube_client    
    YouTubeIt::OAuth2Client.new(
      client_access_token: token, 
      client_id: ENV['CLIENT_ID'], 
      client_secret: ENV['CLIENT_SECRET'], 
      dev_key: ENV['DEV_KEY'],
      client_refresh_token: refresh_token,
      client_token_expires_at: expires_at)
  end

  def fetch_movie_history
    #self.youtube_client.refresh_access_token!
    watch_history = self.youtube_client.watch_history
    watch_history.videos.each do |video|
      movie = Movie.find_or_create_by(unique_id: video.unique_id)
      movie.title = video.title
      movie.description = video.description
      movie.url = video.player_url
      movie.thumbnail = video.thumbnails[3].url
      movie.save
      self.movies << movie
    end
  end
end
