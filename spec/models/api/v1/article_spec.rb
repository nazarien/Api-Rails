require 'rails_helper'

RSpec.describe Article, type: :model do
  before (:each) do
    @article = create(:article)
  end

  it "title should exist" do
    @article.title = nil
    expect(@article.valid?).to eq(false)
  end

  it "title length >= 5" do
    expect(@article[:title].length).to be >= 5  
  end
end
