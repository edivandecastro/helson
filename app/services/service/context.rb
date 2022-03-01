module Service
  class Context < OpenStruct

    def self.build(context = {})
      self === context ? context : new(context)
    end

    def fail!(context = {})
      context.each { |key, value| self[key.to_sym] = value }
      @failure = true
      raise Service::Failure, self
    end

    def fail(context = {})
      context.each { |key, value| self[key.to_sym] = value }
      @failure = true
    end

    def failure?
      @failure || false
    end

    def success?
      !failure?
    end
  end
end
