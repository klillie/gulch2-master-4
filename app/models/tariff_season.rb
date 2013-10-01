class TariffSeason < ActiveRecord::Base
	belongs_to :tariff_territory
	has_many :tariff_tou,
				foreign_key: "tariff_tou_id"
	validates :tariff_territory_id, presence: true


	# returns the type of season based on date and zip code
	def self.season(date, zip)
		@tariff_territory_id = TariffTerritory.territory_id(zip)
		@season = TariffSeason.where('season_type != ? AND tariff_territory_id = ? AND start_date <= ? AND end_date >= ?', 
			'All', @tariff_territory_id, date, date)

	end


end

