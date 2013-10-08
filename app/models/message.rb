class Message < ActiveRecord::Base
  attr_accessible :body, :receiver_id, :sender_id, :title, :message_id

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  has_many :responses, class_name: 'Message', foreign_key: 'message_id' 
  belongs_to :parent_message, class_name: 'Message', foreign_key: 'message_id'

  scope :parent_msg, -> { where("message_id is NULL") }

  def is_response?
    self.message_id != nil
  end
end
