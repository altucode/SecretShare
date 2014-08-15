class SecretTagging < ActiveRecord::Base
  validates :secret, :tag, presence: true

  belongs_to(
  :secret,
  inverse_of: :secret_taggings
  )

  belongs_to(
  :tag,
  inverse_of: :secret_taggings
  )
end
