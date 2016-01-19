require "rails_helper"

RSpec.describe BoulderLogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/boulder_logs").to route_to("boulder_logs#index")
    end

    it "routes to #new" do
      expect(:get => "/boulder_logs/new").to route_to("boulder_logs#new")
    end

    it "routes to #show" do
      expect(:get => "/boulder_logs/1").to route_to("boulder_logs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/boulder_logs/1/edit").to route_to("boulder_logs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/boulder_logs").to route_to("boulder_logs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/boulder_logs/1").to route_to("boulder_logs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/boulder_logs/1").to route_to("boulder_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/boulder_logs/1").to route_to("boulder_logs#destroy", :id => "1")
    end

  end
end
