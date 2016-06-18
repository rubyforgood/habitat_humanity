class ApplicationForm
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def model_name
    ActiveModel::Name.new(self.class, nil, self.class.name)
  end

  def persisted?
    false
  end
end
