DataPostSchema = Dry::Validation.Form(ApplicationSchema) do
  configure do
    def location_or_time?(value)
      %w(location time).any? { |lt| lt == value }
    end
  end

  required(:type) { filled? & str? & location_or_time? }
end
