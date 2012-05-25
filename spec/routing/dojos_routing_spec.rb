require "spec_helper"

describe DojosController do
  describe "routing" do

    it "routes to root" do
      get("/").should route_to("dojos#index")
    end

    it "routes to #index" do
      get("/dojos").should route_to("dojos#index")
    end

    it "routes to #new" do
      get("/dojos/new").should route_to("dojos#new")
    end

    it "routes to #show" do
      get("/dojos/1").should route_to("dojos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dojos/1/edit").should route_to("dojos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dojos").should route_to("dojos#create")
    end

    it "routes to #update" do
      put("/dojos/1").should route_to("dojos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dojos/1").should route_to("dojos#destroy", :id => "1")
    end

  end
end
