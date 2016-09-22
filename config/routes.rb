Rails.application.routes.draw do
  root 'welcome#index'

  def data_version(version, default = false, &routes)
    api_constraint = Constraints::ApiConstraint.new(version: version, default: default)
    scope(module: "v#{version}", constraints: api_constraint, &routes)
  end

  scope :data, module: 'api', constraints: { format: 'json' } do
    data_version(1, true) do
      get '/', to: 'data#index', as: :data
      post '/', to: 'data#create'
    end
  end
end
