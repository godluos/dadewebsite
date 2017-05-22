class MessagesController < ApplicationController
  before_action :validate_search_key, only: [:search]
  def index
    @messages = Message.where(:is_hidden => false)
  end

  def show
    @message = Message.find(params[:id])
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
