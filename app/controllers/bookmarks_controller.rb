class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_topic
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  def show
    @bookmark = @topic.bookmarks.find(params[:id])
  end

  def new
    @bookmark = @topic.bookmarks.build
    authorize @bookmark
  end
 
  def create
    @bookmark = @topic.bookmarks.build( bookmark_params.merge( user_id: current_user.id ) )
    authorize @bookmark

    if @bookmark.save
      redirect_to @topic, notice: "Bookmark was saved."
    else
      flash[:error] = "Error creating bookmark."
      render :new
    end
  end
 
  def edit
    authorize @bookmark
  end

  def update
    authorize @bookmark
    if @bookmark.update_attributes( bookmark_params )
      flash[:notice] = "Bookmark updated"
      redirect_to @topic
    else
      flash[:error] = "Error updating bookmark"
      render :new
    end
  end

  def destroy
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "Bookmark deleted"
    else
      flash[:warning] = "Cannot delete bookmark you did not create."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id)
  end

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

end
