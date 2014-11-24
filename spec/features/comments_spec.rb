require 'rails_helper'

feature "Comments" do

  before do

    user = User.create!(
      first_name: "test",
      last_name: "testing",
      email: "test@example.com",
      password: "asdf",
      password_confirmation: "asdf"
    )

    project = Project.create!(
      name: "newProject"
    )

    task = project.tasks.create!(
      description: "taskDescription",
    )

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "asdf"
    within(".well") do
      click_on "Sign In"
    end

  end

  scenario "Users can add comments to tasks" do

    click_on "Projects"
    click_on "newProject"
    click_on "1 Task"
    click_on "taskDescription"
    fill_in "<some area>", with: "This is a comment by test testing"
    click_on "Add Comment"
    # expect commenter name
    expect(page).to have_content("test testing")
    # expect comment
    expect(page).to have_content("This is a comment by test testing")
    # expect time ago it was created
    expect(page).to have_content("Less than a minute ago")

  end

  scenario "User cannot create blank comments" do

    click_on "Projects"
    click_on "newProject"
    click_on "1 Task"
    click_on "taskDescription"
    click_on "Add Comment"
    expect(page).to have_no_content("test testing")
    expect(page).to have_no_content("Less than a minute ago")

  end

  scenario "User cannot make comments if they are not signed in" do

    click_on "Sign Out"
    click_on "Projects"
    click_on "newProject"
    click_on "1 Task"
    click_on "taskDescription"
    expect(page).to have_no_content("Add Comment")

  end

  scenario "User sees comments only when they are associated with the appropriate task" do

    projectOther = Project.create!(
      name: "otherProject"
    )
    projectOther.tasks.create!(
      description: "different"
    )

    click_on "Projects"
    click_on "newProject"
    click_on "1 Task"
    click_on "taskDescription"
    fill_in "<some area>", with: "This is a comment by test testing"
    click_on "Add Comment"
    expect(page).to have_content("test testing")
    expect(page).to have_content("This is a comment by test testing")
    expect(page).to have_content("Less than a minute ago")
    click_on "Projects"
    click_on "otherProject"
    click_on "1 Task"
    click_on "different"
    expect(page).to have_no_content("test testing")
    expect(page).to have_no_content("This is a comment by test testing")
    expect(page).to have_no_content("Less than a minute ago")

  end

  scenario "User can view a count of comments from the task index" do

    project.tasks.create!(
      description: "fucking tasks"
    )

    click_on "Projects"
    click_on "newProject"
    click_on "1 Task"
    expect(page).to have_content("2")

  end

end
