require_relative 'api'

class LightFormatter
  RSpec::Core::Formatters.register self, :start, :example_failed, :close

  def initialize(output)
    @output = output
  end

  def start(_notification)
    set(:started)
  end

  def example_failed(_notification)
    set(:failed)
  end

  def close(_notification)
    set(:finished)
  end

  def set(status)
    api.send(status)
  end

  def api
    @api ||= API.instance
  end
end
