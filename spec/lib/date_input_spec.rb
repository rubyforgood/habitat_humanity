require 'date_input'
require 'spec_helper'

describe DateInput do
  it 'can parse a Date from valid input' do
    subject = DateInput.new('1990-01-01', default: Date.new).to_date
    expect(subject).to eq Date.new(1990, 1, 1)
  end

  it 'returns the default for invalid input' do
    subject = DateInput.new('invalid', default: Date.new).to_date
    expect(subject).to eq Date.new
  end

  it 'returns the default even if the default is not a valid date' do
    subject = DateInput.new('invalid', default: 'invalid').to_date
    expect(subject).to eq 'invalid'

    subject = DateInput.new('invalid', default: nil).to_date
    expect(subject).to eq nil
  end
end
