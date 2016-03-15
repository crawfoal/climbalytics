FactoryGirl.define do

  # Initial value is just for when we're playing around in the terminal and there are already some users defined.
  sequence(:user_account_number, User.count + 1) { |n| n }

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
    password_confirmation { password }
    #---------------------------------------------------------------------------
  end

end
