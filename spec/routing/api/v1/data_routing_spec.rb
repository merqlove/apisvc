require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/data').to route_to('api/v1/data#index')
    end

    it 'routes to #create' do
      expect(post: '/data').to route_to('api/v1/data#create')
    end
  end
end
