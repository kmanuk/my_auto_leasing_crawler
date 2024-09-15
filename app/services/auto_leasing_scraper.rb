require 'httparty'
require 'nokogiri'

class AutoLeasingScraper
  BASE_URL = "https://example-autoleasing.com"

  # Scrape a single page of vehicle listings
  def self.scrape_page(page_number)
    binding.pry
    url = "#{BASE_URL}/vehicles?page=#{page_number}"
    response = HTTParty.get(url)

    # Check for a successful response
    if response.code == 200
      parsed_page = Nokogiri::HTML(response.body)

      # Loop through each vehicle listing on the page
      parsed_page.css('.vehicle-item').each do |vehicle_item|
        make = vehicle_item.css('.make').text.strip
        model = vehicle_item.css('.model').text.strip
        price = vehicle_item.css('.price').text.gsub(/[^\d]/, '').to_i  # Remove non-numeric characters

        # Save or update the vehicle data in the database
        vehicle = Vehicle.find_or_initialize_by(make: make, model: model)
        vehicle.price = price
        vehicle.save!

        # You can add more scraping logic here for lease terms, images, etc.
      end
    else
      puts "Failed to retrieve page #{page_number}: #{response.code}"
    end
  rescue StandardError => e
    puts "Error scraping page #{page_number}: #{e.message}"
  end

  # Scrape multiple pages
  def self.scrape_all_pages(max_pages = 5)
    (1..max_pages).each do |page|
      puts "Scraping page #{page}..."
      scrape_page(page)
    end
  end
end
