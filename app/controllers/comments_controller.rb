class CommentsController < ApplicationController
  def new
  	@photoid = params[:id].to_i
  	photo = Photo.find(@photoid)
    @imagename = ""
  	if photo
  		@imagename = photo.file_name
  	else
  		@imagename = nil
  	end
  end
  def create
    new_comment = Comment.new
    photoid = params[:id].to_i
    new_comment.photo_id = photoid
    new_comment.user_id = session[:logged_user_id]
    new_comment.date_time = DateTime.now
    new_comment.comment = params[:comment][:text]

    if new_comment.comment.empty?
      flash[:errorm] = "cannot submit an empty comment"
      redirect_to(:action => :new, :id => photo.id)
    else
      photo = Photo.find(photoid)
      photo.comments << new_comment
      redirect_to(:controller => :photos, :action => :index, :id => photo.user_id)
    end
  end
end
