module Errorhandle
  class << self
    def call(record)
      "Could not create #{record.class}" \
      " because #{record.errors.full_messages.join(', ')}"
    end
  end
  # practice Service Object as a module
end