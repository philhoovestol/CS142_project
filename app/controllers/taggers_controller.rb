class TaggersController < ApplicationController
  def tag
  	@picID = params[:id].to_i
  	photo = Photo.find(@picID)
  	@imagename = photo.file_name
  end
  def create
    puts params
  	picID = params[:id].to_i
  	new_tag = Tag.new
  	new_tag.x1 = params[:tag][:x1].to_i
  	new_tag.y1 = params[:tag][:y1].to_i
  	new_tag.wid = params[:tag][:wid].to_i
  	new_tag.hei = params[:tag][:hei].to_i
  	new_tag.user = User.find(params[:tag][:userID].to_i)
  	new_tag.photo = Photo.find(picID)
    new_tag.save(:validate => false)
  	redirect_to(:controller => :photos, :action => :index, :id => new_tag.photo.user.id)
  end
end