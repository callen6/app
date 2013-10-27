Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["CLIENT_ID"], ENV["CLIENT_SECRET"]
   {
   		access_type: "offline"
      scope: "userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com",
      prompt:"select_account",
      image_aspect_ratio: "square",
      image_size: 50
    }
end
