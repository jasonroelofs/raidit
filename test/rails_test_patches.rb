##
# Monkey patch some things in the Rails testing framework
##

##
# assert_block is deprecated, fix assert_response
##
module ActionDispatch
  module Assertions
    module ResponseAssertions
      def assert_response(type, message = nil)
        message ||= "Expected response to be a <#{type}>, but was <#{@response.response_code}>"

        if Symbol === type
          if [:success, :missing, :redirect, :error].include?(type)
            assert @response.send("#{type}?"), message
          else
            code = Rack::Utils::SYMBOL_TO_STATUS_CODE[type]
            assert_equal @response.response_code, code, message
          end
        else
          assert_equal type, @response.response_code, message
        end
      end
    end
  end
end

##
# assert_block is deprecated, fix assert_template
##
module ActionController
  module TemplateAssertions
    def assert_template(options = {}, message = nil)
      validate_request!

      case options
      when NilClass, String, Symbol
        options = options.to_s if Symbol === options
        rendered = @templates
        msg = build_message(message,
                "expecting <?> but rendering with <?>",
                options, rendered.keys.join(', '))
        ## This was assert_block
        if options
          assert rendered.any? { |t,num| t.match(options) }
        else
          assert @templates.blank?
        end
        ## end
      when Hash
        if expected_layout = options[:layout]
          msg = build_message(message,
                  "expecting layout <?> but action rendered <?>",
                  expected_layout, @layouts.keys)

          case expected_layout
          when String
            assert(@layouts.keys.include?(expected_layout), msg)
          when Regexp
            assert(@layouts.keys.any? {|l| l =~ expected_layout }, msg)
          when nil
            assert(@layouts.empty?, msg)
          end
        end

        if expected_partial = options[:partial]
          if expected_locals = options[:locals]
            actual_locals = @locals[expected_partial.to_s.sub(/^_/,'')]
            expected_locals.each_pair do |k,v|
              assert_equal(v, actual_locals[k])
            end
          elsif expected_count = options[:count]
            actual_count = @partials[expected_partial]
            msg = build_message(message,
                    "expecting ? to be rendered ? time(s) but rendered ? time(s)",
                     expected_partial, expected_count, actual_count)
            assert(actual_count == expected_count.to_i, msg)
          else
            msg = build_message(message,
                    "expecting partial <?> but action rendered <?>",
                    options[:partial], @partials.keys)
            assert(@partials.include?(expected_partial), msg)
          end
        else
          assert @partials.empty?,
            "Expected no partials to be rendered"
        end
      end
    end
  end
end

