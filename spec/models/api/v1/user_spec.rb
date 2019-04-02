require 'rails_helper'

RSpec.describe User, type: :model do
  before (:each) do 
    @user = create(:user)
  end

  it 'is valid with valid attributes' do
    expect(@user.valid?).to be_truthy
  end

  it 'is not valid without an email' do
    @user.email = nil
    expect(@user.valid?).to be_falsey
  end

  it 'is not valid without a password' do
    @user.password = nil
    expect(@user.valid?).to be_falsey
  end

  it "has a unique email" do
    user1 = create(:user)
    user2 = create(:user)
    user1.email != user2.email
  end
end
