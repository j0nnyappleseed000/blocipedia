class Wiki < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  scope :visible_to, -> (user) { user ? all : where(private: true) }

end
