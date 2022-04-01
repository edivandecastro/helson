module Service
  class Base
    attr_accessor :context

    def initialize(context=nil)
      self.context = context
    end

    def self.call(*args)
      service = self.new(Service::Context.build(*args))
      service.call
    end
  end
end
