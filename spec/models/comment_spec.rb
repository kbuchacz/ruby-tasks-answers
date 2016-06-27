require 'rails_helper'

RSpec.describe "Comment", type: :model do
  context "valid Comment" do
    let(:comment) { build(:comment) }
    it "is valid with body" do
      expect(comment).to be_valid
    end
  end

  context "invalid Comment" do
    let(:comment) { build(:comment, body: nil) }

    it "is invalid without body" do
      expect(comment).to be_invalid
    end
  end

  context "associations" do

    context "post" do
      let(:post) { create(:post) }
      let(:post_comment) { create(:comment, commentable: post)}

      it "can ba assigned to a post" do
        comment_attributes = attributes_for(:comment).merge({ commentable: post })
        expect{ Comment.create(comment_attributes) }.to_not raise_error
        expect(post_comment.commentable).to eql(post)
        expect(post.comments.last).to eql(post_comment)
      end

    end

    context "image" do
      let(:image) { create(:image) }
      let(:image_comment) { create(:comment, commentable: image)}

      it "can be assigned to an image" do

        expect(image_comment.commentable).to eql(image)
        expect(image.comments.last).to eql(image_comment)
      end
    end

    context "video" do
      let(:video) { create(:video) }
      let(:video_comment) { create(:comment, commentable: video)}

      it "can be assigned to an video" do

        expect(video_comment.commentable).to eql(video)
        expect(video.comments.last).to eql(video_comment)
      end
    end
  end
end
