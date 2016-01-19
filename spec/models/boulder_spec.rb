require 'rails_helper'

describe Boulder do
  subject(:boulder) { create(:boulder) }

  it 'has a valid factory' do
    expect(boulder).to be_valid
    expect(boulder.grade).to_not be_blank
  end

  describe '#setter' do

    context 'valid boulder, valid setter' do

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
