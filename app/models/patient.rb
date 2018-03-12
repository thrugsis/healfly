class Patient < User

  has_many :appointments, :dependent => :delete_all

 def user?
  has_role?(:patient)
 end

end