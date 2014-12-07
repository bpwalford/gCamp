require 'rails_helper'

feature "Projects" do

  before do
    sign_in
  end

  scenario "user CRUD's a project" do

    # create a new project
    click_on "Create Project"
    fill_in "Name", with: "test"
    click_on "Create Project"
    expect(page).to have_content("Project was successfully created.")
    expect(page).to have_content("Tasks")

    # verify project exits on show page
    within(".breadcrumb") do
      click_on "test"
    end
    expect(page).to have_content("test")
    expect(page).to have_content("0 Tasks")
    expect(page).to have_content("1 Member")
    expect(page).to have_no_content("Project was successfully created.")

    # verify project exists on index
    visit projects_path
    expect(page).to have_content("test")
    expect(page).to have_content("0")
    expect(page).to have_content("1")

    # edit project
    within(".project-index") do
      click_on "test"
    end
    click_on "Edit"
    fill_in "Name", with: "different"
    click_on "Update Project"

    # verify alterations are on show page
    expect(page).to have_content("Project was successfully updated.")
    expect(page).to have_content("different")

    # verify alterations are on index
    visit projects_path
    expect(page).to have_no_content("Project was successfully updated.")
    expect(page).to have_content("different")

    # delete project
    within(".project-index") do
      click_on "different"
    end
    click_on "Destroy"
    expect(page).to have_content("Project was successfully deleted.")
    expect(page).to have_no_content("different")

  end

  scenario "attempt to create invalid project" do

    # create invalid project
    click_on "Create Project"
    click_on "Create Project"

    # expect error message
    expect(page).to have_content("Name can't be blank")

  end

end
