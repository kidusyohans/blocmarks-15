class LikesController < ApplicationController
    
    def create
     @bookmark = Bookmark.find(params[:bookmark_id])
     @like = current_user.likes.build(bookmark: @bookmark)
     
    
     

 
        if @like.save
      redirect_to bookmarks_path , notice: "Like created."
        else
      redirect_to bookmarks_path , notice: "Error, please try again."
        end
    end
    
    def destroy
    @like = Like.find( params[:id] )
    
    if @like.destroy
      redirect_to bookmarks_path , notice: "Like has been deleted."
    else
      redirect_to bookmarks_path , notice: "Error, please try again"
    end
    end
end
