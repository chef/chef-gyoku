require "cgi" unless defined?(CGI)
require "date"

module Gyoku
  module XMLValue
    class << self
      # xs:date format
      XS_DATE_FORMAT = "%Y-%m-%d".freeze

      # xs:time format
      XS_TIME_FORMAT = "%H:%M:%S".freeze

      # xs:dateTime format
      XS_DATETIME_FORMAT = "%Y-%m-%dT%H:%M:%S%Z".freeze

      # Converts a given +object+ to an XML value.
      def create(object, escape_xml = true, options = {})
        case object
        when Time
          object.strftime XS_TIME_FORMAT
        when DateTime
          object.strftime XS_DATETIME_FORMAT
        when Date
          object.strftime XS_DATE_FORMAT
        when String
          escape_xml ? CGI.escapeHTML(object) : object
        when ::Hash
          Gyoku::Hash.to_xml(object, options)
        else
          if object.respond_to?(:to_datetime)
            create object.to_datetime
          elsif object.respond_to?(:call)
            create object.call
          else
            object.to_s
          end
        end
      end
    end
  end
end
