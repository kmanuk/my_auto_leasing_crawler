# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
car_brands = [
  "Audi", "Abarth", "Alfa Romeo", "Alpina", "Alpine", "Aston Martin", "BAIC", "Bentley", "BMW", "Bürstner",
  "Cadillac", "Cenntro", "Chevrolet", "Citroën", "Corvette", "Cupra", "Dacia", "DFSK", "Dodge", "Dongfeng",
  "DS Automobiles", "Ferrari", "Fiat", "Ford", "Genesis", "GWM", "Honda", "Hyundai", "Ineos", "Isuzu",
  "Iveco", "Jaguar", "Jeep", "Kia", "Lamborghini", "Land Rover", "Lexus", "Lotus", "Maserati", "MAXUS",
  "Maybach", "Mazda", "McLaren", "Mercedes-Benz", "MG", "MINI", "Mitsubishi", "Nissan", "Opel", "Ora",
  "Peugeot", "Polestar", "Porsche", "Renault", "Rolls Royce", "SAIC", "Seat", "Skoda", "smart", "SsangYong",
  "Subaru", "Suzuki", "SWM", "Tesla", "Toyota", "VinFast", "Volkswagen", "Volvo", "XEV", "XPENG"
]

car_brands.each do |car|
  VehicleBrand.create(brand_name: car)
end
