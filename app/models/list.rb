class List < ApplicationRecord
  belongs_to :user
  has_many :list_comments, dependent: :destroy

  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join(app/assets/images/no_image.jpg)
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  validates :title, presence: true
  validates :caption, presence: true
  validates :image, presence: true

   def self.search_for(content, method)
    if method == 'perfect'
      List.where(title: content)
    elsif method == 'forward'
      List.where('title LIKE ?', content + '%')
    elsif method == 'backword'
      List.where('title LIKE ?', '%' + content)
    else
      List.where('title LIKE ?', '%' + content + '%')
    end
  end
end
