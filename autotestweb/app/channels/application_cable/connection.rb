module ApplicationCable
  #class Connection < ActionCable::Connection::Base
  #end
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      current_user = env['warden'].user
      #puts current_user.email
      #if verified_user = User.find_by_email(cookies["user_email"])
      #  verified_user
      if current_user
          current_user

      else
        reject_unauthorized_connection
      end
    end
  end
end
