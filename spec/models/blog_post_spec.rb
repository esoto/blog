require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  xdescribe 'associations' do
    it { should have_many(:comments) }
  end

  xdescribe 'instance methods' do
    describe '#published?' do
      it 'returns true if the blog post is published' do
        blog_post = create(:blog_post, published_at: Time.zone.now)

        expect(blog_post.published?).to eq(true)
      end

      it 'returns false if the blog post is not published' do
        blog_post = create(:blog_post, published_at: nil)

        expect(blog_post.published?).to eq(false)
      end
    end
  end

  xdescribe 'scopes' do
    describe '.published' do
      it 'returns only published blog posts' do
        create(:blog_post, published_at: Time.zone.now)
        create(:blog_post, published_at: nil)

        expect(BlogPost.published.count).to eq(1)
      end
    end
  end

  xdescribe 'callbacks' do
    describe 'before_validation' do
      describe '#set_slug' do
        it 'sets the slug' do
          blog_post = build(:blog_post, title: 'My Blog Post')

          expect(blog_post.slug).to be_nil

          blog_post.valid?

          expect(blog_post.slug).to eq('my-blog-post')
        end
      end
    end
  end
end
