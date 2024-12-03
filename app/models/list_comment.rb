class ListComment < ApplicationRecord
  scope :active_list_comments, -> { includes(:user).where('users.is_deleted': false) }

  belongs_to :user
  belongs_to :list

  validates :comment, presence: true
end
