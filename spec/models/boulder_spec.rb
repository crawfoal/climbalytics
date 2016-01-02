require 'rails_helper'

describe Boulder do
  it 'has a valid factory' do
    expect(build(:boulder)).to be_valid
  end
end
