module ActiveInteraction
  # @!macro [new] attribute_method_params
  #   @param *attributes [Symbol] One or more attributes to create.
  #   @param options [Hash]
  #   @option options [Boolean] :allow_nil Allow a `nil` value.
  #   @option options [Object] :default Value to use if `nil` is given.

  # @private
  class Filter
    def self.factory(type)
      klass = "#{type.to_s.camelize}Filter"

      raise NoMethodError unless ActiveInteraction.const_defined?(klass)

      ActiveInteraction.const_get(klass)
    end

    def self.prepare(key, value, options = {}, &block)
      case value
        when NilClass
          return_nil(options[:allow_nil])
        else
          bad_value
      end
    end

    def self.return_nil(allow_nil)
      if allow_nil
        nil
      else
        raise MissingValue
      end
    end
    private_class_method :return_nil

    def self.bad_value
      raise InvalidValue
    end
    private_class_method :bad_value
  end
end
