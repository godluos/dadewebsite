class MessagesController < ApplicationController
  before_action :validate_search_key, only: [:search]
  impressionist actions: [:show]

  def index
    @messages = Message.where(:is_hidden => false)
    @messages = @messages.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @message = Message.find(params[:id])
    if @message.is_hidden
      flash[:warning] = "无效地址"
      redirect_to messages_path
    end
  end

  def search
    if @query_string.present?
      search_result = Message.ransack(@search_criteria).result(:distinct => true)
      @messages = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end
end
