require "rails_helper"

feature "tasks" do

  before do
    sign_in
  end

  scenario "user creates's a new user" do

    # create a new user
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "flarp"
    fill_in "Last name", with: "flarping"
    fill_in "Email", with: "flarp@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "Create User"

    # verify user and attributes exist index
    expect(page).to have_content("User was successfully created")
    expect(page).to have_content("flarp")
    expect(page).to have_content("flarping")

    # verify user exist on show page
    click_on "flarp flarping"
    expect(page).to have_no_content("User was successfully created.")
    expect(page).to have_content("First name: flarp")
    expect(page).to have_content("Last name: flarping")

  end

  scenario "user edits self" do

    visit user_path(User.first)

    # edit user
    click_on "Edit"
    fill_in "First name", with: "different"
    fill_in "Last name", with: "differenter"
    fill_in "Email", with: "different@example.com"
    click_on "Update User"

    # verify alterations were saved and exist on the index
    expect(page).to have_content("User was successfully updated.")
    expect(page).to have_content("different")
    expect(page).to have_content("differenter")
    expect(page).to have_content("different@example.com")

    # verify alerations are on show page
    within(".users-index") do
      click_on "different differenter"
    end
    expect(page).to have_no_content("User was successfully updated.")
    expect(page).to have_content("First name: different")
    expect(page).to have_content("Last name: differenter")
    expect(page).to have_content("Email: different@example.com")

  end

  scenario "user deletes self" do

    visit user_path(User.first)

    # delete user and verify deletion
    click_on "Edit"
    click_on "Destroy"
    expect(page).to have_content("You have successfully deleted your account")
    expect(page).to have_no_content("different")
    expect(page).to have_no_content("differenter")
    expect(page).to have_no_content("different@example.com")


  end

  scenario "attempt to create invalid user" do

    # create invalid user
    click_on "Users"
    click_on "Create User"
    click_on "Create User"

    # expect error messages
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")

  end

  scenario "user registers with already existing email" do

    # begin at home page
    click_on "Sign Out"
    visit home_path

    # user registers with existing email
    click_on "Sign Up"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "testing"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    within('.well') do
      click_on "Sign Up"
    end

    # verify error message
    expect(page).to have_content("Email has already been taken")

  end

end
