require 'httparty'
require 'nokogiri'

class AutoLeasingScraper
  BASE_URL = "https://www.leasingmarkt.de/listing?v=2&nc=1&tg=PRIVATE&g[]=a&sfid[]=4&sfid[]=1&sfid[]=2&mlpf=251&mlpt=300&kombi=1&gelaende=1&limousine=1&ym=10000&dt=24&pimt=2&sort=rateDesc&p="

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

        # Extract price (primary and secondary)
        price_primary = vehicle_item.css('.block-price-tag__primary-price span').text.gsub(/[^\d,]/, '').gsub(',', '.').to_f
        price_secondary = vehicle_item.css('.block-price-tag__secondary-price').text.gsub(/[^\d,]/, '').gsub(',', '.').to_f

        # Extract mileage and lease duration
        mileage = vehicle_item.css('.listing-card__leasing-conditions .info-item').first.text.strip
        lease_duration = vehicle_item.css('.listing-card__leasing-conditions .info-item').last.text.strip

        # Extract other vehicle details (fuel type, transmission, horsepower, availability, etc.)
        fuel_type = vehicle_item.css('li').select { |li| li.text.include?('Diesel') || li.text.include?('Benzin') }.first&.text&.strip
        horsepower = vehicle_item.css('li').select { |li| li.text.include?('PS') }.first&.text&.strip
        transmission = vehicle_item.css('li').select { |li| li.text.include?('Automatik') || li.text.include?('Schaltgetriebe') }.first&.text&.strip
        mileage_state = vehicle_item.css('li').select { |li| li.text.include?('km') }.first&.text&.strip
        availability = vehicle_item.css('li').select { |li| li.text.include?('Verfügbar') }.first&.text&.strip

        # Save or update vehicle data
        vehicle = Vehicle.find_or_initialize_by(model: vehicle_name, subtitle: vehicle_subtitle)
        vehicle.price = price_primary
        vehicle.price_secondary = price_secondary
        vehicle.mileage = mileage
        vehicle.lease_duration = lease_duration
        vehicle.fuel_type = fuel_type
        vehicle.horsepower = horsepower
        vehicle.transmission = transmission
        vehicle.mileage_state = mileage_state
        vehicle.availability = availability
        vehicle.save!

        puts "Saved vehicle: #{vehicle_name} - #{vehicle_subtitle}"
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
