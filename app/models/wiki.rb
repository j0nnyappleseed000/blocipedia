class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates_presence_of :user_id

  scope :publicly_visable, -> { where(:private => false) }
  scope :privately_visable, -> { where(:private => true) }

  def self.public_wikis
    where(:private => false)
  end

  def public?
    !self.private
  end

  def users
    arr = collaborators.collect(&:user).to_ary
    arr << user
    arr
  end

end