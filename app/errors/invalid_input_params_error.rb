class InvalidInputParamsError < StandardError
  attr_reader :errors_hash

  def initialize(errors_hash)
   @errors_hash = errors_hash
  end
end