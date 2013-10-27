Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["CLIENT_ID"], ENV["CLIENT_SECRET"]
   {
   		access_type: "offline",
      scope: ["https://gdata.youtube.com", "https://www.googleapis.com/auth/userinfo.profile", "https://www.googleapis.com/auth/userinfo.email"],
      prompt:"force",
      image_aspect_ratio: "square",
      image_size: 50
    }
end
