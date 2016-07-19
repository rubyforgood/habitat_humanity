require 'rails_helper'

##
# Verify that factories are valid
#
FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      subject = build(factory_name)
      expect(subject).to be_valid
    end
  end
end
