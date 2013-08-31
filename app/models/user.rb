class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessor :email, :snuid
  validates :username, presence: true
  before_save :set_email, :encrypt_snuid
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
    false
  end
  
  def email_changed?
    false
  end

  private
  def set_email
    self.email = "#{self.snuid}@snu.ac.kr"
  end

  def encrypt_snuid
    self.snuid_digest = Digest::SHA256.hexdigest(self.snuid)
  end
end
