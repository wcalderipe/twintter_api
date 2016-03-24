class NotAuthorizedError < ApplicationError
  def initialize
    @status = 401
    @class = :NotAuthorizedError
    super('Not authorized')
  end
end
