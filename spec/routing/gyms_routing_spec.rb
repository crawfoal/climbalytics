require "rails_helper"

RSpec.describe GymsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gyms").to route_to("gyms#index")
    end

    it "routes to #new" do
      expect(:get => "/gyms/new").to route_to("gyms#new")
    end

    it "routes to #show" do
      expect(:get => "/gyms/1").to route_to("gyms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gyms/1/edit").to route_to("gyms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gyms").to route_to("gyms#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gyms/1").to route_to("gyms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gyms/1").to route_to("gyms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gyms/1").to route_to("gyms#destroy", :id => "1")
    end

  end
end
