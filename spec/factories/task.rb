FactoryBot.define do
  factory :task do
    sequence(:title) { |num| "title_#{num}" }
    sequence(:content) { |num| "content_#{num}" }
    start_time { rand(1.months).seconds.ago }
    end_time { DateTime.now + (rand * 30) }

    factory :except_end_time do
      sequence(:title) { |num| "title_#{num}" }
      sequence(:content) { |num| "content_#{num}" }
      start_time { rand(1.months).seconds.ago }
    end
  end
end