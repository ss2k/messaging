class MessagesController < ApplicationController
  
  before_filter :authorize_user
  before_filter :check_for_responses, only: [:show]

  def new
    @message = Message.new
  end

  def create
    pry
    @message = current_user.sent_messages.build(params[:message])
    if @message.save
      flash[:notice] = "Your message was successfully sent"
      redirect_to root_url
    else
      flash[:error] = "There were some errors"
      render 'new'
    end
  end

  def index
    @user = User.find(params[:user_id])
    @received_messages = @user.received_messages.parent_msg
    @sent_messages = @user.sent_messages.parent_msg
  end

  def show
    @message = Message.find(params[:id])
    @responses = @message.responses
    @response = Message.new
  end

  def create_response
    @message = Message.find(params[:id])
    @response = @message.responses.build(params[:message])
    if @response.save
      flash[:notice] = "You successfully posted a response"
      redirect_to user_message_path(current_user, @message)
    else
      flash[:error] = "There was an error. Please retry"
      render 'show'
    end
  end

  private

  def authorize_user
    unless current_user == User.find(params[:user_id])
      flash[:error] = "You are not authorized to access this"
      redirect_to root_url
    end
  end

  def check_for_responses
    if Message.find(params[:id]).is_response?
      flash[:notice] = "This is not a parent message"
      redirect_to root_url
    end
  end
end
