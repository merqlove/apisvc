module Constraints
  class ApiConstraint
    ACCEPT_BASE = 'application/vnd.apisvc.v'.freeze

    attr_reader :version
    attr_reader :default

    def initialize(options)
      @version = options.fetch(:version)
      @default = options.fetch(:default)
    end

    def matches?(request)
      acc = accept(request)
      if acc&.include?(ACCEPT_BASE)
        acc.include?("#{ACCEPT_BASE}#{@version}")
      else
        default
      end
    end

    private

    def accept(request)
      request.headers['Accept']
    end
  end
end
