class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  has_many :collaborators
  belongs_to :collaborators
  after_initialize :set_default_role, :if => :new_record?

  # scope :publicly_visable, -> { where(:private => false) }
  # scope :privately_visable, -> { where(:private => true) }
  
  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def set_default_role
    self.role ||= :standard
  end

end
