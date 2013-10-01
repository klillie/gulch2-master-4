class TariffBillingClass < ActiveRecord::Base
	belongs_to :tariff_territory
	has_many :tariff_line_items, 
				foreign_key: "tariff_billing_class_id"
	validates :tariff_territory_id, presence: true

	# Pulls the billing_class based on zip_code and demand
	def self.billing_class(zip, demand, usage, phases)
		@territory_id = TariffTerritory.territory_id(zip)
		@billing_class = TariffBillingClass.where('tariff_territory_id = ? AND units = ?
				AND start_value <= ? AND end_value > ? AND phases = ?', 
				@territory_id, "kW", demand, demand, phases) 
		
		# If no billing class is returned based on kW, looks to find one that is returned based on kWh
		if @billing_class.count == 0
			@billing_class = TariffBillingClass.where('tariff_territory_id = ? AND units = ?
				AND start_value <= ? AND end_value > ? AND phases = ?', 
				@territory_id, "kWh", usage, usage, phases) 
		end

		return @billing_class

		# -> need to error trap when no record is returned

	end

end
