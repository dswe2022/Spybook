# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  author_id    :integer
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#




class Post < ApplicationRecord
    #Validations for Post title
    #validates :title, presence: true
  
    belongs_to :author,
      primary_key: :id,
      foreign_key: :author_id,
      class_name: :User
    
    has_many :comments,
      primary_key: :id,
      foreign_key: :post_id,
      class_name: :Comment
    
    has_many :likes,
      primary_key: :id,
      foreign_key: :post_id,
      class_name: :Like
    
    has_many :likers,
      through: :likes,
      source: :liker
  
    belongs_to :wall,
      primary_key: :id,
      foreign_key: :recipient_id,
      class_name: :User
      
    #Active Storage and AWS S3 Hosting Demo
    has_one_attached :post_photo

  end
  
