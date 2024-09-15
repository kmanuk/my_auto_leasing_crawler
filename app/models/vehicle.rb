# == Schema Information
#
# Table name: vehicles
#
#  id         :bigint           not null, primary key
#  brand_name :string
#  model_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vehicle < ApplicationRecord
  has_many :leasing_offers
end
