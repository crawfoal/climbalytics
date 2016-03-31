require "rails_helper"

describe 'db:populate' do
  describe 'generated setter_climb_logs' do
    subject(:slog) { create :_setter_climb_log_ }

    it 'has a picture (1/4 of the time)' do
      expect(slog.picture.file).to_not be_nil
    end

    it 'has an associated climb' do
      expect(slog.climb).to be_present
    end
  end
end
