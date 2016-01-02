require 'rails_helper'

describe State do
  it 'has a valid factory' do
    expect(build(:state)).to be_valid
  end
end
