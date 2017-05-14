class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.max_length}
  validate :picture_size

  mount_uploader :picture, PictureUploader

  default_scope ->{order created_at: :desc}
  scope :seen_by_user, ->following_ids, id do
    where "user_id IN (?) OR user_id = ?", following_ids, id
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, "should be less than 5MB"
    end
  end
end
