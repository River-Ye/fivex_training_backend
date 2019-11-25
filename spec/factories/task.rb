FactoryBot.define do
  factory :task do
    sequence(:title) { |num| "title_#{num}" }
    sequence(:content) { |num| "content_#{num}" }
    start_time { rand(1.months).seconds.ago }
    end_time { DateTime.now + (rand * 30) }
    sequence(:status, ['pending', 'progress', 'completed'].cycle) { |num| num }
  end
end