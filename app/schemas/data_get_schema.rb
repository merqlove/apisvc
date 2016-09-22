DataGetSchema = Dry::Validation.Form(ApplicationSchema) do
  optional(:timezone).maybe(:str?)
end
