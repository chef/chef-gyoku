require "builder"
require "chef-gyoku/prettifier"
require "chef-gyoku/array"
require "chef-gyoku/xml_key"
require "chef-gyoku/xml_value"

module Gyoku
  module Hash
    module_function

    # Builds XML and prettifies it if +pretty_print+ option is set to +true+
    def to_xml(hash, options = {})
      xml = build_xml(hash, options)

      if options[:pretty_print]
        Prettifier.prettify(xml, options)
      else
        xml
      end
    end

    # Translates a given +hash+ with +options+ to XML.
    def build_xml(hash, options = {})
      iterate_with_xml hash do |xml, key, value, attributes|
        self_closing = key.to_s[-1, 1] == "/"
        escape_xml = key.to_s[-1, 1] != "!"
        xml_key = XMLKey.create key, options

        if :content! === key
          xml << XMLValue.create(value, escape_xml, options)
        elsif ::Array === value
          xml << Array.build_xml(value, xml_key, escape_xml, attributes, options.merge(self_closing: self_closing))
        elsif ::Hash === value
          xml.tag!(xml_key, attributes) { xml << build_xml(value, options) }
        elsif self_closing
          xml.tag!(xml_key, attributes)
        elsif NilClass === value
          xml.tag!(xml_key, "xsi:nil" => "true")
        else
          xml.tag!(xml_key, attributes) { xml << XMLValue.create(value, escape_xml, options) }
        end
      end
    end

    def explicit_attribute?(key)
      key.to_s.start_with?("@")
    end

    # Iterates over a given +hash+ and yields a builder +xml+ instance, the current
    # Hash +key+ and any XML +attributes+.
    #
    # Keys beginning with "@" are treated as explicit attributes for their container.
    # You can use both :attributes! and "@" keys to specify attributes.
    # In the event of a conflict, the "@" key takes precedence.
    def iterate_with_xml(hash)
      xml = Builder::XmlMarkup.new
      attributes = hash[:attributes!] || {}
      hash_without_attributes = hash.except(:attributes!)

      order(hash_without_attributes).each do |key|
        node_attr = attributes[key] || {}
        # node_attr must be kind of ActiveSupport::HashWithIndifferentAccess
        node_attr = node_attr.map { |k, v| [k.to_s, v] }.to_h
        node_value = hash[key].respond_to?(:keys) ? hash[key].clone : hash[key]

        if node_value.respond_to?(:keys)
          explicit_keys = node_value.keys.select { |k| explicit_attribute?(k) }
          explicit_attr = {}
          explicit_keys.each { |k| explicit_attr[k.to_s[1..]] = node_value[k] }
          node_attr.merge!(explicit_attr)
          explicit_keys.each { |k| node_value.delete(k) }

          tmp_node_value = node_value.delete(:content!)
          node_value = tmp_node_value unless tmp_node_value.nil?
          node_value = "" if node_value.respond_to?(:empty?) && node_value.empty?
        end

        yield xml, key, node_value, node_attr
      end

      xml.target!
    end
    private_class_method :iterate_with_xml

    # Deletes and returns an Array of keys stored under the :order! key of a given +hash+.
    # Defaults to return the actual keys of the Hash if no :order! key could be found.
    # Raises an ArgumentError in case the :order! Array does not match the Hash keys.
    def order(hash)
      order = hash[:order!] || hash.delete("order!")
      hash_without_order = hash.except(:order!)
      order = hash_without_order.keys unless order.is_a? ::Array

      # Ignore Explicit Attributes
      orderable = order.delete_if { |k| explicit_attribute?(k) }
      hashable = hash_without_order.keys.select { |k| !explicit_attribute?(k) }

      missing, spurious = hashable - orderable, orderable - hashable
      raise ArgumentError, "Missing elements in :order! #{missing.inspect}" unless missing.empty?
      raise ArgumentError, "Spurious elements in :order! #{spurious.inspect}" unless spurious.empty?

      order
    end
    private_class_method :order
  end
end
