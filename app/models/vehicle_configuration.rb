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
end
