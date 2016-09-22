DataPostLocationSchema = Dry::Validation.Form(ApplicationSchema) do
  required(:latitude).filled(:float?)
  required(:longitude).filled(:float?)
  required(:name).maybe(:str?)
  optional(:timezone).maybe(:str?)
end
