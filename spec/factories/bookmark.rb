FactoryGirl.define do
  factory :bookmark do
    url FFaker::Internet.http_url
    company
  end
end
