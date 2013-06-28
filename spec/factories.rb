# -*- encoding: UTF-8 -*-
FactoryGirl.define do
  factory :rank do
    name 'S3'
  end

  factory :dojo do
    rank { create(:rank) }
    level 200
    personality 'cute'
    leader '島村卯月'
    force '1000'
    sequence(:mbgaid)
    description '営業中'
  end
end
