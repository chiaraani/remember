FactoryBot.define do
  factory :review do
    word
    scheduled_for { 10.days.from_now }
  end

  factory :pending_review, class: Review do
    word
    created_at { 1.week.ago }
    scheduled_for { 3.days.ago }
  end

  factory :made_review, class: Review do
    word
    created_at { 1.week.ago }
    scheduled_for { 3.days.ago }
    made_at { Date.today }
    passed { true }
  end
end