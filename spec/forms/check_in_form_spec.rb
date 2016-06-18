require 'rails_helper'

RSpec.describe CheckInForm do
  let(:form) { CheckInForm.new }

  it 'requires a signature for start_shift' do
    form.signature = nil
    form.action    = 'start_shift'

    expect(form).to_not be_valid
    expect(form.errors[:signature]).to_not be_blank
  end

  it 'requires a signature for end_shift' do
    form.signature = nil
    form.action    = 'end_shift'

    expect(form).to_not be_valid
    expect(form.errors[:signature]).to_not be_blank
  end

  it 'requires a signature for start_break' do
    form.signature = nil
    form.action    = 'start_break'

    form.valid?
    expect(form.errors[:signature]).to be_blank
  end

  it 'requires a signature for end_break' do
    form.signature = nil
    form.action    = 'end_break'

    form.valid?
    expect(form.errors[:signature]).to be_blank
  end
end
