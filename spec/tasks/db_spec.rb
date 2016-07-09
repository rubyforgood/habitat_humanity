require 'spec_helper'

describe 'db', :task do
  describe 'seed' do
    subject { Rake::Task['db:seed'] }
    it 'should be valid' do
      expect { subject.invoke }.not_to raise_error
    end
  end

  describe 'initialize_admin' do
    subject { Rake::Task['db:initialize_admin'] }
    it 'should create a new admin user' do
      expect { subject.invoke }.to change { User.count }.from(0).to(1)
    end
  end
end
