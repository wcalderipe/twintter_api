class RoutingError < ApplicationError
  def initialize
    @status = 404
    @class = :RoutingError
    super('Endpoint requestd not found.')
  end
end
