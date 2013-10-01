class TariffUtility < ActiveRecord::Base
	has_many :tariff_territory
	validates :name, presence: true
	validates :state, presence: true, length: { maximum: 2 }

	# Pulls the utility based on a zip code
	def self.utility(zip)
		@territory_id = TariffTerritory.territory_id(zip)
		@utility = TariffUtility.find_by(id: TariffTerritory.find_by(id: @territory_id)).name
	end

end
