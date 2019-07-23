require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    # request.env["HTTP_ACCEPT"] = 'application/json'

    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #create" do
    before(:each) do
      @campaign = create(:campaign, user: @current_user)
      @member_attributes = attributes_for(:member, campaign: @campaign)
      post :create, params: { member: @member_attributes }
    end

    it "Member created with success" do
      expect(response).to have_http_status(200)
    end

    it "Create member with right attributes " do
      expect(Member.last.campaign).to eql(@campaign)
      expect(Member.last.name).to eql(@member_attributes[:name])
      expect(Member.last.email).to eql(@member_attributes[:email])
      expect(Member.last.token).to eql(@member_attributes[:token])
    end

    it "Create member associated with a correct campaign" do
      expect(Member.last.campaign.title).to eql(@campaign.title)
      expect(Member.last.campaign.status).to eql(@campaign.status)
    end

    it "The member already belongs to the campaign" do
      # post :create, params: { member: @member_attributes, :member[campaign: @campaign] }
      @member_attributes = attributes_for(:member, campaign: @campaign)
      expect(response).to have_http_status(422)
    end

    it "User can't created member" do
      campaign = create(:campaign)
      @member_attributes = attributes_for(:member, campaign: campaign)

      expect(response).to have_http_status(403)
    end
  end

  describe "GET #destroy" do
    before(:each) do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end

    context "when user have pemission to remover the member" do
      let(:member) { create(:member, campaign: @campaign) }
      it "the member removed the campaign" do
        delete :destroy, params: { id: member.id }
        expect(Member.last.campaign).tp be_nil
      end

      it "returns http success" do
        delete :destroy, params: { id: member.id }
        expect(response).to have_http_status(200)
      end
    end

    context "when user have not permission to remover the member" do

    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

end
