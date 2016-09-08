require "rails_helper"

RSpec.describe DatosbasicosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/datosbasicos").to route_to("datosbasicos#index")
    end

    it "routes to #new" do
      expect(:get => "/datosbasicos/new").to route_to("datosbasicos#new")
    end

    it "routes to #show" do
      expect(:get => "/datosbasicos/1").to route_to("datosbasicos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/datosbasicos/1/edit").to route_to("datosbasicos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/datosbasicos").to route_to("datosbasicos#create")
    end

    it "routes to #update" do
      expect(:put => "/datosbasicos/1").to route_to("datosbasicos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/datosbasicos/1").to route_to("datosbasicos#destroy", :id => "1")
    end

  end
end
