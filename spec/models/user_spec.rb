require "rails_helper"

RSpec.describe User, type: :model do
  subject{build :user}

  context :association do
    it_behaves_like :have_many, :orders
  end

  context :validates do
    it{is_expected.to be_valid}

    it_behaves_like :presence_of, :name
    it_behaves_like :presence_of, :email

    it_behaves_like :allow_value, Faker::Internet.email, :email
    it_behaves_like :validate_uniqueness_of, :email
  end
end
