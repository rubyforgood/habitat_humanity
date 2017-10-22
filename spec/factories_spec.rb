require 'rails_helper'

##
# Verify that factories are valid
#
FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    around do |example|
      time = Timeliness.parse('2017-01-01 10:00am', zone: 'US/Central')
      Timecop.freeze(time) do
        example.run
      end
    end

    it 'is valid' do
      subject = build(factory_name)
      expect(subject).to be_valid
    end
  end
end
