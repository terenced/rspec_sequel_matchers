module RspecSequel

  class Base
    def initialize(attribute, options={})
      @attribute = attribute.to_sym
      @options = options
      @description = []
    end
    def matches?(target)
      @suffix = []
      if target.is_a?(Sequel::Model)
        @prefix = "expected #{target.inspect} to"
        valid?(target.db, target, target.class, @attribute, @options)
      else
        name = target.name
        name = target.table_name if name.nil? || name==""
        @prefix = "expected #{name} to"
        valid?(target.db, target.new, target, @attribute, @options)
      end
    end
    def failure_message
      [@prefix, description, @suffix].flatten.compact.join(" ")
    end
    def negative_failure_message
      [@prefix, "not", description, @suffix].flatten.compact.join(" ")
    end
    def hash_to_nice_string(hash)
      hash.sort.collect{|param| param.join(" => ")}.join(", ")
    end
  end

end