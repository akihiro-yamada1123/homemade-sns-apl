class FormMessageNew 
  include ActiveModel::Model

  # attribute :body, :string, default: nil
  # attribute :sns, :integer, default: nil
  # attribute :token, :string, default: nil
  # attribute :channel, :string, default: nil

def save!
  ActiveRecord::Base.transaction do
    message = Message.find(id)
    message.save!(body: body, sns: sns)
    message.slack.save!(token: token, channel: channel)
  end
end

end