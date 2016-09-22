module Api
  module V1
    class DataController < ApplicationController
      before_action :set_location, only: [:index]

      def index
        if index_params.success?
          Time.use_zone(@location&.timezone || 'Etc/UTC') do
            @times = TimeData.all
            render json: @times
          end
        else
          render json: { errors: index_params.messages }, status: :unprocessable_entity
        end
      end

      def create
        render json: { errors: type_params.messages }, status: :unprocessable_entity unless type_params.success?

        case type_params.output[:type]
        when 'time'
          post_time
        when 'location'
          post_location
        end
      end

      private

      def post_time
        render json: { errors: time_params.messages }, status: :unprocessable_entity unless time_params.success?

        data = time_params.output
        data[:value] = TimeHelpers.prepare_time_value(data[:value])
        @time_data = TimeData.new(data)
        if @time_data.save
          render json: { success: true }, status: :ok
        else
          render json: { errors: @time_data.errors }, status: :unprocessable_entity
        end
      end

      def post_location
        if location_params.success?
          LocationUpdateJob.perform_later(location_params.output)
          render json: { success: true }, status: :ok
        else
          render json: { errors: location_params.messages }, status: :unprocessable_entity
        end
      end

      def set_location
        @location = LocationData.find_by(name: index_params.output[:timezone])
      end

      def type_params
        DataPostSchema.call(params.as_json)
      end

      def time_params
        DataPostTimeSchema.call(params.as_json)
      end

      def location_params
        DataPostLocationSchema.call(params.as_json)
      end

      def index_params
        DataGetSchema.call(params.as_json)
      end
    end
  end
end
