FactoryBot.define do
  factory :user1, class: User do
    name {"factory_guy_1"}
    email {"fac1@example.com"}
    password {"password"}
    password_confirmation {"password"}
  end
end
