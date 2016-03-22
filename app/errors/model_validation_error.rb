class ModelValidationError < ApplicationError
  def initialize(errors)
    @status = 422
    @class = :ModelValidationError
    super(errors.messages.to_json)
  end
end
