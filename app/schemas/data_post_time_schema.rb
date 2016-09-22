DataPostTimeSchema = Dry::Validation.Form(ApplicationSchema) do
  DATE_REGEX = /\A([\d]{2}):([\d]{2})\s([\d]{2})\.([\d]{2})\z/

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
