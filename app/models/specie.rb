class Specie < ActiveRecord::Base

	# Friendly url by id
	extend FriendlyId
  	friendly_id :name, use: :slugged

  	# Belongs to
  	belongs_to :statuses
	belongs_to :shrines

	# Filterrific
	filterrific(
		#default_filter_params: { : 'id_desc' },
		available_filters: [
			#:with_statuses_id,
			:search_query,
			#:with_country_id,
			#:with_created_at_gte
		]
	)

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

	
	# Validate if fields empty
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
