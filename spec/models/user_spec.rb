require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should have_many :cars }

  it { should have_db_column(:verified_email).with_options(default: false) }
  it { should have_db_column(:token).with_options(default: '') }

  describe "#needs_verification!" do
    let(:user) { FactoryGirl.create(:user, token: '', verified_email: true) }

    it "sets the verified email address field as false" do
      expect { user.needs_verification! }.to change(
        user, :verified_email?).from(true).to(false)
    end

    it "sets the token for the user" do
      expect { user.needs_verification! }.to change(user, :token)
    end

    it "sends a verification email" do
      expect { user.needs_verification! }.to change(
        ActionMailer::Base.deliveries, :count).by(1)
    end
  end

end
