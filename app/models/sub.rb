class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true

  belongs_to(
    :moderator,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :post_subs,
    class_name: :PostSub,
    foreign_key: :sub_id,
    primary_key: :id
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

end
