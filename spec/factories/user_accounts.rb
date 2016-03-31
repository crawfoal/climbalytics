FactoryGirl.define do

  start_num =
    begin
      User.count
    rescue ActiveRecord::StatementInvalid
      0
    end

  sequence(:user_account_number, start_num + 1) { |n| n }

  factory :user_account do
    transient do
      roles []

      user_account_number do
        generate(:user_account_number)
      end

      email_prefix do
        if roles.empty?
          'user'
        else
          roles.join
        end
      end
    end

    #---------------------------------------------------------------------------
    # Default Attributes
    email                 { "#{email_prefix}#{user_account_number}@example.com" }
    password              { "password#{user_account_number}" }
    password_confirmation { |u| u.password }
    #---------------------------------------------------------------------------
  end

end
