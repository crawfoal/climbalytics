require 'rails_helper'

RSpec.describe AthleteClimbLog, type: :model do
  let(:user) { create(:athlete_user) }

  it { should belong_to :setter_climb_log }

  it { should belong_to :athlete_story }
  it { should validate_presence_of :athlete_story }

  it { should have_one(:climb).dependent(:destroy) }
  it { should accept_nested_attributes_for :climb }

  it { should have_many(:climb_seshes).dependent(:destroy) }

  context 'with valid attributes' do
    subject(:athlete_climb_log) { user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }

    it { should be_valid }

    describe '#athlete' do
      it 'returns the user associated with this athlete story' do
        expect(athlete_climb_log.athlete).to be == user
      end
    end

    describe 'climb associations' do
      [:boulder, :route].each do |climb_type|
        describe ".create_#{climb_type}" do
          let(:climb) { athlete_climb_log.send("create_#{climb_type}", attributes_for(climb_type)) }
          it "creates a #{climb_type}" do
            expect(climb.type).to eq climb_type.to_s.capitalize
          end
          it 'persists the climb record' do
            expect(climb).to be_persisted
          end
          it "sets the attributes for the #{climb_type}" do
            attributes_for(climb_type).each do |attribute, value|
              expect(climb.send(attribute)).to eq value
            end
          end
          it 'associates the new boulder with the athlete climb log' do
            climb
            expect(athlete_climb_log.send(climb_type)).to be climb
          end

          it "calls #{climb_type.to_s.classify}.create with attributes" do
            expect(climb_type.to_s.classify.constantize).to receive(:create).with(attributes_for(climb_type))
            climb
          end
          it "calls AthleteClimbLog.climb=" do
            expect(athlete_climb_log).to receive(:climb=)
            climb
          end
        end

        describe ".#{climb_type}" do
          let(:climb) { athlete_climb_log.send("create_#{climb_type}", attributes_for(climb_type)) }
          it "returns the climb if the climb's type is #{climb_type}" do
            climb
            expect(athlete_climb_log.send(climb_type)).to be climb
          end
          it "returns nil if the climb's type is not #{climb_type}" do
            climb
            expect(athlete_climb_log.send(climb_type == :route ? :boulder : :route)).to be_nil
          end
        end

        describe ".#{climb_type}=" do
          let(:climb) { climb_type.to_s.classify.constantize.new(attributes_for(climb_type)) }
          before :each do
            athlete_climb_log.send("#{climb_type}=", climb)
          end

          it "sets the climb to the record provided" do
            expect(athlete_climb_log.climb).to be climb
          end
        end

        describe ".create_#{climb_type}!" do
          let(:climb) { athlete_climb_log.send("create_#{climb_type}!", attributes_for(climb_type)) }
          it "calls #{climb_type.to_s.classify}.create! with attributes" do
            expect(climb_type.to_s.classify.constantize).to receive(:create!).with(attributes_for(climb_type))
            climb
          end
          it "calls AthleteClimbLog.climb=" do
            expect(athlete_climb_log).to receive(:climb=)
            climb
          end
        end
      end
    end
  end

end
