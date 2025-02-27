module AwesomePrint
  module Paperclip

    def self.included(base)
      base.send :alias_method, :cast_without_paperclip, :cast
      base.send :alias_method, :cast, :cast_with_paperclip
    end

    # Add Paperclip class names to the dispatcher pipeline.
    #------------------------------------------------------------------------------
    def cast_with_paperclip(object, type)
      cast = cast_without_paperclip(object, type)
      return cast if !defined?(::Paperclip)

      if object.is_a?(::Paperclip::Attachment)
        cast = :paperclip_attachment_instance
      elsif object.is_a?(::Class) && object.name == 'Paperclip::Attachment'
        cast = :paperclip_attachment_class
      end
      cast
    end

    private

    # Format Paperclip::Attachment instance object.
    #
    def awesome_paperclip_attachment_instance(object)
      data = {
        name:              object.name,
        original_filename: object.original_filename,
        size:              object.size
      }

      "#{object.class.name} " << awesome_hash(data)
    end

    # Format Ripple class object.
    #------------------------------------------------------------------------------
    def awesome_paperclip_attachment_class(object)
      data = object.default_options
      name = "class #{awesome_simple(object.to_s, :class)}"
      base = "< #{awesome_simple(object.superclass.to_s, :class)}"

      [name, base, awesome_hash(data)].join(' ')
    end
  end
end

AwesomePrint::Formatter.send(:include, AwesomePrint::Paperclip)
