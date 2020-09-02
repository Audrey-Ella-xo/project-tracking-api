# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Lorem.character }
    description { Faker::Lorem.character }
    created_by { Faker::Number.number(10) }
  end
end
