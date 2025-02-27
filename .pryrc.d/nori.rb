module AwesomePrint
  module StringWithAttributes

    def self.included(base)
      base.send :alias_method, :cast_without_swa, :cast
      base.send :alias_method, :cast, :cast_with_swa
    end

    # Add StringWithAttributes class names to the dispatcher pipeline.
    #------------------------------------------------------------------------------
    def cast_with_swa(object, type)
      cast = cast_without_swa(object, type)
      return cast if !defined?(::Nori::StringWithAttributes)

      if object.is_a?(::Nori::StringWithAttributes)
        cast = :swa_instance
      # elsif object.is_a?(::Ripple::Properties)
      #   cast = :ripple_document_class
      end
      cast
    end

    private

    def awesome_swa_instance(object)
      return object.inspect if !defined?(::ActiveSupport::OrderedHash)
      return awesome_object(object) if @options[:raw]

      obj  = "\"#{object}\"".yellowish
      str  = "<StringWithAttributes> (#{obj}) "
      str << awesome_hash(object.attributes) if (object.attributes && object.attributes.size > 0)
      str
    end

  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::StringWithAttributes)
