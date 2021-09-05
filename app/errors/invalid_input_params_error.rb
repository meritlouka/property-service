class InvalidInputParamsError < StandardError
  def initialize(msg = "Invalid Data")
    super
  end
end