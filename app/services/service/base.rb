module Service
  class Base
    attr_accessor :context

    def self.call(*args)
      service = self.new
      service.context = Service::Context.new(*args)
      service.call
    end
  end
end
