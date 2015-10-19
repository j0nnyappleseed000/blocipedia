class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  validates_presence_of :user_id

  scope :publicly_visable, -> { where(:private => false) }
  scope :privately_visable, -> { where(:private => true) }

  def public?
    !self.private
  end

  def users
    arr = collaborators.to_ary
    arr << user
    arr
  end

end