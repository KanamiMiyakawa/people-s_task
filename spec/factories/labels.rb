FactoryBot.define do

  factory :official_label_1, class: Label do
    label_name {"official_label_1"}
    official {true}

    factory :official_label_2 do
      label_name {"official_label_1"}
    end
  end

  factory :user_label_1, class: Label do
    label_name {"user_label_1"}
    official {false}

    factory :user_label_2 do
      label_name {"user_label_2"}
    end
  end
end
