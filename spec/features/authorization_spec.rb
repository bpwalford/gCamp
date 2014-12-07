require 'rails_helper'

feature 'authorization:' do

  before do
    @project = create_project(
      name: 'flarp'
    )
    # create member
    @member = create_user(
      email: 'user@example.com'
    )
    create_membership(
      user: @member,
      project: @project
    )
    # create owner
    @owner = create_user(
      email: 'owner@example.com'
    )
    create_membership(
      user: @owner,
      project: @project,
      status: 'owner'
    )
    # create admin
    @admin = create_user(
      email: 'admin@example.com',
      admin: true
    )
    # some other project
    create_project(
      name: 'floop'
    )
    # some other user
    create_user(
      first_name: 'foo',
      last_name: 'bar',
      email: 'floop@example.com'
    )

    def auth_sign_in(email)
      visit signin_path
      fill_in "Email", with: email
      fill_in "Password", with: "asdf"
      within(".well") do
        click_on "Sign In"
      end
    end
  end

  context 'what members see:' do

    before do
      auth_sign_in(@member.email)
    end

    scenario 'user sees only their projects' do
      expect(page).to have_content("flarp")
      expect(page).to have_no_content("floop")
      visit "projects/#{Project.find_by(name: 'floop').id}"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    scenario 'user sees only emails of users who share project' do
      visit users_path
      within(".users-index") do
        expect(page).to have_content("user@example.com")
        expect(page).to have_content("owner@example.com")
        expect(page).to have_content("foo bar")
        expect(page).to have_no_content("floop@example.com")
      end
      click_on "foo bar"
      expect(page).to have_no_content("floop@example.com")
    end

    scenario 'users do not see edit or destroy project' do
      within(".project-index") do
        click_on "flarp"
      end
      expect(page).to have_no_content("Edit")
      expect(page).to have_no_content("Destroy")
    end

    scenario 'users do not see edit or destroy users' do
      visit users_path
      click_on "foo bar"
      expect(page).to have_no_content("Edit")
      visit "/users/#{User.find_by(email: 'floop@example.com').id}/edit"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    scenario 'users do not see add member form but can delete self' do
      within(".project-index") do
        click_on "flarp"
      end
      click_on "2 Members"
      expect(page).to have_no_content("Add New Member")
      click_on "delete membership"
      expect(page).to have_content("You have successfully eliminated your membership to flarp")
      within(".project-index") do
        expect(page).to have_no_content("flarp")
      end
    end

  end

  context 'what owners see:' do

    before do
      auth_sign_in(@owner.email)
    end

    scenario 'owners sees only their projects' do
      expect(page).to have_content("flarp")
      expect(page).to have_no_content("floop")
      visit "projects/#{Project.find_by(name: 'floop').id}"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    scenario 'owners sees only emails of users who share project' do
      visit users_path
      within(".users-index") do
        expect(page).to have_content("user@example.com")
        expect(page).to have_content("owner@example.com")
        expect(page).to have_content("foo bar")
        expect(page).to have_no_content("floop@example.com")
      end
      click_on "foo bar"
      expect(page).to have_no_content("floop@example.com")
    end

    scenario 'owners do see edit and destroy project' do
      within(".project-index") do
        click_on "flarp"
      end
      expect(page).to have_content("Edit")
      expect(page).to have_content("Destroy")
    end

    scenario 'owners do not see edit or destroy users' do
      visit users_path
      click_on "foo bar"
      expect(page).to have_no_content("Edit")
      visit "/users/#{User.find_by(email: 'floop@example.com').id}/edit"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end

    scenario 'owners do see add member form' do
      within(".project-index") do
        click_on "flarp"
      end
      click_on "2 Members"
      expect(page).to have_content("please select a user")
    end
  end

  context 'what admins see:' do

    before do
      auth_sign_in(@admin.email)
    end

    scenario 'admins sees all projects' do
      expect(page).to have_content("flarp")
      expect(page).to have_content("floop")
      click_on "floop"
      expect(page).to have_content("floop")
    end

    scenario 'admins sees all emails of users ' do
      visit users_path
      within(".users-index") do
        expect(page).to have_content("user@example.com")
        expect(page).to have_content("owner@example.com")
        expect(page).to have_content("floop@example.com")
      end
    end

    scenario 'admins do see edit and destroy project' do
      within(".project-index") do
        click_on "flarp"
      end
      expect(page).to have_content("Edit")
      expect(page).to have_content("Destroy")
    end

    scenario 'admins do see edit or destroy users' do
      visit users_path
      click_on "foo bar"
      expect(page).to have_content("Edit")
      click_on "Edit"
      expect(page).to have_content("Destroy")
    end

    scenario 'admins do see add member form' do
      within(".project-index") do
        click_on "flarp"
      end
      click_on "2 Members"
      expect(page).to have_content("please select a user")
    end
  end

  context 'what visitors see:' do
    scenario 'visitor attempts to see projects page' do
      visit projects_path
      expect(page).to have_content("You must be logged in to access that action")
    end

    scenario 'visitor attempts to see users page' do
      visit users_path
      expect(page).to have_content("You must be logged in to access that action")
    end

    scenario 'visitor attempts to see membership page' do
      visit "/projects/#{Project.first.id}/memberships"
      expect(page).to have_content("You must be logged in to access that action")
    end

    scenario 'visitor attempts to see tasks page' do
      visit "/projects/#{Project.first.id}/tasks"
      expect(page).to have_content("You must be logged in to access that action")
    end
  end

end
