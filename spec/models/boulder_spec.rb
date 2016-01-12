require 'rails_helper'

describe Boulder do
  subject(:boulder) { build(:boulder) }

  it 'has a valid factory' do
    expect(boulder).to be_valid
  end

  context '#setter' do

    context 'valid boulder, valid setter' do

      before :each do
        define_roles(:setter)
      end

      let(:user) { create(:setter_user) }
      subject(:boulder) { user.setter_story.boulders.create }

      it "returns the setter's user model" do
        expect(boulder.setter).to be user
      end

    end

    context 'setter not defined' do
      it "returns nil" do
        expect(boulder.setter).to be_nil
      end
    end

  end

end
