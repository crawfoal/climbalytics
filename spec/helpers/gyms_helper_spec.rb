require "main_suite_helper"

RSpec.describe GymsHelper do
  describe '#expand_address?' do
    it "is true if the gym doesn't have an address" do
      gym = build :gym, location_factory: :location_without_address
      assign(:gym, gym)

      expect(helper.expand_address?).to eq true
    end

    it 'is false if the gym has an address' do
      gym = create :gym, location_factory: :location_with_address
      assign(:gym, gym)

      expect(helper.expand_address?).to eq false
    end
  end

  describe '#gyms_near' do
    context "the user's current location is known, and there are some gyms nearby" do
      it 'includes the nearby gyms' do
        wild_walls = create :wild_walls
        location_for_user = build_stubbed(:ww_location, :with_coords_only)
        user = double(current_location: location_for_user)

        expect(helper.gyms_near(user)).to include wild_walls
      end
    end

    context "the user's current location is known, but there aren't any gyms nearby" do
      it 'is empty' do
        location_for_user = build_stubbed(:ww_location, :with_coords_only)
        user = double(current_location: location_for_user)

        expect(helper.gyms_near(user)).to be_empty
      end
    end

    context "the user's current location is not know" do
      it 'is empty' do
        wild_walls = create :wild_walls
        location_for_user = build_stubbed(:location)
        user = double(current_location: location_for_user)

        expect(helper.gyms_near(user)).to be_empty
      end
    end
  end
end
