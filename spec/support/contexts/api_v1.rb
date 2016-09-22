require 'spec_helper'

RSpec.shared_context 'api_v1' do
  # let(:schema_url_prefix) { '/data' }

  before :each do
    request.headers.merge!('Accept' => 'application/vnd.apisvc.v1')
  end
end
