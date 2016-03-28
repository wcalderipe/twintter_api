FactoryGirl.define do
  factory :comment do
    post { create(:post) }
    text { FFaker::Lorem.word }
  end
end
