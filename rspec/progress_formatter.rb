require_relative 'api'

class RSpec::Core::Formatters::ProgressFormatter
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
    @api ||= API.new
  end
end
