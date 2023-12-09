# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    name { 'Evan' }
    ocdid { '3' }
    title { 'Repper' }
    address { '23 St' }
    party { 'Labor' }
    photo { 'photo.jpg' }
  end
end
