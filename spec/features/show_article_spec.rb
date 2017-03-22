require "rails_helper"

RSpec.feature "Show an Article" do

  before do
    @article1 = Article.create(title: "Second Article", body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque convallis, nisl et mattis pulvinar, velit dui elementum augue, nec tincidunt quam enim auctor sem. Quisque risus lorem, tincidunt mollis orci a, auctor vehicula ligula. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam gravida bibendum lorem. Nunc tempus eu purus sed mollis. Cras id consectetur felis, ac pulvinar sem. Vestibulum pretium eget tortor vel sodales.")
  end

  scenario "A user shows an article" do
    visit '/'
    click_link @article1.title

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page.current_path).to eq(article_path(@article1))
  end

end
