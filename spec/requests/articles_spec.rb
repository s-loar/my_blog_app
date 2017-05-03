require "rails_helper"

RSpec.describe "Articles", type: :request do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article1 = Article.create!(title: "Second Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.", user: @john)
  end

  describe 'GET /article/:id/edit' do
    context 'with non-signed in user' do
      before { get "/articles/#{@article1.id}/edit" }
      it "redirects to the sign in page" do
        expect(response.status).to eq( 302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in user who is not the owner' do
      before  do
        login_as @fred
        get "/articles/#{@article1.id}/edit"
      end
      it "redirects to the home page" do
        expect(response.status).to eq( 302)
        flash_message = "You can only edit your own articles."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in user who is the owner' do
      before do
        login_as @john
        get "/articles/#{@article1.id}/edit"
      end
      it "successfully edit article" do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE /article/:id' do
    context 'with non-signed in user' do
      before { delete "/articles/#{@article1.id}" }
      it "redirects to the sign in page" do
        expect(response.status).to eq( 302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in user who is not the owner' do
      before  do
        login_as @fred
        delete "/articles/#{@article1.id}"
      end
      it "redirects to the home page" do
        expect(response.status).to eq( 302)
        flash_message = "You can only delete your own articles."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in user who is the owner' do
      before do
        login_as @john
        delete "/articles/#{@article1.id}"
      end
      it "successfully delete article" do
        expect(response.status).to eq 302
        flash_message = "Article has been deleted."
        expect(flash[:success]).to eq flash_message
      end
    end
  end

  describe 'GET /articles/:id' do
    context 'with existing article' do
      before { get "/articles/#{@article1.id}" }

      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing article' do
      before { get "/articles/xxxx" }

      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

end
