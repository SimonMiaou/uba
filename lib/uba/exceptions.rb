module Uba
  Exception = Class.new(StandardError)

  ConfigurationMustBeDefined = Class.new(Exception)
  CouldntInferAggregateId = Class.new(Exception)
  InvalidSchema = Class.new(Exception)
end
