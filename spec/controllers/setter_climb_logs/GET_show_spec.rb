require 'rails_helper'
require 'shared_examples/show_request'

describe SetterClimbLogsController do
  describe "GET #show" do
    let(:setter_climb_log) { create(:setter_climb_log) }
    let(:http_request_proc) { Proc.new { get :show, id: setter_climb_log.id } }

    context 'for a logged in user' do
      login_user

      it_behaves_like 'a basic show request', :setter_climb_log
    end

  end
end
