FactoryBot.define do
  factory :label do
    label_name { "MyString" }
    official { false }
    user { nil }
  end
end
