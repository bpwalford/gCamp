require "rails_helper"

feature "tasks" do

  scenario "user CRUD's a new user" do

    # begin on home page
    visit home_path

    # create a new user
    click_on "Users"
    click_on "Create User"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "testing"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "Create User"

    # verify user and attributes exist index
    expect(page).to have_content("User was successfully created")
    expect(page).to have_content("test")
    expect(page).to have_content("testing")
    expect(page).to have_content("test@example.com")

    # verify user exist on show page
    click_on "test testing"
    expect(page).to have_no_content("User was successfully created.")
    expect(page).to have_content("First name: test")
    expect(page).to have_content("Last name: testing")
    expect(page).to have_content("Email: test@example.com")

    # edit user
    click_on "Edit"
    fill_in "First name", with: "different"
    fill_in "Last name", with: "differenter"
    fill_in "Email", with: "different@example.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation", with: "1234"
    click_on "Update User"

    # verify alterations were saved and exist on the index
    expect(page).to have_content("User was successfully updated.")
    expect(page).to have_content("different")
    expect(page).to have_content("differenter")
    expect(page).to have_content("different@example.com")

    # verify alerations are on show page
    click_on "different differenter"
    expect(page).to have_no_content("User was successfully updated.")
    expect(page).to have_content("First name: different")
    expect(page).to have_content("Last name: differenter")
    expect(page).to have_content("Email: different@example.com")

    # delete user and verify deletion
    click_on "Edit"
    click_on "Destroy"
    expect(page).to have_content("User was successfully deleted")
    expect(page).to have_no_content("different")
    expect(page).to have_no_content("differenter")
    expect(page).to have_no_content("different@example.com")


  end

end
