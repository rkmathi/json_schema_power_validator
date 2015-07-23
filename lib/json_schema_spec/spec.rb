require 'json_schema_spec/result'
require 'json_schema_spec/parser'

module JsonSchemaSpec
  class Spec
    def initialize(schema, suite)
      @schema = schema
      @suite  = suite
    end

    def result
      compared_result = compare_suite_and_schema(@schema, @suite)
      compared_results.errors.empty? ? "Success" : compared_results.errors # TODO: return error json
    end

    def is_valid
      compared_result = compare_suite_and_schema(@schema, @suite)
      compared_results.errors.empty? ? true : false
    end

    private

    def compare_suite_and_schema(schema, suites)
      results = Result.new
      suites["examples"].each do |suite|
        validation_response = schema.validate!(suite)
        results.contexts.push(validation_response)
        if validation_response == "error" # TODO
          results.errors.push(validation_response)
        end
      end
      results
    end

    def trim_result_json
      # before return result, trim compared_result as JSON data
    end
  end
end
