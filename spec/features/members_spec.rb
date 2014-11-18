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
      password: "asdf"
    )

  end

  scenario "member is added to and deleted from a project" do

    visit root_path
    click_on "Projects"
    click_on "0"
    within(".new-member-form") do
      select "test", from: "Users"
      select "member", from: "Status"
      click_on "Add New Member"
    end
    expect(page).to have_content("test")
    expect(page).to have_content("member")

    # changed to owner form index
    within(".current-members") do
      select "owner", form: "Status"
      click_on "Update"
    end
    expect(page).to have_content("test")
    expect(page).to have_content("owner")

    # member deleted
    click_on ".glyficon"
    expect(page).to have_no_content("test")
    expect(page).to have_no_content("owner")
    expect(page).to have_no_content("Update")

  end

  scenario "unselected member is added to a project" do

    visit root_path
    click_on "Projects"
    click_on "0"
    within(".new-member-form") do
      select "member", from: "Status"
      click_on "Add New Member"
    end
    expect(page).to have_content("User can't be blank")

  end

end
