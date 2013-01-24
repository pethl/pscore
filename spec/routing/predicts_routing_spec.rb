require "spec_helper"

describe PredictsController do
  describe "routing" do

    it "routes to #index" do
      get("/predicts").should route_to("predicts#index")
    end

    it "routes to #new" do
      get("/predicts/new").should route_to("predicts#new")
    end

    it "routes to #show" do
      get("/predicts/1").should route_to("predicts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/predicts/1/edit").should route_to("predicts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/predicts").should route_to("predicts#create")
    end

    it "routes to #update" do
      put("/predicts/1").should route_to("predicts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/predicts/1").should route_to("predicts#destroy", :id => "1")
    end

  end
end
