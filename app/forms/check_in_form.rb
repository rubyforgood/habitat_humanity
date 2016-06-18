class CheckInForm < ApplicationForm
  attr_accessor :name, :email, :work_site_id, :day, :time, :action, :signature

  validates :name,      presence: true
  validates :email,     presence: true
  validates :work_site, presence: true
  validates :day,       presence: true
  validates :time,      presence: true
  validates :action,    presence: true
  validates :signature, presence: true

  def initialize(attributes = {})
    @name         = attributes[:name]
    @email        = attributes[:email]
    @work_site_id = attributes[:work_site_id]
    @time         = attributes[:time]
    @action       = attributes[:action]
    @signature    = attributes[:signature]

    @day  = Date.strptime(attributes[:day], '%d %B, %Y') if attributes[:day]
    @time = Time.strptime(
      "#{attributes[:day]} #{attributes[:time]}", '%d %B, %Y %l:%M %p'
    ) if attributes[:day] && attributes[:time]
  end

  def save
    volunteer.save!
    shift.save!
    shift_event.save!
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
      day:          day
    ) || Shift.new(
      volunteer: volunteer,
      work_site: work_site,
      day:       day
    )
  end

  def shift_event
    @shift_event ||= shift.shift_events.build(
      occurred_at: time,
      signature:   signature,
      action:      action
    )
  end

  def volunteer
    @volunteer ||= Volunteer.find_by(email: email) ||
                   Volunteer.new(name: name, email: email)
  end
end
