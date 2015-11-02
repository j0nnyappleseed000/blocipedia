class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates_presence_of :user_id
  default_scope { order('created_at DESC') }

  scope :publicly_visable, -> (user) { user ? all : where(:private => false) }
  scope :privately_visable, -> (user) { user ? all : where(:private => true) }

  def public?
    !self.private
  end

  def users
    arr = collaborators.collect(&:user).to_ary
    arr << user
    arr
  end

end