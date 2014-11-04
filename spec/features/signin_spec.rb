require 'rails_helper'

feature "Sign In" do

  scenario "current user signs in" do

    # create user to sign in with
    User.create!(
      first_name: "test",
      last_name: "testing",
      email: "test@example.com",
      password: "1234",
      password_confirmation: "1234"
    )

    # begin at home page
    visit home_path

    # user logs in
    click_on "Sign In"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "1234"
    within(".well") do
      click_on "Sign In"
    end

    # user is logged in
    expect(page).to have_content "test testing"
    expect(page).to have_no_content "Sign In"

    # user logs out
    click_on "Sign Out"
    expect(page).to have_no_content "test@example.com"
    expect(page).to have_content "Sign In"
    
  end

end
