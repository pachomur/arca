require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  describe "GET tableau" do
    it "returns http success" do
      get :tableau
      expect(response).to be_success
    end
  end

end
