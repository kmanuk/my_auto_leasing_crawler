# == Schema Information
#
# Table name: leasing_offers
#
#  id                       :bigint           not null, primary key
#  vehicle_id               :bigint
#  vehicle_configuration_id :bigint
#  monthly_price            :decimal(, )
#  duration                 :integer
#  mileage                  :decimal(, )
#  price_primary            :decimal(, )
#  price_secondary          :decimal(, )
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
require 'rails_helper'

RSpec.describe LeasingOffer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
