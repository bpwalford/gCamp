require 'rails_helper'

describe "Task" do

  it "validates presence of description and due date" do

    task = Task.new
    task.valid?
    expect(task.errors[:description].present?).to eq(true)

    task.description = "description"
    task.due_date = Date.today + 1.year
    task.valid?
    expect(task.errors[:description].present?).to eq(false)
    expect(task.errors[:due_date].present?).to eq(false)

  end

  it "doesn't allow tasks to be created with due dates in the past, but they can be updated as such" do

    task = Task.new(
      description: "description",
      due_date: Date.today - 1.year
    )
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)

    task = Task.new(
      description: "description",
      due_date: Date.today + 1.year
    )
    task.save
    task.due_date = Date.today - 2.years
    task.valid?
    expect(task.errors[:due_date].present?).to eq(false)


  end

  it "calculates something is due soon" do

    task = Task.new(
      description: "description",
      due_date: Date.today + 1.year
    )
    expect(task.due_soon).to eq(false)

    task.due_date = Date.today + 6.days
    expect(task.due_soon).to eq(true)

  end

end
