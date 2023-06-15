require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  xdescribe 'associations' do
    it { should have_many(:comments) }
  end

  describe 'instance methods' do
    describe '#published?' do
      let(:blog_post) { create(:blog_post, published_at: published_date) }

      context 'when the blog post is published' do
        let(:published_date) { Time.zone.now }
        it 'returns true if the blog post is published' do
          expect(blog_post.published?).to eq(true)
        end
      end
      context 'when the blog post is not published' do
        let(:published_date) { nil }

        it 'returns false if the blog post is not published' do
          expect(blog_post.published?).to eq(false)
        end
      end
    end

    describe '#draft?' do
      let(:blog_post) { create(:blog_post, published_at: published_date) }

      context 'when the blog post is published' do
        let(:published_date) { Time.zone.now }

        it 'returns false if the blog post is published' do
          expect(blog_post.draft?).to eq(false)
        end
      end
      context 'when the blog post is not have a published date' do
        let(:published_date) { nil }

        it 'returns true if the blog post is not published' do
          expect(blog_post.draft?).to eq(true)
        end
      end
    end

    describe '#scheduled?' do
      let(:blog_post) { create(:blog_post, published_at: published_date) }

      context 'when the blog post is already published' do
        let(:published_date) { Time.zone.now-1.day }

        it 'returns false if the blog post is published' do
          expect(blog_post.scheduled?).to eq(false)
        end
      end
      context 'when the blog post is scheduled' do
        let(:published_date) { 1.day.from_now }

        it 'returns true if the blog post is not published' do
          expect(blog_post.scheduled?).to eq(true)
        end
      end
    end
  end

  describe 'scopes' do
    describe '.published' do

      before do
        create(:blog_post, published_at: Time.zone.now)
        create(:blog_post, published_at: nil)
      end

      it 'returns only published blog posts' do
        expect(BlogPost.published.count).to eq(1)
      end
    end

    describe '.drafts' do
      before do
        create(:blog_post, published_at: Time.zone.now)
        create(:blog_post, published_at: nil)
      end

      it 'returns only drafts' do
        expect(BlogPost.drafts.count).to eq(1)
      end
    end
    
    describe '.scheduled' do
      before do
        create(:blog_post, published_at: Time.zone.now)
        create(:blog_post, published_at: nil)
        create(:blog_post, published_at: 1.day.from_now)
      end

      it 'returns only scheduled blog posts' do
        expect(BlogPost.scheduled.count).to eq(1)
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
