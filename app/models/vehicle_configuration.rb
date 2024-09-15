# == Schema Information
#
# Table name: vehicle_configurations
#
#  id           :bigint           not null, primary key
#  vehicle_type :integer
#  fuel         :integer
#  transmission :integer
#  year         :integer
#  horse_power  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class VehicleConfiguration < ApplicationRecord
  enum vehicle_type: [:kombi, :suv, :limousine, :sport, :van, :cabrio, :small_car, :commercial, :motorhome]
  enum fuel: [:benzin, :diesel, :electro, :hybrid, :gas, :other]
  enum transmission: [:automatic, :manual, :semi]
end
