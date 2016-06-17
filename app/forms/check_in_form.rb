class CheckInForm
  include ActiveModel::Conversion

  attr_accessor :name, :email, :work_site_id, :signature

  def initialize(attributes)
    @name         = attributes[:name]
    @email        = attributes[:email]
    @work_site_id = attributes[:work_site_id]
    @signature    = attributes[:signature]
  end

  def model_name
    ActiveModel::Name.new(self.class, nil, self.class.name)
  end

  def persisted?
    false
  end

  def save
    shift_event.save!
  end

  def valid?
    volunteer.valid? && shift.valid? && shift_event.valid?
  end

  def work_site
    return nil if work_site_id.nil?

    @work_site ||= WorkSite.find work_site_id
  end

  private

  def shift
    @shift ||= Shift.find_by(
      volunteer_id: volunteer,
      work_site_id: work_site,
      day:          Date.today
    ) || Shift.create(
      volunteer: volunteer,
      work_site: work_site,
      day:       Date.today
    )
  end

  def shift_event
    @shift_event ||= shift.shift_events.build(
      occurred_at: Time.current,
      signature:   signature,
      action:      'start_shift'
    )
  end

  def volunteer
    @volunteer ||= Volunteer.find_by(email: email) ||
      Volunteer.create(name: name, email: email)
  end
end
