require 'rails_helper'

RSpec.describe Api::V1::DataController, type: :controller do
  include_context 'api_v1'
  include ActiveJob::TestHelper

  let(:valid_post_attributes) do
    { type: 'location' }
  end

  let(:invalid_post_attributes) do
    { type: 'eee' }
  end

  let(:valid_location_attributes) do
    { type: 'location', name: 'eee', latitude: 55.000, longitude: 44.0000, timezone: '-03:00' }
  end

  let(:valid_time_attributes) do
    { type: 'time', value: '19:24 11.11' }
  end

  let(:valid_time_end_attributes) do
    { type: 'time', value: 'end' }
  end

  let(:valid_time_beginning_attributes) do
    { type: 'time', value: 'beginning' }
  end

  let(:invalid_time_attributes) do
    { type: 'time', value: '19:24 11.aa' }
  end

  let(:invalid_location_attributes) do
    { type: 'location', name: 'eee', latitude: 'dfdd', longitude: 'dfdd', timezone: 444 }
  end

  let(:valid_attributes) do
    { timezone: 'some' }
  end

  let(:invalid_attributes) do
    { timezone: 444 }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all times as @times within timezone' do
      create(:location_data, name: 'some', timezone: 'Europe/Moscow')
      time_data = create(:time_data)
      get :index, params: valid_attributes, session: valid_session
      expect(response).to have_http_status(:success)
      expect(assigns(:times)).to eq([time_data])
      expect(assigns(:location)).to be_a(LocationData)
      assert_response_schema('data/get.json')
      expect(JSON.parse(response.body)['data'][0]['attributes']['value']).to include('.000+03:00')
    end

    it 'assigns all times as @times with utc' do
      time_data = create(:time_data)
      get :index, params: valid_attributes, session: valid_session
      expect(response).to have_http_status(:success)
      expect(assigns(:times)).to eq([time_data])
      expect(assigns(:location)).to be_nil
      assert_response_schema('data/get.json')
      expect(JSON.parse(response.body)['data'][0]['attributes']['value']).to include('.000Z')
    end

    it 'returns empty array' do
      get :index, params: invalid_attributes, session: valid_session
      expect(response).to have_http_status(:success)
      expect(assigns(:times)).to eq([])
      assert_response_schema('data/get.json')
    end
  end

  describe 'POST #create' do
    context 'time' do
      context 'with valid params' do
        it 'creates a new TimeData' do
          expect do
            post :create, params: valid_time_attributes, session: valid_session
          end.to change(TimeData, :count).by(1)
          expect(response).to have_http_status(200)
          assert_response_schema('data/post.json')
        end

        it 'creates a new TimeData for end of the day' do
          expect do
            post :create, params: valid_time_end_attributes, session: valid_session
          end.to change(TimeData, :count).by(1)
          expect(response).to have_http_status(200)
          assert_response_schema('data/post.json')
        end

        it 'creates a new TimeData for beginning of the day' do
          expect do
            post :create, params: valid_time_beginning_attributes, session: valid_session
          end.to change(TimeData, :count).by(1)
          expect(response).to have_http_status(200)
          assert_response_schema('data/post.json')
        end

        it 'assigns a newly created time_data as @time_data' do
          post :create, params: valid_time_attributes, session: valid_session
          expect(response).to have_http_status(200)
          expect(assigns(:time_data)).to be_a(TimeData)
          expect(assigns(:time_data)).to be_persisted
          expect(assigns(:time_data).value.time_zone.name).to eq('UTC')
          assert_response_schema('data/post.json')
        end
      end

      context 'with invalid params' do
        it 'unsaved time_data as @time_data' do
          post :create, params: invalid_time_attributes, session: valid_session
          expect(response).to have_http_status(422)
          expect(assigns(:time_data)).to be_a(TimeData)
          expect(JSON.parse(response.body)['errors'].keys).to eq(['value'])
          assert_response_schema('data/error.json')
        end

        it 'error 422 on invalid hours format' do
          post :create, params: { type: 'time', value: '55:24 11.11' }, session: valid_session
          expect(response).to have_http_status(422)
          expect(assigns(:time_data)).to be_a(TimeData)
          expect(JSON.parse(response.body)['errors'].keys).to eq(['value'])
          assert_response_schema('data/error.json')
        end

        it 'error 422 on invalid month format' do
          post :create, params: { type: 'time', value: '15:24 11.15' }, session: valid_session
          expect(response).to have_http_status(422)
          expect(assigns(:time_data)).to be_a(TimeData)
          expect(JSON.parse(response.body)['errors'].keys).to eq(['value'])
          assert_response_schema('data/error.json')
        end

        it 'error 422 on valid but wrong time format' do
          post :create, params: { type: 'time', value: '25:24 11.11' }, session: valid_session
          expect(response).to have_http_status(422)
          expect(assigns(:time_data)).to be_a(TimeData)
          expect(JSON.parse(response.body)['errors'].keys).to eq(['value'])
          assert_response_schema('data/error.json')
        end
      end
    end
    context 'location' do
      context 'with valid params' do
        it 'creates a new LocationData' do
          expect do
            post :create, params: valid_location_attributes, session: valid_session
          end.to have_enqueued_job(LocationUpdateJob)
          expect(response).to have_http_status(200)
          assert_response_schema('data/post.json')
        end
      end

      context 'with invalid params' do
        it 'unsaved time_data as @time_data' do
          post :create, params: invalid_location_attributes, session: valid_session
          expect(response).to have_http_status(422)
          expect(JSON.parse(response.body)['errors'].keys).to eq(%w(latitude longitude))
          assert_response_schema('data/error.json')
        end
      end
    end
    context 'with valid type params' do
      it 'creates a new TimeData' do
        post :create, params: valid_post_attributes, session: valid_session
        expect(response).to have_http_status(422)
        assert_response_schema('data/error.json')
        expect(JSON.parse(response.body)['errors'].keys).not_to include('type')
      end
    end
    context 'with invalid type params' do
      it 'assigns a newly created but unsaved post as @post' do
        post :create, params: invalid_post_attributes, session: valid_session
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['errors'].keys).to include('type')
        assert_response_schema('data/error.json')
      end
    end
  end
end
