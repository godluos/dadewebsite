class WelcomeController < ApplicationController
layout 'welcome'

  def index
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to root_path
      flash[:notice] = "成功提交留言"
    else
      redirect_to root_path
      flash[:warning] = "请正确填写，内容不得为空"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:name, :description, :tel, :email)
  end
end
