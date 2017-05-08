require "rails_helper"

RSpec.feature "Adding comments to articles" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "First Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.", user: @john)
  end

  scenario "permits a signed in user to add comments" do
    login_as(@fred)

    visit '/'
    click_link @article.title
    fill_in "New Comment", with: "An amazing article."
    click_button "Add Comment"
    expect(page).to have_content("Comment has been created.")
    expect(page).to have_content("An amazing article.")
    expect(page.current_path).to eq(article_path(@article.id))
  end

end
