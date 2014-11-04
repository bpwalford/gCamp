require 'rails_helper'

feature 'tasks' do

  scenario 'user CRUD\'s a new task' do

    # begin on home page
    visit home_path

    # create a new task
    click_on 'Tasks'
    

    # verify task and attributes exist

    # edit task

    # verify alterations were saved

    # delete task and verify deletion

  end

end
