# lib/tasks/scraper.rake
namespace :scraper do
  desc "Scrape auto leasing website"
  task :scrape_auto_leasing => :environment do
    AutoLeasingScraper.scrape_all_pages(10)  # Scrape the first 10 pages
  end
end
