class Handle
    def initialize(record)
      @record = record
    end

    def call
      "Could not create #{@record.class}" \
      " because #{@record.errors.full_messages.join(', ')}"
    end
  # practice Service Object as a class 
end