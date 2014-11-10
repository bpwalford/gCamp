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

  scenario "attempt to create invalid user" do

    # begin on home page
    visit home_path

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

    # create user with email
    User.create!(
      first_name: "test",
      last_name: "testing",
      email: "test@example.com",
      password: "1234",
      password_confirmation: "1234"
    )

    # begin at home page
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
