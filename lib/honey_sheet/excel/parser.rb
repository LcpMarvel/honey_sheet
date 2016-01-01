module HoneySheet
  module Excel
    Data = Struct.new(:value, :type)

    class Parser
      def self.execute(record)
        if record.is_a?(Hash)
          parse_for(record)
        else
          parse(record)
        end
      end

      def self.parse(record)
        Recipe.transform(record)
      end

      # { value: "abc", type: :date_time }
      def self.parse_for(hash)
        return parse(hash) unless hash.key?(:value)

        type = hash.fetch(:type, :string)

        Data.new(hash.fetch(:value), type)
      end
    end
  end
end
