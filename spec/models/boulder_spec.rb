require 'rails_helper'

RSpec.describe Boulder, type: :model do
  subject(:boulder) { build(:boulder) }

  it { should be_valid }

  it 'maintains the original enum integer ids for Hueco bouldering grades' do
    # if you add to the Boulder.grades enum, make sure to maintain the ids below
    route_grades = Boulder.grades
    {"VB"=>0, "V0"=>1, "V1"=>2, "V2"=>3, "V3"=>4, "V4"=>5, "V5"=>6, "V6"=>7, "V7"=>8, "V8"=>9, "V9"=>10, "V10"=>11, "V11"=>12, "V12"=>13, "V13"=>14, "V14"=>15, "V15"=>16, "V16"=>17}.each do |key, value|
      expect(route_grades[key]).to eq value
    end
  end
end
