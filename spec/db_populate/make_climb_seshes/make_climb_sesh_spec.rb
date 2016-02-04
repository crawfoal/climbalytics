require 'rails_helper'
require "rake_helper"

describe MakeClimbSeshes, :rake_helper do
  describe '.make_climb_sesh' do
    let(:alog) do
      alog = create(:athlete_climb_log)
      alog.create_boulder(attributes_for(:boulder))
      alog
    end
    subject(:make_climb_sesh) { MakeClimbSeshes.make_climb_sesh(alog) }

    it 'creates a new climb sesh' do
      expect { make_climb_sesh }.to change { ClimbSesh.count }.from(0).to(1)
    end
    describe 'the climb sesh' do
      subject(:climb_sesh) { make_climb_sesh }
      it 'has a note' do
        expect(climb_sesh.note).to_not be_nil
      end
      it 'has a high_hold' do
        expect(climb_sesh.high_hold).to_not be_nil
      end
    end
  end
end
