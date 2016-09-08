require 'rails_helper'

RSpec.describe "Datosbasicos", :type => :request do
  describe "GET /datosbasicos" do
    it "works! (now write some real specs)" do
      get datosbasicos_path
      expect(response.status).to be(200)
    end
  end
end
