begin
  require 'awesome_print'
  AwesomePrint.pry!

  module AwesomePrint
  module ActiveRecordEx

    def self.included(base)
      base.send :alias_method, :cast_without_active_model_error, :cast
      base.send :alias_method, :cast, :cast_with_active_model_error
    end

    def cast_with_active_model_error(object, type)
      cast = cast_without_active_model_error(object, type)
      return cast if !defined?(::ActiveRecord::Base)

      if object.is_a?(::ActiveModel::Errors)
        cast = :active_model_error
      end
      cast
    end

    def awesome_active_model_error(object)
      return object.inspect if !defined?(::ActiveSupport::OrderedHash)
      return awesome_object(object) if @options[:raw]

      data = {}
      data.merge!({details: object.details, messages: object.messages})
      "#{object} #{awesome_hash(data)}"
    end
  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::ActiveRecordEx)

rescue LoadError
  handle_load_error 'awesome_print'
end

