require 'rails_helper'

RSpec.describe FormHelper do
  describe '#setup_user' do
    context "when the user doesn't have a name yet" do
      it 'creates a new record for a name' do
        user = build_stubbed :user, name: nil

        expect{helper.setup_user(user)}.to change{user.name.class}.from(NilClass).to(User::Name)
      end
    end

    context "when the user has a name" do
      it "doesn't change the user's name" do
        user = build_stubbed :user, :with_name

        expect{helper.setup_user(user)}.to_not change{user.name}
      end
    end
  end
end
