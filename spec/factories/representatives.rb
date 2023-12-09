#frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'Evan' }
    ocd_id { '3' }
    title { 'Repper' }
    address { '23 St'}
    party { 'Labor' }
    photo { 'photo.jpg' }
  end
end
