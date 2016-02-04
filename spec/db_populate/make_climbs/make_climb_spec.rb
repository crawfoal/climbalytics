require 'rails_helper'
require "rake_helper"

describe MakeClimbs, :rake_helper do
  [:boulder, :route].each do |type|
    describe ".make_#{type}" do
      let(:alog) { create(:athlete_climb_log) }
      subject(:climb) { MakeClimbs.send("make_#{type}",alog) }

      it { should be_persisted }

      before :each do
        climb
      end

      it 'is associated to the given loggable record' do
        expect(climb.loggable).to eq(alog)
      end
      it 'has a boulder grade' do
        expect(type.to_s.classify.constantize.grades).to include climb.grade
      end
      it 'has a number of moves' do
        expect(climb.grade).to_not be_nil
      end
      it 'has a name' do
        expect(climb.name).to_not be_nil
      end
    end
  end
end
