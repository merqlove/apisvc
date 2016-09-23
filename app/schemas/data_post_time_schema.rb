DataPostTimeSchema = Dry::Validation.Form(ApplicationSchema) do
  DATE_REGEX = /\A([0-2][\d]):([0-5][\d])\s([0-3][\d])\.([0-1][\d])\z/

  configure do
    def is_date?(value)
      !DATE_REGEX.match(value).nil?
    end

    def auto_date?(value)
      %w(end beginning).any? { |d| d == value }
    end
  end

  required(:value) { filled? & (is_date? | auto_date?) }
end
