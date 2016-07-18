module RubyExercise1
  class UsersList

    NoUserError = Class.new(StandardError)
    
    attr_reader :users
    
    def initialize
      @users = []
    end

    def create_new_user(name)
      user = Struct.new(:user_name).new(name)
      add_user_to_list(user)
      user_name = get_user_name(user)
      "Created user with name: #{user_name}"
    end


    def get_user_name(user)
      user_name = user and user.user_name
      if user_name.nil? || user_name.to_s.strip.empty?
        raise NoUserError, "No user or empty name"
      else
        user[:user_name]
      end
    end


    private


    def add_user_to_list(user)
      @users << user
    end

  end

end
