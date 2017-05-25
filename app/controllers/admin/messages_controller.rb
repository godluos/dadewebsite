class Admin::MessagesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @kinds = Kind.all.map { |c| [c.name, c.id] }
  end

  def create
    @message = Message.new(message_params)
    @message.kind_id = params[:kind_id]
    if @message.save
      redirect_to admin_messages_path
    else
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
    @kinds = Kind.all.map { |c| [c.name, c.id] }
  end

  def update
    @message = Message.find(params[:id])
    @message.kind_id = params[:kind_id]
    if @message.update(message_params)
      redirect_to admin_messages_path
    else
      render :edit
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to admin_messages_path
  end

  def publish
    @message = Message.find(params[:id])
    @message.publish!
    redirect_to :back
  end

  def hide
    @message = Message.find(params[:id])
    @message.hide!
    redirect_to :back
  end

  private

    def message_params
      params.require(:message).permit(:title, :description,
      :kind_id, :is_hidden, :writer, :keyword)
    end
end
