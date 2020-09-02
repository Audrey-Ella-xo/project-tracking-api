FactoryBot.define do
    factory :todo do
      title { Faker::Lorem.word }
      progress { 10 }
      project_id { 1 }
    end
end