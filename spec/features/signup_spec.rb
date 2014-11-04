require 'rails_helper'

feature "Sign In" do

  scenario "new user signs up and logs out" do

    # begin at home page
    visit home_path

    # user registers as new user
    click_on "Sign Up"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "testing"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    within('.well') do
      click_on "Sign Up"
    end

    # user is automatically logged in
    expect(page).to have_content("test testing")
    expect(page).to have_no_content("Sign Up")

    # user logs out
    click_on "Sign Out"
    expect(page).to have_no_content("test testing")
    expect(page).to have_content("Sign Up")

  end

end
