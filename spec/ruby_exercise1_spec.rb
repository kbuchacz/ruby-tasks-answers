require_relative "spec_helper"
require_relative "../exercises/ruby_exercise1"

describe "RubyExercise1" do

  describe "UsersList" do
    let(:name) { Faker::Name.name }
    let(:users_list)  { RubyExercise1::UsersList.new }

    context "#create_new_user" do

      it "should return user name" do
        expect(users_list.create_new_user(name)).to eql("Created user with name: #{name}")
        expect(users_list.users.size).to eql(1)
      end

      it "should receive get_user_name" do
        expect(users_list).to receive(:get_user_name).with(Struct).once
        expect(users_list.create_new_user(name))
      end

    end

    context "#get_user_name" do
      let(:user) { Struct.new(:user_name).new(name) }
      let(:last_user) { users_list.users.last }

      it "should raise when no user exists" do
        expect{users_list.get_user_name(nil)}.to raise_error(RubyExercise1::UsersList::NoUserError, "No user or empty name")
      end

      it "should return user name" do
        expect(users_list.create_new_user(name))
        expect(users_list.get_user_name(last_user)).to eql(name)
      end
    end
  end
end
