require 'rails_helper'

RSpec.describe "Image", type: :model do

  context "associations" do
    context "comments" do
      let(:image)  { create(:image) }
      let(:comment) { build(:comment) }

      it "can be associated with comment" do
        image.comments << comment
        expect(image.comments.count).to eql(1)
        expect(image.comments.last).to eql(comment)
      end
    end

    context "post" do
      let(:post)  { create(:post) }
      let(:image) { create(:image) }

      it "can be associated with the post" do
        image.post = post
        expect(image.post).to eql(post)
        expect(post.reload.images.last).to eql(image)
      end

    end
  end

end
