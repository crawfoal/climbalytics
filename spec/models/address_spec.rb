require 'rails_helper'

describe Address do

  it 'has a valid factory' do
    expect(build(:address)).to be_valid
  end
  it 'is invalid without a street line' do
    expect(build(:address, line1: nil)).to_not be_valid
  end
  it 'is invalid without a city' do
    expect(build(:address, city: nil)).to_not be_valid
  end
  it 'is invalid without a state' do
    expect(build(:address, state: nil)).to_not be_valid
  end
  it 'is invalid without a zip code' do
    expect(build(:address, zip: nil)).to_not be_valid
  end
  it 'is invalid if the zip code contains non-integers' do
    expect(build(:address, zip: 'A-b.~')).to_not be_valid
  end
  it 'is invalid if the zip code is not 5 characters' do
    expect(build(:address, zip: '803020')).to_not be_valid
  end
  it 'skips validation if all fields are blank' do
    expect(Address.create).to be_valid
  end

  describe '#format' do
    it 'formats the address in the standard US way' do
      address = create(:address)
      full_address =
        "#{address.line1}\n"\
        "#{address.line2}\n"\
        "#{address.city}, #{address.state.postal_abbreviation} #{address.zip}"
      expect(address.format).to eq full_address
    end
  end

end
