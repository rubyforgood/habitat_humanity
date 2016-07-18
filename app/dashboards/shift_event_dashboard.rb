require 'administrate/base_dashboard'

class ShiftEventDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    shift: Field::BelongsTo,
    id: Field::Number,
    action: Field::String,
    occurred_at: Field::DateTime,
    signature: RawImageField,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :shift,
    :id,
    :action,
    :occurred_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :shift,
    :id,
    :action,
    :occurred_at,
    :signature,
    :created_at,
    :updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :shift,
    :action,
    :occurred_at,
    :signature
  ].freeze

  # Overwrite this method to customize how shift events are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(shift_event)
  #   "ShiftEvent ##{shift_event.id}"
  # end
end
