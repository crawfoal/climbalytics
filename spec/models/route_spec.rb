require 'rails_helper'

RSpec.describe Route, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Validations defined in parent model (Climb)
    it { should validate_presence_of :type }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(Route.validators.size).to be 1
    end
  end

  subject(:route) { build(:route) }

  it { is_expected.to be_valid }

  it 'maintains the original enum integer ids for YDS route grades' do
    # if you add to the Route.grades enum, make sure to maintain the ids below
    route_grades = Route.grades
    {"5.4"=>0, "5.5"=>1, "5.6"=>2, "5.7"=>3, "5.8"=>4, "5.9"=>5, "5.10a"=>6, "5.10b"=>7, "5.10c"=>8, "5.10d"=>9, "5.11a"=>10, "5.11b"=>11, "5.11c"=>12, "5.11d"=>13, "5.12a"=>14, "5.12b"=>15, "5.12c"=>16, "5.12d"=>17, "5.13a"=>18, "5.13b"=>19, "5.13c"=>20, "5.13d"=>21, "5.14a"=>22, "5.14b"=>23, "5.14c"=>24, "5.14d"=>25, "5.15a"=>26, "5.15b"=>27, "5.15c"=>28, "5.15d"=>29}.each do |key, value|
      expect(route_grades[key]).to eq(value), %q(
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
The ID for one or more Route grades was modified. This change will modify the grade that the end users see on their logs. E.g. if the ID of 5.10a is changed from 6 to 7, and the ID of 5.10b is changed from 7 to 8, and so on, any log that had a grade of 5.10b and above will now show one grade lower than what the user had origianlly entered. Do not make this change!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      )
    end
  end
end
