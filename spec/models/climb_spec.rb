require 'main_suite_helper'

RSpec.describe Climb, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :type }
    it { should validate_numericality_of(:moves_count).is_greater_than(0).only_integer.allow_nil }
    it { should validate_presence_of :gym_section }
    it { should validate_length_of(:name).is_at_most(255) }
  end

  describe 'Associations' do
    it { should belong_to :loggable }
    it { should belong_to :gym_section }
  end

  context 'which is neither a boulder nor a route' do
    subject(:climb) { build(:climb, type: nil) }
    it { is_expected.to_not be_valid }
  end

  describe '#grade' do
    context 'for a climb that is either a Boulder or a Route' do
      it 'always returns the string, not the enum ID' do
        expect(create(:boulder, grade: 'V5').grade).to be_a String
      end
    end
  end

  describe '#gym' do
    context 'for a climb with an associated gym_section' do
      let(:ww) { create(:wild_walls) }
      let(:climb) { create(:boulder, gym_section: ww.sections.sample) }

      it "returns the gym that the climb's section belongs to" do
        expect(climb.gym).to be == ww
      end
    end
  end
end
