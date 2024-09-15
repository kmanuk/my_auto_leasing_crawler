# == Schema Information
#
# Table name: leasing_offers
#
#  id                       :bigint           not null, primary key
#  vehicle_id               :bigint
#  vehicle_configuration_id :bigint
#  description              :string
#  monthly_price            :decimal(, )
#  duration                 :integer
#  mileage                  :decimal(, )
#  price_primary            :decimal(, )
#  price_secondary          :decimal(, )
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
class LeasingOffer < ApplicationRecord
  belongs_to :vehicle
  belongs_to :vehicle_configuration
end
