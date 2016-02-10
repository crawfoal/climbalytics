require 'rails_helper'

RSpec.describe Boulder, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in parent model (Climb)
    it { should validate_presence_of :type }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_numericality_of(:moves_count).only_integer }
    #---------------------------------------------------------------------------
    
    it 'should have 3 validators' do
      expect(Boulder.validators.size).to be 3
    end
  end

  it 'maintains the original enum integer ids for Hueco bouldering grades' do
    # if you add to the Boulder.grades enum, make sure to maintain the ids below
    route_grades = Boulder.grades
    {"VB"=>0, "V0"=>1, "V1"=>2, "V2"=>3, "V3"=>4, "V4"=>5, "V5"=>6, "V6"=>7, "V7"=>8, "V8"=>9, "V9"=>10, "V10"=>11, "V11"=>12, "V12"=>13, "V13"=>14, "V14"=>15, "V15"=>16, "V16"=>17}.each do |key, value|
      expect(route_grades[key]).to eq(value), %q(
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
The ID for one or more Route grades was modified. This change will modify the grade that the end users see on their logs. E.g. if the ID of V5 is changed from 6 to 7, and the ID of V6 is changed from 7 to 8, and so on, any log that had a grade of V6 and above will now show one grade lower than what the user had origianlly entered. Do not make this change!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      )
    end
  end

  context 'valid boulder' do
    subject(:boulder) { build(:boulder) }

    it { should be_valid }
  end

  context 'invalid boulder' do
    let(:invalid_grade) { Boulder.grades.values.last + 1 }
    it 'raises an error when an integer outside of the enum range is given' do
      expect { Boulder.create(grade: invalid_grade) }.to raise_error ArgumentError
    end
    it 'raises an error when an invalid string is given' do
      expect { Boulder.create(grade: 'V50') }.to raise_error ArgumentError
    end
  end
end
