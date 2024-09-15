# == Schema Information
#
# Table name: vehicle_brands
#
#  id         :bigint           not null, primary key
#  brand_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe VehicleBrand, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
