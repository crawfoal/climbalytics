require "main_suite_helper"

describe CurrentRolesController do
  describe "PUT #update" do
    context "for a role the user doesn't have" do
      login_user(:setter)

      it "doesn't change their current role" do
        expect{put :update, user: {current_role: 'athlete'}}.to_not change{User.last.current_role}
      end
    end
  end
end
