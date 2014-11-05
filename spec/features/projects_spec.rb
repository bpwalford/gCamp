require 'rails_helper'

feature "Projects" do

  scenario "user CRUD's a project" do

    # begin on home page
    visit home_path

    # create a new project
    click_on "Projects"
    click_on "Create Project"
    fill_in "Name", with: "test"
    click_on "Create Project"

    # verify project exits on show page
    expect(page).to have_content("Project was successfully created.")
    expect(page).to have_content("test")

    # verify project exists on index
    visit projects_path
    expect(page).to have_no_content("Project was successfully created.")
    expect(page).to have_content("test")

    # edit project
    click_on "test"
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
    click_on "different"
    click_on "Destroy"
    expect(page).to have_content("Project was successfully deleted.")
    expect(page).to have_no_content("different")

  end

end
