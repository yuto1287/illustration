class List < ApplicationRecord
  scope :active_lists, -> { includes(:user).where('users.is_deleted': false) }
  
  belongs_to :user
  has_many :list_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  validates :title, presence: true
  validates :caption, presence: true
  validates :image, presence: true

  def self.search_for(content, method)
    if method == 'perfect'
      List.active_lists.where(title: content)
    elsif method == 'forward'
      List.active_lists.where('title LIKE ?', content + '%')
    elsif method == 'backword'
      List.active_lists.where('title LIKE ?', '%' + content)
    else
      List.active_lists.where('title LIKE ?', '%' + content + '%')
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
