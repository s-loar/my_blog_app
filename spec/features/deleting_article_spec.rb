require "rails_helper"

RSpec.feature "Deleting an Article" do

  before do
    @article = Article.create(title: "Second Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.")
  end

  scenario "A user deletes an article" do
    visit "/"
    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(page.current_path).to eq(articles_path)
  end

end
