class User < ActiveRecord::Base
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
end