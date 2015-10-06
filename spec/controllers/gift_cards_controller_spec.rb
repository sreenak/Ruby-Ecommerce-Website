require 'rails_helper'

RSpec.describe GiftCardsController, type: :controller do

  before(:each) do
    @request.host = "http://localhost:3000"
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      # controller.current_user.should_receive(:some_method).at_least(:once)
      expect(response).to render_template("index")
    end

    it "loads all of the gistcards into @gift_cards" do
      gistcard1, gistcard2 = GiftCard.create!, GiftCard.add!
      get :index
      # controller.current_user.should_receive(:some_method).at_least(:once)

      expect(assigns(:gift_cards)).to match_array([gistcard1, gistcard2])
    end
  end
end
