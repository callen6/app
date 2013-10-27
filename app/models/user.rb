class User < ActiveRecord::Base
	has_and_belongs_to_many :movies

	after_create :fetch_movie_history

	def self.from_omniauth(auth_hash)
		where(auth_hash.slice("provider", "uid")).first || create_from_omniauth(auth_hash)
	end

	def self.create_from_omniauth(auth_hash)
		create! do |user|
			user.provider = auth_hash["provider"]
			user.uid = auth_hash["uid"]
			user.name = auth_hash["info"]["name"]
			user.email = auth_hash["info"]["email"]
			user.image = auth_hash["info"]["image"]
			user.first_name = auth_hash["info"]["first_name"]
			user.token = auth_hash["credentials"]["token"]
			user.refresh_token = auth_hash["credentials"]["refresh_token"]
			user.expires_at = auth_hash["credentials"]["expires_at"]
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
      movie.link = video.player_url
      movie.thumbnail = video.thumbnails[3].url
      movie.save
      self.movies << movie
    end
end