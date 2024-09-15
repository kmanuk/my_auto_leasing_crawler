# == Schema Information
#
# Table name: vehicle_brands
#
#  id         :bigint           not null, primary key
#  brand_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VehicleBrand < ApplicationRecord
end
