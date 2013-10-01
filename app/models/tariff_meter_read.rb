class TariffMeterRead < ActiveRecord::Base
	belongs_to :tariff_territories
	validates :tariff_territories_id, presence: true

	# returns the meter_read definition (start_date, end_date, month_name, billing_year) based on date
	def self.meter_read(date, zip)
		@tariff_territory_id = TariffTerritory.territory_id(zip)
		@meter_read_start = TariffMeterRead.where('tariff_territory_id = ? AND date <= ?', 
				@tariff_territory_id, date)
		@meter_read_start = @meter_read_start.last!
		@meter_read_end = TariffMeterRead.where('tariff_territory_id = ? AND date > ?', 
				@tariff_territory_id, date)
		@meter_read_end = @meter_read_end.first!

		# returns a hash containing [start_date, end_date, month_name, billing_year]
		@meter_read = Hash.new
		@meter_read = {"start_date" => @meter_read_start.date, "end_date" => @meter_read_end.date, 
				"billing_month" => @meter_read_start.billing_month,
				"billing_year" => @meter_read_start.billing_year}
	end
end
