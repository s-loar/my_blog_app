require "rails_helper"

RSpec.feature "Show an Article" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    # login_as(@john)
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: "Second Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.", user: @john)
  end

  scenario "to non-signed in user hide Edit and Delete buttons" do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to non-owner user hide Edit and Delete buttons" do
    login_as(@fred)

    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "to owner user show Edit and Delete buttons" do
    login_as(@john)

    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

end
