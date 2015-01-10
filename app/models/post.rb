class Post < ActiveRecord::Base
  validates :title, :user_id, presence: true

  has_many(
   :subs,
   through: :post_subs,
   source: :sub
  )

  has_many(
   :post_subs,
   class_name: :PostSub,
   foreign_key: :post_id,
   primary_key: :id
  )

  has_many :comments

  belongs_to :user

end
