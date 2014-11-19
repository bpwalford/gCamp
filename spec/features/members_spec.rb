require 'rails_helper'

feature "Members" do

  before do

    project = Project.create!(
      name: "testProject"
    )
    task = Task.create!(
      description: "test",
      due_date: Date.today + 1.year
    )
    task.project = project
    user = User.create!(
      first_name: "test",
      last_name: "testing",
      email: "test@example.com",
      password: "asdf",
      password_confirmation: "asdf"
    )

  end

  scenario "member is added to and deleted from a project" do

    visit home_path
    click_on "Projects"
    click_on "testProject"
    click_on "0 Members"
    within(".new-member-form") do
      select "test", from: ("membership_user_id")
      click_on "Add New Member"
    end
    expect(page).to have_content("test")
    expect(page).to have_content("member")

    # changed to owner form index
    within(".current-members") do
      select "owner", from: "membership_status"
      click_on "Update"
    end
    expect(page).to have_content("test")
    expect(page).to have_content("owner")

    # member deleted
    within(".delete-x") do
      page.first(".glyphicon").click
      expect(page).to have_no_content("test testing")
      expect(page).to have_no_content("owner")
      expect(page).to have_no_content("Update")
    end

  end

  scenario "unselected member is added to a project" do

    visit home_path
    click_on "Projects"
    click_on "testProject"
    click_on "0 Members"
    within(".new-member-form") do
      select "member", from: "membership_status"
      click_on "Add New Member"
    end
    expect(page).to have_content("User can't be blank")

  end

  scenario "user is added is added to list twice" do

    visit home_path
    click_on "Projects"
    click_on "testProject"
    click_on "0 Members"
    within(".new-member-form") do
      select "test", from: ("membership_user_id")
      click_on "Add New Member"
    end
    within(".new-member-form") do
      select "test", from: ("membership_user_id")
      click_on "Add New Member"
    end
    expect(page).to have_content("User has already been added")


  end

end
