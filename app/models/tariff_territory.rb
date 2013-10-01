class TariffTerritory < ActiveRecord::Base
	belongs_to :tariff_utility
	has_many :tariff_territory_zip_code_rel,
				foreign_key: "tariff_territory_id"
	validates :tariff_utility_id, presence: true

	# Pulls the territory_id based on a zip code
	def self.territory_id(zip)
		@zip_code_id = TariffZipCode.find_by(zip_code: zip).id
		@territory_id = TariffTerritoryZipCodeRel.find_by(tariff_zip_code_id: @zip_code_id).tariff_territory_id
	end

	# Pulls the territory based on a zip code
	def self.territory(zip)
		@territory_id = TariffTerritory.territory_id(zip)
		@territory = TariffTerritory.find_by(id: @territory_id).name
	end
	
end
