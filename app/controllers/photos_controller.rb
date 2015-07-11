class PhotosController < ApplicationController
  def index
  	@currentuser = User.find(params[:id])
  	@isInOwnPage = false
    @tagsets = []
    @currentuser.photos.each do |photo|
      tagstyles = []
      photo.tags.each do |tag|
        style_s = "left:" + tag.x1.to_s + "px;"
        style_s += "top:" + tag.y1.to_s + "px;"
        style_s += "width:" + tag.wid.to_s + "px;"
        style_s += "height:" + tag.hei.to_s + "px;"
        tagstyles << style_s
      end
      @tagsets << tagstyles
    end
  	if @currentuser.id == session[:logged_user_id]
  		@isInOwnPage = true
  	end
  end
  def new
  end
  def create
  	uploaded_io = params[:newphoto][:photo]
  	File.open(Rails.root.join('app', 'assets/images', uploaded_io.original_filename), 'wb') do |file|
    	file.write(uploaded_io.read)
    end
  	new_photo = Photo.new
  	user = User.find(session[:logged_user_id])
  	new_photo.user_id = user.id
  	new_photo.date_time = DateTime.now
  	new_photo.file_name = uploaded_io.original_filename
  	user.photos << new_photo

  	redirect_to(:action => :index, :id => user.id)
  end

  def search
    substring = params[:input].downcase
    photos = []
    Photo.all.each do |photo|
      return_dis = false
      photo.tags.each do |tag|
        if !return_dis && tag.user.fullname.downcase.include?(substring) then
          return_dis = true
          photos << photo
        end
      end
      photo.comments.each do |comment|
        if !return_dis && comment.comment.downcase.include?(substring) then
          return_dis == true
          photos << photo
        end
      end
    end
    render :json => photos
  end
end
