require 'rails_helper'

describe IndexInspector do
  describe "#index_exists?" do
    context 'for a single column' do
      context 'with the unique option' do
        context 'when the index exists' do
          subject { UserAccount.index_exists?(:email, unique: true) }
          it { should be == true }
        end
        context 'when the index does not exists' do
          subject { Climb.index_exists?(:name, unique: true) }
          it { should be == false }
        end
      end
      context 'without the unique option' do
        context 'when the index exists' do
          subject { Role.index_exists?(:name) }
          it { should be == true }
        end
        context 'when the index does not exists' do
          subject { Climb.index_exists?(:name) }
          it { should be == false }
        end
      end
    end

    context 'for multi-column indices' do
      context 'with the unique option' do
        context 'when the index exists' do
          subject { Address.index_exists?([:addressable_id, :addressable_type], unique: true) }
          it { should be == true }
        end
        context 'when the index does not exists' do
          subject { Climb.index_exists?([:name, :type], unique: true) }
          it { should be == false }
        end
      end
      context 'without the unique option' do
        context 'when the index exists' do
          subject { Role.index_exists?([:name, :resource_type, :resource_id]) }
          it { should be == true }
        end
        context 'when the index does not exists' do
          subject { Climb.index_exists?([:moves_count, :type]) }
          it { should be == false }
        end
      end
    end
  end
end
