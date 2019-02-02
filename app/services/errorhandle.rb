module Errorhandle
  class << self  # 類別方法，只有類別可直接呼叫這裡面的方法
    def call(record)
      "Could not create #{record.class}" \
      " because #{record.errors.full_messages.join(', ')}"
    end
  end
  # practice Service Object as a module
end