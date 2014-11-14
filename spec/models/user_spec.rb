require 'rails_helper'

describe "User" do

  it "validates the presence of a first name, last name, email, and password" do

    user = User.new
    user.valid?
    expect(user.errors[:first_name].present?).to eq(true)
    expect(user.errors[:last_name].present?).to eq(true)
    expect(user.errors[:email].present?).to eq(true)
    expect(user.errors[:password].present?).to eq(true)

    user = User.new(
      first_name: "test",
      last_name: "test",
      email: "test@example.com",
      password: "asdf"
    )
    user.valid?
    expect(user.errors[:first_name].present?).to eq(false)
    expect(user.errors[:last_name].present?).to eq(false)
    expect(user.errors[:email].present?).to eq(false)
    expect(user.errors[:password].present?).to eq(false)

  end

  it "validates the uniqueness of emails" do

    user = User.create!(
      first_name: "test",
      last_name: "test",
      email: "test@example.com",
      password: "asdf"
    )
    user_two = User.new(
      first_name: "test_two",
      last_name: "test_two",
      email: "test@example.com",
      password: "asdf"
    )
    user_two.valid?
    expect(user_two.errors[:email].present?).to eq(true)

    user_two.email = "test_two@example.com"
    user_two.valid?
    expect(user_two.errors[:email].present?).to eq(false)


  end

  it "checks that password is the same as the password_confirmation" do

    user = User.new(
      first_name: "test",
      last_name: "test",
      email: "test@example.com",
      password: "asdf",
      password_confirmation: "fdsa"
    )
    user.valid?
    expect(user.errors[:password_confirmation].present?).to eq(true)

    user.password_confirmation = "asdf"
    user.valid?
    expect(user.errors[:password_confirmation].present?).to eq(false)

  end

  it "creates a full name of users" do

    user = User.new(
      first_name: "test",
      last_name: "test",
      email: "test@example.com",
      password: "asdf"
    )
    full_name = user.full_name
    expect(user.full_name).to eq("test test")

  end

end
