module HttpIntercept
  class Interceptor
    attr_accessor :visitors

    def initialize
      @visitors = []
    end

    def intercept(request)
      resp = nil
      initial = proc do
        resp = yield
      end

      app = visitors.reduce(initial) do |memo, vis|
        proc { vis.call(request, memo) }
      end

      app.call
      resp.original
    end
  end
end
