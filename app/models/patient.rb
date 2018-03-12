class Patient < User

  has_many :appointments, :dependent => :delete_all

end