require 'rails_helper'

describe ClimbsHelper do
  include ClimbsHelper
  include Rails.application.routes.url_helpers

  describe '#path_to_edit_loggable_for' do
    context 'for a setter_climb_log' do
      xit 'returns a path to edit the record' do
        expect(path_to_edit_loggable_for(climb)).to eq
      end
    end

    context 'for an athlete_climb_log' do
      it 'returns a path to edit the record' do
        climb = create(:athlete_climb_log).climb
        expect(path_to_edit_loggable_for(climb)).to eq edit_athlete_climb_log_path(climb)
      end
    end
  end

  describe '#path_to_athlete_climb_log_for' do
    context 'for an athlete_climb_log owned by the current user' do
      context 'for an athlete who owns the record' do
        login_user :athlete
        it 'returns a path to edit the record' do
          climb = create(:athlete_climb_log, athlete_story: current_user.athlete_story).climb
          expect(path_to_athlete_climb_log_for(climb)).to eq edit_athlete_climb_log_path(climb)
        end
      end
    end
  end
end
