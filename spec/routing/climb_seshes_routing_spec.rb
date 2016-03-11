require "rails_helper"

RSpec.describe ClimbSeshesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/climb_seshes").to route_to("climb_seshes#index")
    end

    it "routes to #new" do
      expect(:get => "/climb_seshes/new").to route_to("climb_seshes#new")
    end

    it "routes to #edit" do
      expect(:get => "/climb_seshes/1/edit").to route_to("climb_seshes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/climb_seshes").to route_to("climb_seshes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/climb_seshes/1").to route_to("climb_seshes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/climb_seshes/1").to route_to("climb_seshes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/climb_seshes/1").to route_to("climb_seshes#destroy", :id => "1")
    end

  end
end
