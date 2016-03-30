require "rails_helper"

RSpec.describe AthleteClimbLogsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/athlete_climb_logs/new").to route_to("athlete_climb_logs#new")
    end

    it "routes to #edit" do
      expect(:get => "/athlete_climb_logs/1/edit").to route_to("athlete_climb_logs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/athlete_climb_logs").to route_to("athlete_climb_logs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/athlete_climb_logs/1").to route_to("athlete_climb_logs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/athlete_climb_logs/1").to route_to("athlete_climb_logs#update", :id => "1")
    end

  end
end
