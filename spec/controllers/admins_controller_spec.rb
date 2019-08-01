require "rails_helper"
require "helpers/valid_json_helper.rb"

RSpec.describe Api::AdminsController, type: :controller do
  include ValidJsonHelper

  context "when index admins success" do
    let(:page){rand(1..3)}
    let!(:admins){create_list :admin, 15}

    subject{get :index, params: {page: page}}

    it "has 200 status code" do
      expect(subject.status).to eq 200
    end

    it "has responds admin data as json" do
      expect(valid_json? subject.body).to be true
    end

    it "has responds admin data pagination" do
      data = JSON.parse subject.body
      expect(data.size).to eq Settings.admins.per_page
    end
  end

  context "admin data responds" do
    let(:admin1){create :admin, name: "Admin 1", created_at: "2019-07-31 02:01:14"}
    let(:admin2){create :admin, name: "Admin 2", created_at: "2019-07-31 02:01:15"}
    let(:admin3){create :admin, name: "Admin 3", created_at: "2019-07-31 02:01:16"}

    it "should order by created_at descending" do
      expect(Admin.order_desc).to eq [admin3, admin2, admin1]
    end
  end

  context "when destroy admins success" do
    let(:admin){create :admin}
    subject{delete :destroy, params: {id: admin.id}}

    it "has 200 status code" do
      expect(subject.status).to eq 200
    end

    it "has responds admin data as json" do
      expect(valid_json? subject.body).to be true
    end
  end

  context "when destroy admin fail" do
    subject{delete :destroy, params: {id: 100}}

    it "has 404 status code" do
      expect(subject.status).to eq 404
    end

    it "has responds admin data as json" do
      expect(valid_json? subject.body).to be true
    end
  end
end