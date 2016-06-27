require 'rails_helper'

RSpec.describe "Video", type: :model do

  context "associations" do
    context "comments" do
      let(:video)  { create(:video) }
      let(:comment) { build(:comment) }

      it "can be associated with comment" do
        video.comments << comment
        expect(video.comments.count).to eql(1)
        expect(video.comments.last).to eql(comment)
      end
    end

    context "post" do
      let(:post)  { create(:post) }
      let(:video) { create(:video) }

      it "can be associated with the post" do
        video.post = post
        expect(video.post).to eql(post)
        expect(post.reload.videos.last).to eql(video)
      end
    end
  end

end
