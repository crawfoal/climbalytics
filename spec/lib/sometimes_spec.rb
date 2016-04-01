require "rails_helper"

RSpec.describe Sometimes do
  before :all do
    load "#{Rails.root}/lib/sometimes.rb"
  end

  describe '.sometimes' do
    context 'when given a block' do
      it 'yields the block (force always: 1/0 = infinity => always yeild)' do
        expect{ |b| Sometimes.sometimes(1, 0, &b) }.to yield_with_no_args
      end

      it 'does not yield the block (force never: 0/1 = 0 => never yield)' do
        expect{ |b| Sometimes.sometimes(0, 1, &b) }.to_not yield_with_no_args
      end
    end

    context 'when called without a block' do
      it 'returns true (force always: 1/0 = infinity => always true)' do
        expect(Sometimes.sometimes(1, 0)).to eq true
      end

      it 'returns false (force always: 0/1 = 0 => always false)' do
        expect(Sometimes.sometimes(0, 1)).to eq false
      end
    end
  end

  describe '.method_missing' do
    context "when the method name ends in '_of_the_time' and the beginning is whitelisted" do
      it 'calls .sometimes with the fraction pieces and passes the block along' do
        expect(Sometimes).to receive(:sometimes) { |&block| block.call }

        expect(Sometimes.half_of_the_time {"hello"}).to eq "hello"
      end
    end
  end

  after :all do
    load "#{Rails.root}/spec/support/helpers/sometimes_stub.rb"
  end
end
