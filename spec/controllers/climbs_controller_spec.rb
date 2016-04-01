require 'main_suite_helper'

describe ClimbsController do
  login_user
  describe 'GET #index' do
    context 'with valid params' do
      before :each do
        ww = create(:wild_walls)
        3.times { create(:boulder, gym_section: ww.sections.sample) }
        3.times { create(:route, gym_section: ww.sections.sample) }
      end

      context 'searching for all climbs in a particular gym' do
        let(:params) { {in_gym: Gym.last} }
        let(:climbs) { Climb.in_gym Gym.last }

        it 'finds the climbs at the specified gym' do
          get :index, params
          expect(assigns[:climbs]).to be == climbs
        end
      end
    end
  end
end
