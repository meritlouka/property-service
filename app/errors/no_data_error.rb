class NoDataError < StandardError
  def initialize(msg = "No data")
    super
  end
end