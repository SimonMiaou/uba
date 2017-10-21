module Uba
  Exception = Class.new(StandardError)

  InvalidSchema = Class.new(Exception)
  CouldntInferAggregateId = Class.new(Exception)
end
