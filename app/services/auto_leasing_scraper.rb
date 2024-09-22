require 'httparty'
require 'nokogiri'

class AutoLeasingScraper
  BASE_URL = "https://www.leasingmarkt.de/listing?v=2&nc=1&sort=popularity&p="

  def self.scrape_page(page_number)
    url = "#{BASE_URL}#{page_number}"
    response = HTTParty.get(url)

    if response.code == 200
      parsed_page = Nokogiri::HTML(response.body)

      # Loop through each vehicle item using relevant class
      parsed_page.css('a.ad-card-item').each do |vehicle_item|
        # Extract vehicle name (make and model)
        vehicle_name = vehicle_item.css('.listing-card__car-name .title').text.strip
        vehicle_subtitle = vehicle_item.css('.listing-card__car-name .subtitle').text.strip
        first_part = vehicle_name.split(' ').first
        brand = VehicleBrand.where("brand_name like '%#{first_part}%'").first
        vehicle = Vehicle.find_or_initialize_by(vehicle_brand_id: brand.id, car_name: vehicle_name)
        # Extract price (primary and secondary)
        price_primary = vehicle_item.css('.block-price-tag__primary-price span').text.gsub(/[^\d,]/, '').gsub(',', '.').to_f
        price_secondary = vehicle_item.css('.block-price-tag__secondary-price').text.gsub(/[^\d,]/, '').gsub(',', '.').to_f

        # Extract mileage and lease duration
        mileage = vehicle_item.css('.listing-card__leasing-conditions .info-item').first.text.strip
        lease_duration = vehicle_item.css('.listing-card__leasing-conditions .info-item').last.text.strip
        # Extract other vehicle details (fuel type, transmission, horsepower, availability, etc.)
        fuel_type = vehicle_item.css('li').select { |li| ['Benzin','Diesel','Elektro','Hybrid','Autogas','Wasserstoff'].include? li.text.strip.split(' ').first }.first&.text&.strip.strip.split(' ').first.downcase
        horsepower = vehicle_item.css('li').select { |li| li.text.include?('PS') }.first&.text&.strip
        transmission = vehicle_item.css('li').select { |li| ['Automatik', 'Manuell'].include? li.text.strip }.first&.text&.strip&.downcase
        vehicle_type = vehicle_item.css('li').select { |li| ['Kombi', 'SUV / Geländewagen', 'Limousine', 'Sportwagen', 'Van', 'Cabrio', 'Kleinwagen', 'Nutz', 'Kompakt', 'Reisemobil'].include?(li.text.strip)}.first&.text&.strip
        mileage_state = vehicle_item.css('li').select { |li| li.text.include?('km') }.first&.text&.strip
        availability = vehicle_item.css('li').select { |li| li.text.include?('Verfügbar') }.first&.text&.strip
        vehicle_type_short = vehicle_type.split('/').first.strip.downcase
        vehicle_configuration = VehicleConfiguration.find_or_initialize_by(fuel: fuel_type, horse_power: horsepower, transmission: transmission, vehicle_type: vehicle_type_short)

        # Save or update vehicle data
        # vehicle.price = price_primary
        # vehicle.price_secondary = price_secondary
        # vehicle.mileage = mileage
        # vehicle.lease_duration = lease_duration
        # vehicle.fuel_type = fuel_type
        # vehicle.horsepower = horsepower
        # vehicle.transmission = transmission
        # vehicle.mileage_state = mileage_state
        # vehicle.availability = availability
        vehicle.save
        vehicle_configuration.save
        parsed_mileage = ValueParser.extract_kilometers(mileage)
        parsed_lease_duration = ValueParser.extract_months(lease_duration)

        leasing_offer = LeasingOffer.create(
          vehicle_id: vehicle.id,
          vehicle_configuration_id: vehicle_configuration.id,
          mileage: mileage,
          price_primary: price_primary,
          price_secondary: price_secondary,
          description: vehicle_subtitle,
          duration: parsed_lease_duration
        )
        leasing_offer.save
      end
    else
      puts "Failed to retrieve page #{page_number}: #{response.code}"
    end
  rescue StandardError => e
    puts "Error scraping page #{page_number}: #{e.message}"
  end

  def self.scrape_all_pages(max_pages = 5)
    (0..max_pages).each do |page|
      puts "Scraping page #{page}..."
      scrape_page(page)
    end
  end
end
