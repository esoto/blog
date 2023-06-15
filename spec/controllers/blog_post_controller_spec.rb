require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do
    let!(:user) { create(:user) }

    before do
        sign_in user
    end
    
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

    describe 'GET #new' do
        it 'returns a success response' do
            get :new
            expect(response).to be_successful
        end
    end

    describe 'POST #create' do
        context 'with valid params' do
            let(:valid_params) { attributes_for(:blog_post) }

            it 'creates a new BlogPost' do
                expect {
                    post :create, params: { blog_post: valid_params }
                }.to change(BlogPost, :count).by(1)
            end

            it 'redirects to the created blog_post' do
                post :create, params: { blog_post: valid_params }
                expect(response).to redirect_to(blog_post_path(BlogPost.last))
            end
        end

        context 'with invalid params' do
            let(:invalid_params) { attributes_for(:blog_post, title: nil) }

            it 'does not create a new BlogPost' do
                expect {
                    post :create, params: { blog_post: invalid_params }
                }.to change(BlogPost, :count).by(0)
            end

            it 'renders the new template' do
                post :create, params: { blog_post: invalid_params }
                expect(response).to render_template(:new)
            end
        end
    end

    describe 'GET #edit' do
        let(:blog_post) { create(:blog_post) }

        it 'returns a success response' do
            get :edit, params: { id: blog_post.id }
            expect(response).to be_successful
        end

        it 'redirects to the root path if the blog post is not found' do
            get :edit, params: { id: 0 }
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'PATCH #update' do
        let(:blog_post) { create(:blog_post) }

        context 'with valid params' do
            let(:valid_params) { attributes_for(:blog_post, title: 'New Title') }

            it 'updates the requested blog_post' do
                patch :update, params: { id: blog_post.id, blog_post: valid_params }
                blog_post.reload
                expect(blog_post.title).to eq('New Title')
            end

            it 'redirects to the blog_post' do
                patch :update, params: { id: blog_post.id, blog_post: valid_params }
                expect(response).to redirect_to(blog_post_path(blog_post))
            end
        end

        context 'with invalid params' do
            let(:invalid_params) { attributes_for(:blog_post, title: nil) }

            it 'does not update the requested blog_post' do
                patch :update, params: { id: blog_post.id, blog_post: invalid_params }
                blog_post.reload
                expect(blog_post.title).to_not eq(nil)
            end

            it 'renders the edit template' do
                patch :update, params: { id: blog_post.id, blog_post: invalid_params }
                expect(response).to render_template(:edit)
            end
        end
    end
end
