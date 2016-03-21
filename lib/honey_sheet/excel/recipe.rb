module HoneySheet
  module Excel
    class Recipe
      def self.transform(value)
        method_name = value.class.to_s.underscore

        fetch("#{method_name}_recipe", value)
      end

      def self.fetch(formula, value)
        respond_to?(formula) ? public_send(formula, value) : string_recipe(value)
      end

      def self.string_recipe(value)
        Data.new(value, DataTag::TYPES.fetch(:string))
      end

      # def self.true_class_recipe(value)
      #   Data.new(value, DataTag::TYPES.fetch(:boolean))
      # end

      def self.date_time_recipe(date_time)
        Data.new(date_time.strftime('%Y-%m-%d %H:%M:%S'), DataTag::TYPES.fetch(:string))
      end

      def self.date_recipe(date)
        Data.new(date.to_s, DataTag::TYPES.fetch(:string))
      end

      def self.fixnum_recipe(number)
        Data.new(number, DataTag::TYPES.fetch(:number))
      end

      def self.array_recipe(array)
        Data.new(array.join(', '), DataTag::TYPES.fetch(:string))
      end

      def self.hash_recipe(hash)
        value = hash.inject([]) do |arr, (k, v)|
          if v.is_a?(Array)
            arr << "#{k}: #{v.join(', ')}"
          else
            arr << "#{k}: #{v}"
          end
        end

        Data.new(value.join('; '), DataTag::TYPES.fetch(:string))
      end

      def self.range_recipe(range)
        Data.new(range.to_a.join(', '), DataTag::TYPES.fetch(:string))
      end

      class << self
        # alias_method :false_class_recipe, :true_class_recipe

        alias_method :time_recipe, :date_time_recipe

        alias_method :integer_recipe, :fixnum_recipe
        alias_method :float_recipe, :fixnum_recipe
      end
    end
  end
end
