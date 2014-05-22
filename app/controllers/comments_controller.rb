class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to(@comment.event)
    else
      flash[:notice] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.event)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to(@comment.event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:username, :body, :event_id, :is_announcement)
    end
  end
