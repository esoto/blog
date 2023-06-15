require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do
    describe 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_successful
        end
    end

    describe 'GET #show' do
        let(:blog_post) { create(:blog_post) }

        it 'returns a success response' do
            get :show, params: { id: blog_post.id }
            expect(response).to be_successful
        end

        it 'redirects to the root path if the blog post is not found' do
            get :show, params: { id: 0 }
            expect(response).to redirect_to(root_path)
        end
    end
end
