class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessor :email, :snuid
  validates :username, presence: true
  validate :check_duplicate, on: :create
  before_create :set_email, :encrypt_snuid
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :voted_articles, foreign_key: 'user_id', class_name: 'ArticleVote'

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
    self.snuid_digest = Digest::SHA256.hexdigest(self.snuid.downcase.strip)
  end

  def check_duplicate
    confirmed_user = User.where('snuid_digest = ? AND confirmed_at IS NOT NULL', Digest::SHA256.hexdigest(self.snuid.downcase.strip))
    if confirmed_user.present?
      errors.add(:base, "이미 등록된 SNU ID 입니다.")
    end
    same_nickname_user = User.where('nickname = ?', self.nickname)
    if same_nickname_user.present?
      errors.add(:base, "이미 있는 닉네임입니다.")
    end
  end
end
