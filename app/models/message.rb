class Message < ApplicationRecord
  has_one :slack_set, dependent: :destroy
  accepts_nested_attributes_for :slack_set, allow_destroy: true
  # require 'time'

  require 'slack-ruby-client'
  require 'csv'

  validates :body, presence: true

  def send_slack
    Slack.configure do |config|
    # APIトークンを設定
      config.token = ''
    end

    # APIクライアントを生成
    client = Slack::Web::Client.new

    #チャンネル名 of @ユーザー名
    # channel = '#test'
    username = slack_set.username
    channel = slack_set.channel

    users_list = client.users_list['members'].map{ |v|
      if v[:profile][:display_name] == username
        channel = v[:id]
        break 
　    end
    }
      
    # users_info = client.users_info(user: '@akihiro.yamada')
    # channels_info = client.channels_info(channel: '#general')
    if post_at.blank?
      response = client.chat_postMessage(channel: channel, text: body)
    else
      postat = post_at.to_s
      postat = Time.parse(postat).to_i
      response = client.chat_scheduleMessage(channel: channel, post_at: postat, text: body)
    end
  end

  def self.send_line
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "9c7aff07b5ce2913a444fbe2412bbd0b"
      config.channel_token = "sSly+aluWiYvb0eyq4ljuVu1YXFsIKzbfVaRooOR0fcK5vyOAaHC+vjIpPY4uk4iyu2MTqY0ukVgsK3L00YRkAz/WfFMCdsE4TXws0qtVR2lVjTENQ707ejf8ptQfsmZLyWuMyk8oa0YilL+fdQylAdB04t89/1O/w1cDnyilFU="
    }

      body = request.body.read
      events = client.parse_events_from(body)
      
      events.each do |event|
        userId = event['source']['userId']  #userId取得
        p 'UserID: ' + userId # UserIdを確認
      end
  end

  def self.import(file)
    CSV.foreach(file.path, encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
      message = Message.new
      slack_set = message.build_slack_set

      slack_set[:username] = row['username']
      message[:body] = row['body']
      message[:post_at] = row['post_at']
      # message.send_slack
      message.save
    end
  end
end
