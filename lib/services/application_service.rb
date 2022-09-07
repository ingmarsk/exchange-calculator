# frozen_string_literal: true

class ApplicationService
  class << self
    def success_response
      Struct.new(:success?, :payload, keyword_init: true)
    end

    def error_response
      Struct.new(:success?, :error, keyword_init: true)
    end
  end
end
