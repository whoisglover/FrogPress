class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :users_classroom
  has_many :classrooms, through: :users_classroom
  has_many :submissions

  def pending_assignments
    pending_assignments = []
    self.classrooms.each do |klass|
      pending_assignments += klass.assignments.where("due_date >= ?", Date.today)
    end
    return pending_assignments.sort_by(&:due_date)
  end


end
