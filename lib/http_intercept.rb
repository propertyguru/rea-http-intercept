require 'http_intercept/version'
require 'http_intercept/interceptor'

module HttpIntercept
  class << self
    def injectable_clients
      %w(net)
    end

    def inject
      injectable_clients.each do |client|
        begin
          require "http_intercept/clients/#{client}"
        rescue LoadError
          nil
        end
      end
    end

    def add(visitor)
      interceptor.visitors << visitor
    end

    def interceptor
      @interceptor ||= Interceptor.new
    end
  end
end
