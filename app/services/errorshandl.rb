module Errorshandle
  def self.create(record)
    "Could not create #{record.class}" \
    " because #{record.errors.full_messages.join(', ')}"
  end
end