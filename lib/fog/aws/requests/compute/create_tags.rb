module Fog
  module AWS
    class Compute
      class Real

        # Adds tags to resources
        #
        # ==== Parameters
        # * resources<~String> - One or more resources to tag
        # * tags<~String> - hash of key value tag pairs to assign
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'requestId'<~String> - Id of request
        #     * 'return'<~Boolean> - success?
        def create_tags(resources, tags)
          resources = [*resources]
          for key, value in tags
            if value.nil?
              tags[key] = ''
            end
          end
          params = {}
          params.merge!(AWS.indexed_param('ResourceId', resources))
          params.merge!(AWS.indexed_param('Tag.%d.Key', tags.keys))
          params.merge!(AWS.indexed_param('Tag.%d.Value', tags.values))
          request({
            'Action'            => 'CreateTags',
            :parser             => Fog::Parsers::AWS::Compute::Basic.new
          }.merge!(params))
        end

      end

      class Mock

        def create_tags(resources, tags)
          Fog::Mock.not_implemented
        end

      end
    end
  end
end
