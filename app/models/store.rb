class Store < ActiveRecord::Base
  resourcify

   has_many   :substores, class_name: "Store",  foreign_key: "parent_id"
	 belongs_to  :parent, class_name: "Store"
	 belongs_to :store_type
	 has_many :batches
	 #has_many :vendors
	 #has_many :supplies
	 belongs_to :store_operation

  default_scope{order(name: :asc)}

	validates :name, presence: true, uniqueness: true, length: {in:2..20}
	validates :store_type_id, :store_operation_id, presence: true

	before_save :modify_attr
	before_validation :name_unique

	def modify_attr
		self.name = name.titleize.strip
	end

	def name_unique
		self.name = name.titleize.strip
	end



end
