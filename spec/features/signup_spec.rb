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

  scenario "new user signs up with empty fields" do

    # begin at home page
    visit home_path

    # register new user with blank fields
    click_on "Sign Up"
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    within('.well') do
      click_on "Sign Up"
    end

    # verify error messages
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")

  end

  scenario "new user doesn't have matching password confirmation" do

    # begin at home page
    visit home_path

    # register new user with invalid password confirmation
    click_on "Sign Up"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "testing"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "4321"
    within('.well') do
      click_on "Sign Up"
    end

    # verify error message
    expect(page).to have_content("Password confirmation doesn't match Password")

  end

end
