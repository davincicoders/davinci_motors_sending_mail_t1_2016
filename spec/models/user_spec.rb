require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should have_many :cars }

  it { should have_db_column(:verified_email).with_options(default: false) }
  it { should have_db_column(:token).with_options(default: '') }
end
