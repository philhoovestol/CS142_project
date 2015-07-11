class UsersController < ApplicationController
  def index
  end
  def login
  end
  def post_login
  	if User.exists?(login: params[:loggedinuser][:login])
  		potential_user = User.find_by(login: params[:loggedinuser][:login])
      if potential_user.password_valid?(params[:loggedinuser][:password])
        @loggedinuser = potential_user
  		  session[:logged_user_id] = @loggedinuser.id
  		  session[:logged_user_first] = @loggedinuser.first_name
  		  redirect_to(:controller => :photos, :action => :index, :id => @loggedinuser.id)
      else
        flash[:errorm] = "incorrect password for user " + potential_user.login
        redirect_to(:controller => :users, :action => :login)
      end
  	else
  		flash[:errorm] = "nonexistant username"
  		redirect_to(:controller => :users, :action => :login)
  	end
  end
  def logout
  	@loggedinuser = nil
  	session[:logged_user_id] = nil
  	session[:logged_user_first] = nil
  	redirect_to(:controller => :users, :action => :login)
  end
  def new
  end
  def create
    new_user = User.new
    new_user.first_name = params[:user][:first]
    new_user.last_name = params[:user][:last]
    new_user.login = params[:user][:username]
    username = new_user.login
    new_user.salt = Random.new(99999)
    new_user.password_digest = Digest::SHA1.hexdigest(params[:user][:pass1] + new_user.salt.to_s)
    if params[:user][:pass1] != params[:user][:pass2] then
      flash[:errorm] = "entered passwords do not match"
      redirect_to(:action => :new)
    else
      new_user.save(:validate => false)
      redirect_to(:controller => :users, :action => :login)
    end
  end
end
