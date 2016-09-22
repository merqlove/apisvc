require 'rails_helper'

RSpec.describe 'Data V1', type: :request do
  describe 'v1 GET /data' do
    it 'returns http success' do
      build(:time_data)
      get '/data', params: {}, headers: { 'accept' => 'application/vnd.apisvc.v1' }, as: :json
      expect(response).to have_http_status(200)
    end

    it 'fallback by default' do
      build(:time_data)
      get '/data', params: {}, as: :json
      expect(response).to have_http_status(200)
    end
  end

  describe 'v2 GET /data' do
    it 'returns 404' do
      build(:time_data)
      expect do
        get '/data', params: {}, headers: { 'accept' => 'application/vnd.apisvc.v2' }, as: :json
      end.to raise_exception(ActionController::RoutingError)
    end
  end

  describe 'v0 GET /data' do
    it 'returns 404' do
      build(:time_data)
      expect do
        get '/data', params: {}, headers: { 'accept' => 'application/vnd.apisvc.v0' }, as: :json
      end.to raise_exception(ActionController::RoutingError)
    end
  end
end
