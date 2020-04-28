class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
    def index
      # @message = Message.all
      @message = Message.page(params[:page]).per(5).order(:id)
    end

    def new
      @message = Message.new
      @message.build_slack_set
    end
  
    def show
    end

    def destroy
      message = Message.find(params[:id])
      if message.user_id == current_user.id
        message.destroy
        redirect_to new_message_path, notice: '削除が完了しました'
      end
    end

    def create
      @message = Message.new(message_params)

      if @message.send_slack
        redirect_to new_message_path, notice: 'メッセージが送信されました'
        @message.save
      else
        flash.now[:alert] = 'メッセージ送信に失敗しました'
        render :new
      end
    end

    def import
      Message.import(params[:file])
      # redirect_to root_url
      redirect_to new_message_path, notice: 'slackメッセージが送信されました'
    end

    def line_send
      Message.send_line
      redirect_to new_message_path, notice: 'lineメッセージが受信されました'
    end

    private
      def message_params
        params.require(:message).permit(:body, :sns, :post_at, slack_set_attributes: [:username, :channel]).merge(user_id: current_user.id)
      end
  end
  