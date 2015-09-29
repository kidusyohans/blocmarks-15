class TopicsController < ApplicationController
before_action :authenticate_user!, except: [ :index, :show ]
  
  def index
    @topics = Topic.paginate(page: params[:page], per_page: 5)
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = current_user.topics.build( topic_params )
    authorize @topic

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    
    if @topic.update_attributes( topic_params )
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    title = @topic.title
    authorize @topic

    if @topic.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
    else
      flash[:error] = "Error deleting topic. Please try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

private

  def topic_params
    params.require(:topic).permit(:title)
  end
end
