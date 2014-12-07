require 'rails_helper'

feature "Members" do

  before do
    sign_in
    create_user(
      first_name: 'foo',
      last_name: 'bar'
    )
  end

  scenario "member is added to and deleted from a project" do

    within(".project-index") do
      click_on "flarp"
    end
    click_on "1 Member"
    within(".new-member-form") do
      select "foo bar", from: ("membership_user_id")
      click_on "Add New Member"
    end
    expect(page).to have_content("foo bar")
    expect(page).to have_content("member")
    expect(page).to have_content("foo bar successfully added to project.")

    # changed to owner from index
    u = User.find_by(first_name: 'foo')
    m = Membership.find_by(user: u)
    id = m.id
    within("#edit_membership_#{id}") do
      select "owner", from: "membership_status"
      click_on "Update"
    end
    expect(page).to have_content("foo bar")
    expect(page).to have_content("owner")
    expect(page).to have_content("foo bar was successfully updated.")

  end

  scenario "unselected member is added to a project" do

    within(".project-index") do
      click_on "flarp"
    end
    click_on "1 Member"
    within(".new-member-form") do
      select "member", from: "membership_status"
      click_on "Add New Member"
    end
    expect(page).to have_content("User can't be blank")

  end

  scenario "user is added is added to list twice" do

    within(".project-index") do
      click_on "flarp"
    end
    click_on "1 Member"
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
