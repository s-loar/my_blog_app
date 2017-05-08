require "rails_helper"

RSpec.describe "Comments", type: :request do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "Second Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.", user: @john)
  end

  describe 'POST /articles/:id/comments' do
    context 'with a non-signed in user' do
      before do
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article."}}
      end

      it "redirects to the sign in page" do
        flash_message = "You need to sign in or sign up before continuing."
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq( 302)
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user' do
      before do
        login_as @fred
        post "/articles/#{@article.id}/comments", params: {comment: {body: "Awesome article."}}
      end
      it "successfully create the comment" do
        flash_message = "Comment has been created."
        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end

  end

end
