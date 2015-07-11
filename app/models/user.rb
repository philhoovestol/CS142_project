class User < ActiveRecord::Base
	has_many :photos
	has_many :tags
	
	def password_valid?(candidate)
		gen_digest = Digest::SHA1.hexdigest(candidate + self.salt.to_s)
		if gen_digest == self.password_digest
			return true
		end
		return false
	end

	def fullname
  		"#{first_name} #{last_name}"
	end
end
