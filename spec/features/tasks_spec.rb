require "rails_helper"

feature "tasks" do

  before do
    sign_in
  end

  scenario "user CRUD's a new task" do

    # create a new task
    within(".project-index") do
      click_on "flarp"
    end
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Description", with: "this is a task"
    fill_in "Due date", with: "01-01-2999"
    click_on "Create Task"

    # verify task and attributes exist on show and index, and project index
    expect(page).to have_content("Task was successfully created.")
    expect(page).to have_content("this is a task")
    expect(page).to have_content("01/01/99")
    within(".breadcrumb") do
      click_on "flarp"
    end
    expect(page).to have_no_content("Task was successfully created.")
    expect(page).to have_content("1 Task")
    within(".breadcrumb") do
      click_on "Projects"
    end
    expect(page).to have_content("1")

    # edit task
    within(".project-index") do
      click_on "flarp"
    end
    click_on "1 Task"
    click_on "Edit"
    fill_in "Description", with: "different"
    fill_in "Due date", with: "01-01-2013"
    check "Complete"
    click_on "Update Task"


    # verify alterations were saved and exist on show and index
    expect(page).to have_content("Tasks was successfully updated.")
    expect(page).to have_content("Due: 01/01/13")
    expect(page).to have_content("Complete: true")
    click_on "Tasks"
    click_on "All"
    expect(page).to have_no_content("Task was successfully updated.")
    expect(page).to have_content("different")
    expect(page).to have_content("01/01/13")

    # delete task and verify deletion
    click_on "delete"
    expect(page).to have_content("Task was successfully destroyed.")
    expect(page).to have_no_content("different")
    expect(page).to have_no_content("01/01/13")
    within(".breadcrumb") do
      click_on "flarp"
    end
    expect(page).to have_content("0 Tasks")

  end

  scenario "user creates invalid task" do

    # attempt to create task
    within(".project-index") do
      click_on "flarp"
    end
    click_on "0 Tasks"
    click_on "Create Task"
    click_on "Create Task"

    # expect error messages
    expect(page).to have_content("Description can't be blank")

  end

  scenario "user creates task due in past" do

    # attempt to create task
    within(".project-index") do
      click_on "flarp"
    end
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Description", with: "test"
    fill_in "Due date", with: "01/01/2000"
    click_on "Create Task"

    # expect error messages
    expect(page).to have_content("Due date can't be in the past")

  end

  scenario "update task with due date in past" do

    # create test task
    task = Task.new(
      description: "test",
      due_date: Date.today
    )
    task.project = Project.first
    task.save

    within(".project-index") do
      click_on "flarp"
    end
    click_on "1 Task"
    click_on "Edit"
    fill_in "Due date", with: "01-01-2000"
    click_on "Update Task"

    # expect success message
    expect(page).to have_content("Tasks was successfully updated")

  end

end
