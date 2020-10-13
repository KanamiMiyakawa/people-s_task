FactoryBot.define do
  factory :user1, class: User do
    name {"factory_guy_1"}
    email {"fac1@example.com"}
    password {"password"}
    password_confirmation {"password"}

    factory :user2, class: User do
      name {"factory_guy_2"}
      email {"fac2@example.com"}
      password {"password"}
      password_confirmation {"password"}
    end

    factory :admin1, class: User do
      name {"factory_admin_1"}
      email {"fac_ad1@example.com"}
      password {"password"}
      password_confirmation {"password"}
      admin {true}
    end
  end
end
