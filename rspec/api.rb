require 'uri'
require 'net/http'
require 'singleton'

class API
  include Singleton

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
