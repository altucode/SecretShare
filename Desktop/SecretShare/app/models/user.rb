class User < ActiveRecord::Base
  attr_reader :password

  has_many :authored_secrets, class_name: "Secret", foreign_key: :author_id
  has_many :received_secrets, class_name: "Secret", foreign_key: :recipient_id

  has_many(
    :in_friendships,
    class_name: "Friendship",
    foreign_key: :in_friend_id,
    primary_key: :id
  )

  has_many(
    :out_friendships,
    class_name: "Friendship",
    foreign_key: :out_friend_id,
    primary_key: :id
  )

  has_many(
    :friends,
    through: :out_friendships,
    source: :in_friend
  )

  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, :username, presence: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
