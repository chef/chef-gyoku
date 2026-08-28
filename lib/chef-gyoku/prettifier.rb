module Gyoku
  class Prettifier
    DEFAULT_INDENT = 2
    DEFAULT_COMPACT = true

    attr_accessor :indent, :compact

    def self.prettify(xml, options = {})
      new(options).prettify(xml)
    end

    def initialize(options = {})
      @indent = options[:indent] || DEFAULT_INDENT
      @compact = options[:compact].nil? ? DEFAULT_COMPACT : options[:compact]
    end

    # Adds intendations and newlines to +xml+ to make it more readable
    def prettify(xml)
      # Loaded here rather than at the top of the file so that requiring
      # chef-gyoku does not pull in REXML. Only the :pretty_print option
      # reaches this method, and REXML is by far the largest cost of
      # loading this library.
      require "rexml/document" unless defined?(REXML::Document)

      result = ""
      formatter = REXML::Formatters::Pretty.new indent
      formatter.compact = compact
      doc = REXML::Document.new xml
      formatter.write doc, result
      result
    end
  end
end
