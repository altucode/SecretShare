class Tag < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, allow_nil: true }

  has_many(
  :secret_taggings,
  inverse_of: :tag,
  dependent: :destroy
  )

  has_many(
  :secrets,
  through: :secret_taggings,
  source: :secret
  )
end
