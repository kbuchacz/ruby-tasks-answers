require 'rails_helper'

RSpec.describe "Post", type: :model do

  context "valid Post" do
    let(:post) { build(:post) }

    it "is valid with title and body" do
      expect(post).to be_valid
    end
  end

  context "invalid Post" do
    let(:no_title_post) { build(:post, title: nil) }
    let(:no_body_post) { build(:post, body: nil) }

    it "is invalid without a title" do
      expect(no_title_post).to_not be_valid
    end

    it "is invalid without a body" do
      expect(no_body_post).to_not be_valid
    end
  end

  context "associations" do

    context "comments" do
      let(:post)  { create(:post) }
      let(:comment) { build(:comment) }

      it "can be associated with comment" do
        post.comments << comment
        expect(post.comments.last).to eql(comment)
      end
    end

    context "images" do
      let(:post)  { create(:post) }
      let(:image) { create(:image) }

      it "can associate and image" do
        post.images << image
        expect(post.images.last).to eql(image)
      end

      it "can create an associated image" do
        image_attributes = attributes_for(:image)
        post.images.create(image_attributes)
        expect(post.images.last.attributes).to include(image_attributes.stringify_keys)
      end

      it "can create associated image as post_media" do
        post.post_media.create(medium: image)
        expect(post.images.last).to eql(image)
      end
    end

    context "viedos" do
      let(:post)  { create(:post) }
      let(:video) { create(:video) }

      it "can associate and video" do
        post.videos << video
        expect(post.videos.last).to eql(video)
      end

      it "can create an associated video" do
        video_attributes = attributes_for(:video)
        post.videos.create(video_attributes)
        expect(post.videos.last.attributes).to include(video_attributes.stringify_keys)
      end

      it "can create associated video as post_media" do
        post.post_media.create(medium: video)
        expect(post.videos.last).to eql(video)
      end
    end


    context "post_media" do
      let(:post)  { create(:post) }
      let(:video) { create(:video) }
      let(:image) { create(:image) }

      before do
        post.videos << video
        post.images << image
      end

      it "should return all post related media" do
        expect(post.post_media.count).to eql(2)
        expect(post.post_media.map(&:medium)).to match_array([video, image])
      end
    end
  end
end
