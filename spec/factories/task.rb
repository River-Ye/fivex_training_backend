FactoryBot.define do
  factory :task do
    sequence(:title) { |num| "title_#{num}" }
    sequence(:content) { |num| "content_#{num}" }
  end
end