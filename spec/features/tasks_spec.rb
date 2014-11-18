require "rails_helper"

feature "tasks" do

  before do

    Project.create!(
      name: "testProject"
    )

  end

  scenario "user CRUD's a new task" do

    # begin on home page
    visit home_path

    # create a new task
    click_on "Projects"
    click_on "testProject"
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Description", with: "testing"
    fill_in "Due date", with: "01-01-2999"
    click_on "Create Task"

    # verify task and attributes exist on show and index, and project index
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("testing")
    expect(page).to have_content("01/01/99")
    click_on "Show"
    expect(page).to have_no_content("Task was successfully created.")
    expect(page).to have_content("Description: testing")
    expect(page).to have_content("Complete: false")
    expect(page).to have_content("01/01/99")
    click_on "testProject"
    expect(page).to have_content("1 Task")
    within(".footer-content") do
      click_on "Projects"
    end
    expect(page).to have_content("1")

    # edit task
    click_on "1"
    click_on "Edit"
    fill_in "Description", with: "different"
    fill_in "Due date", with: "01-01-2013"
    check "Complete"
    click_on "Update Task"


    # verify alterations were saved and exist on show and index
    expect(page).to have_content("Tasks was successfully updated.")
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
    click_on "test"
    expect(page).to have_content("0 Tasks")
    within(".footer-content") do
      click_on "Projects"
    end
    expect(page).to have_content("0")


  end

  scenario "user creates invalid task" do

    # begin at home page
    visit home_path

    # attempt to create task
    click_on "Projects"
    click_on "0"
    click_on "Create Task"
    click_on "Create Task"

    # expect error messages
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Due date can't be blank")

  end

  scenario "user creates task due in past" do

    # begin at home page
    visit home_path

    # attempt to create task
    click_on "Projects"
    click_on "0"
    click_on "Create Task"
    fill_in "Description", with: "test"
    fill_in "Due date", with: "01/01/2000"
    click_on "Create Task"

    # expect error messages
    expect(page).to have_content("Due date can't be in the past")

  end

  scenario "update user with due date in past" do

    # create test task
    task = Task.new(
      description: "test",
      due_date: Date.today
    )
    task.project = Project.first
    task.save

    # begin on home page
    visit home_path

    # update task
    click_on "Projects"
    click_on "1"
    click_on "Edit"
    fill_in "Due date", with: "01-01-2000"
    click_on "Update Task"

    # expect success message
    expect(page).to have_content("Tasks was successfully updated")

  end

end
