require 'main_suite_helper'

describe ApplicationHelper do
  describe '#dashboard_path_for' do
    it "gives the path to dashboard corresponding to the user's current role" do
      expect(helper.dashboard_path_for(create :athlete)).to eq athlete_dashboard_path
    end
  end
end
