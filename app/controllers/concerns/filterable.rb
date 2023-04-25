module Filterable
  def filter!(resource, filter_params)
    apply_filters(resource, filter_params)
  end

  private

  def apply_filters(resource, filter_params)
    resource_class = resource.to_s.classify.constantize
    resource_class.filter(filter_params)
  end
end
