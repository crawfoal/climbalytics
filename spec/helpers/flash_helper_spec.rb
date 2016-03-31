require 'rails_helper'

RSpec.describe FlashHelper do
  describe '#render_flash' do
    it 'includes flash messages of types :alert, :notice, and :warning' do
      flash = {
        alert: 'This is an alert.',
        notice: 'This is a notice.',
        warning: 'This is a warning.'
      }
      allow(helper).to receive(:flash).and_return(flash)

      expect(helper.render_flash).to include flash[:alert], flash[:notice], flash[:warning]
    end

    it "doesn't include message types that aren't whitelisted" do
      non_whitelisted_type = "#{helper.send(:types_to_styles).keys.first}_private"
      flash = { non_whitelisted_type.to_sym => 'I should not be rendered.' }

      expect(helper.render_flash).to_not include flash.values.first
    end
  end
end
