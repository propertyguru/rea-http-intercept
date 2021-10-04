require 'uri'
require 'net/http'

module HttpIntercept
  module Clients
    module NetHttp
      class Request
        def initialize(connection, request)
          @connection = connection
          @request = request
        end

        def type
          'Net::HTTP'
        end

        def host
          if (hostname = self['host'])
            hostname.split(':').first
          else
            @connection.address
          end
        end

        def method
          @request.method
        end

        def [](key)
          @request[key]
        end

        def []=(key, value)
          @request[key] = value
        end

        def uri
          case @request.path
            when /^https?:\/\//
              URI(@request.path)
            else
              scheme = @connection.use_ssl? ? 'https' : 'http'
              URI("#{scheme}://#{@connection.address}:#{@connection.port}#{@request.path}")
          end
        end
      end

      class Response
        def initialize(response)
          @response = response
        end

        def [](key)
          @response[key]
        end

        def to_hash
          @response.to_hash
        end

        def original
          @response
        end
      end
    end
  end
end

class Net::HTTP
  def request_with_interceptor_middleware(request, *args, &blk)
    wrapped = HttpIntercept::Clients::NetHttp::Request.new self, request

    HttpIntercept.interceptor.intercept(wrapped) do
      raw = request_without_interceptor_middleware request, *args, &blk
      HttpIntercept::Clients::NetHttp::Response.new raw
    end
  end

  alias request_without_interceptor_middleware request
  alias request request_with_interceptor_middleware
end
