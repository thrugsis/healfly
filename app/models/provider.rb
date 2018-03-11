class Provider < ApplicationRecord
	has_many :appointments, :dependent => :delete_all

  include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]

end
