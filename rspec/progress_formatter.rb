require 'rspec/core/formatters/progress_formatter'
require 'uri'
require 'net/http'

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

class API
  attr_accessor :status

  def started
    light(:yellow)
  end

  def failed
    light(:red)
  end

  def finished
    light(:green) if yellow?
  end

  private

  def light(color)
    uri = uri(color)
    Net::HTTP.new(uri.host, uri.port).get(uri.path, {})
  end

  def uri(color)
    URI("http://localhost:3000/#{color}")
  end

  def yellow?
    status == :yellow
  end
end
