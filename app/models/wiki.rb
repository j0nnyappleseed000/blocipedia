class Wiki < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id

  scope :visible_to, -> (user) { user ? all : where(private: true) }
  scope :publicly_visable, -> (user) { where(:private => false) }
  scope :privately_visable, -> (user) { where(:private => true) }

end