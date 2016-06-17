class CheckInForm
  include ActiveModel::Conversion

  attr_accessor :name, :email, :work_site_id, :signature

  def initialize(attributes)
    @name         = attributes[:name]
    @email        = attributes[:name]
    @work_site_id = attributes[:work_site_id]
    @signature    = attributes[:signature]
  end

  def model_name
    ActiveModel::Name.new(self.class, nil, self.class.name)
  end

  def persisted?
    false
  end

  def work_site
    return nil if work_site_id.nil?

    @work_site ||= WorkSite.find work_site_id
  end
end
