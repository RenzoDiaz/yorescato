class Shrine < ActiveRecord::Base
	# Friendly url by id
	extend FriendlyId
  	friendly_id :name, use: :slugged

  	# Filterrific
	filterrific(
		#default_filter_params: { with_statuses_id: 'statuses_id_desc' },
		available_filters: [
			:search_query,
			#:with_country_id,
			#:with_created_at_gte
		]
	)
  	
	has_many :species
	validates :name,:description, presence: true

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
		num_or_conditions = 2
		where(
			terms.map {
				or_clauses = [
					"LOWER(shrines.name) LIKE ?",
					"LOWER(shrines.description) LIKE ?",
				].join(' OR ')
				"(#{ or_clauses })"
			}.join(' AND '),
			*terms.map { |e| [e] * num_or_conditions }.flatten
		)
	}

	attr_accessor :picture

	after_save :save_picture_profile, if: :picture 
	def save_picture_profile
		filename 	= picture.original_filename
		folder		= "public/shrines/#{id}/profile"

		FileUtils::mkdir_p folder

		f = File.open File.join(folder, filename), "wb"
		f.write picture.read()
		f.close

		self.picture = nil

		update image: filename
	end	
end
