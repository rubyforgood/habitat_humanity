require 'administrate/field/base'

class RawImageField < Administrate::Field::Base
  def src
    data
  end
end
