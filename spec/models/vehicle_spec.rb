# == Schema Information
#
# Table name: vehicles
#
#  id               :bigint           not null, primary key
#  vehicle_brand_id :bigint
#  car_name         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
