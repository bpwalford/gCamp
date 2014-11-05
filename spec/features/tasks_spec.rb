require "rails_helper"

feature "tasks" do

  scenario "user CRUD's a new task" do

    # begin on home page
    visit home_path

    # create a new task
    click_on "Tasks"
    click_on "Create Task"
    fill_in "Description", with: "testing"
    fill_in "Due date", with: "01-01-2012"
    click_on "Create Task"

    # verify task and attributes exist on show and index
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("Description: testing")
    expect(page).to have_content("Due: 01/01/12")
    expect(page).to have_content("Complete: false")
    click_on "Back"
    expect(page).to have_no_content("Task was successfully created.")
    expect(page).to have_content("testing")
    expect(page).to have_content("01/01/12")

    # edit task
    click_on "Edit"
    fill_in "Description", with: "different"
    fill_in "Due date", with: "01-01-2013"
    check "Complete"
    click_on "Update Task"


    # verify alterations were saved and exist on show and index
    expect(page).to have_content("Task was successfully updated.")
    expect(page).to have_content("Description: different")
    expect(page).to have_content("Due: 01/01/13")
    expect(page).to have_content("Complete: true")
    click_on "Back"
    click_on "All"
    expect(page).to have_no_content("Task was successfully updated.")
    expect(page).to have_content("different")
    expect(page).to have_content("01/01/13")

    # delete task and verify deletion
    click_on "Destroy"
    expect(page).to have_content("Task was successfully destroyed.")
    expect(page).to have_no_content("different")
    expect(page).to have_no_content("01/01/13")


  end

end
