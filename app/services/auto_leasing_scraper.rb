require 'httparty'
require 'nokogiri'

class AutoLeasingScraper
  BASE_URL = "https://www.leasingmarkt.de/listing?v=2&nc=1&tg=PRIVATE&g[]=a&sfid[]=4&sfid[]=1&sfid[]=2&mlpf=251&mlpt=300&kombi=1&gelaende=1&limousine=1&ym=10000&dt=24&pimt=2&sort=rateDesc&p="

  def self.scrape_page(page_number)
    url = "#{BASE_URL}#{page_number}"
    response = HTTParty.get(url)

    if response.code == 200
      parsed_page = Nokogiri::HTML(response.body)
      binding.pry
      # Loop through each vehicle item using relevant class (adjust based on your full HTML structure)
      parsed_page.css('.ad-card-item').each do |vehicle_item|
        # Extract vehicle title (make and model) - adjust the CSS selectors accordingly
        make_model = vehicle_item.css('.listing-card__info').text.strip

        # Extract price - you may need to adjust this selector
        price = vehicle_item.css('.lm-offeritem-price').text.gsub(/[^\d]/, '').to_i

        # You can extract other information like lease duration, mileage, etc.
        lease_duration = vehicle_item.css('.duration').text.strip
        mileage = vehicle_item.css('.mileage').text.strip

        # Split make and model if necessary (adjust based on actual structure)
        make, model = make_model.split(' ', 2)

        # Save or update vehicle data
        vehicle = Vehicle.find_or_initialize_by(make: make, model: model)
        vehicle.price = price
        vehicle.lease_duration = lease_duration
        vehicle.mileage = mileage
        vehicle.save!
      end
    else
      puts "Failed to retrieve page #{page_number}: #{response.code}"
    end
  rescue StandardError => e
    puts "Error scraping page #{page_number}: #{e.message}"
  end

  def self.scrape_all_pages(max_pages = 5)
    (1..max_pages).each do |page|
      puts "Scraping page #{page}..."
      scrape_page(page)
    end
  end
end
