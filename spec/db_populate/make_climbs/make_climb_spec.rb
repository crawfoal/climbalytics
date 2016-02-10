require 'rails_helper'
require "rake_helper"

describe MakeClimbs, :rake_helper do
  [:boulder, :route].each do |type|
    context 'all random attributes defined' do
      describe ".make_#{type}" do
        let(:alog) { create(:athlete_climb_log, climb_attributes: MakeClimbs.send("#{type}_attributes")) }
        subject(:climb) { alog.climb }

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
    context 'no random attributes defined' do
      before :each do
        Sometimes.private_instance_methods.each do |method_name|
          allow_any_instance_of(Object).to receive(method_name)
        end
      end

      let(:alog) { create(:athlete_climb_log, climb_attributes: MakeClimbs.send("#{type}_attributes")) }
      subject(:climb) { alog.climb }

      it { should be_persisted }
    end
  end
end
