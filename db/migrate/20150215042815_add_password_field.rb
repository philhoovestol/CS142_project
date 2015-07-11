class AddPasswordField < ActiveRecord::Migration
  def change
  	add_column :users, :password_digest, :string
  	add_column :users, :salt, :integer
  	User.reset_column_information
  	User.all.each do |user|
  		user.salt = Random.new(9999999)
  		user.password_digest = Digest::SHA1.hexdigest(user.login + user.salt.to_s)
  		user.save(:validate => false)
  	end
  end
end
