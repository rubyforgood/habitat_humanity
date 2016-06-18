require 'administrate/base_dashboard'

class ShiftDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    work_site: Field::BelongsTo,
    volunteer: Field::BelongsTo,
    id: Field::Number,
    day: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :work_site,
    :volunteer,
    :id,
    :day
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :work_site,
    :volunteer,
    :id,
    :day,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :work_site,
    :volunteer,
    :day
  ].freeze

  # Overwrite this method to customize how shifts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(shift)
  #   "Shift ##{shift.id}"
  # end
end
