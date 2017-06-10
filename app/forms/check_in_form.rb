class CheckInForm < ApplicationForm
  DATE_FORMAT     = '%d %B, %Y'.freeze
  TIME_FORMAT     = '%l:%M %p'.freeze
  COMBINED_FORMAT = "#{DATE_FORMAT} #{TIME_FORMAT} %z".freeze
  SHIFT_ACTIONS   = %w(start_shift end_shift).freeze

  attr_accessor :name, :email, :work_site_id, :day, :time, :action, :signature,
                :minor

  validates :name,      presence: true
  validates :email,     presence: true
  validates :work_site, presence: true
  validates :day,       presence: true
  validates :time,      presence: true
  validates :action,    presence: true
  validates :signature, presence: true, if: :signature_required?

  def initialize(attributes = {})
    @name         = attributes[:name]
    @email        = attributes[:email]
    @work_site_id = attributes[:work_site_id]
    @day          = attributes[:day] || Time.zone.today.strftime(DATE_FORMAT)
    @time         = attributes[:time] || Time.current.strftime(TIME_FORMAT)
    @action       = attributes[:action]
    @signature    = attributes[:signature]
    @minor        = attributes[:minor]
  end

  def save
    volunteer.save!
    shift.save!
    shift_event.save!
  end
  alias save! save

  def work_site
    return nil if work_site_id.nil?

    @work_site ||= WorkSite.find work_site_id
  end

  private

  def signature_required?
    SHIFT_ACTIONS.include? action
  end

  def shift_day
    Date.strptime day, DATE_FORMAT
  end

  def occurred_at
    time_zone_offset =
      ActiveSupport::TimeZone[Rails.application.config.time_zone]
      .formatted_offset

    Time.strptime "#{day} #{time} #{time_zone_offset}", COMBINED_FORMAT
  end

  def shift
    @shift ||= Shift.find_by(
      volunteer_id: volunteer,
      work_site_id: work_site,
      day:          shift_day
    ) || Shift.new(
      volunteer: volunteer,
      work_site: work_site,
      minor:     minor,
      day:       shift_day
    )
  end

  def shift_event
    @shift_event ||= shift.shift_events.build(
      occurred_at: occurred_at,
      signature:   signature,
      action:      action
    )
  end

  def volunteer
    @volunteer ||= Volunteer.find_by(email: email) ||
                   Volunteer.new(name: name, email: email)
  end
end
