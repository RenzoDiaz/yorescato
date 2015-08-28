class Specie < ActiveRecord::Base
<<<<<<< HEAD

	# Friendly url by id
	extend FriendlyId
  	friendly_id :name, use: :slugged


	# Filterrific
	filterrific(
		#default_filter_params: { with_statuses_id: 'statuses_id_desc' },
		available_filters: [
			:search_query,
			:with_statuses_id,
			:with_families_id,
			#:with_country_id,
			#:with_created_at_gte
		]
	)

  	# Belongs to
  	belongs_to :statuses
=======
	extend FriendlyId
  	friendly_id :name, use: :slugged

	belongs_to :statuses
>>>>>>> 89841beef1f168e378704cb177dbef2633312f76
	belongs_to :shrines
	belongs_to :families

<<<<<<< HEAD
	scope :search_query, lambda { |query| 
		return nil  if query.blank?
		# condition query, parse into individual keywords
		terms = query.downcase.split(/\s+/)
		# replace "*" with "%" for wildcard searches,
		# append '%', remove duplicate '%'s
		terms = terms.map { |e|
			(e.gsub('*', '%') + '%').gsub(/%+/, '%')
		}
		# configure number of OR conditions for provision
		# of interpolation arguments. Adjust this if you
		# change the number of OR conditions.
		num_or_conditions = 3
		where(
			terms.map {
				or_clauses = [
					"LOWER(species.name) LIKE ?",
					"LOWER(species.habitat) LIKE ?",
					"LOWER(species.scientific_name) LIKE ?"
				].join(' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conditions }.flatten
		)
	}

	scope :with_statuses_id, lambda { |statuses_ids|
		where(statuses_id: [*statuses_ids])
	}

	scope :with_families_id, lambda { |families_ids|
		where(families_id: [*families_ids])
	}

	
	# Validate if fields empty
=======
>>>>>>> 89841beef1f168e378704cb177dbef2633312f76
	validates :name, :scientific_name, :country, :population, :statuses_id, :need, :habitat, :description, :nutrition, :threats, presence: true

	# this attribute keep value before send to database
	attr_accessor :picture

	# After save
	after_save :save_picture_profile, if: :picture 

	def save_picture_profile
		filename 	= picture.original_filename
		folder		= "public/species/#{id}/profile"

		FileUtils::mkdir_p folder

		f = File.open File.join(folder, filename), "wb"
		f.write picture.read()
		f.close

		self.picture = nil

		update image: filename
	end	

end
