#
class YQL

  def initialize
  end

  def query(q, params)
    id = Digest::MD5.hexdigest(q).upcase
    begin
      pp "Cache valid"
      data = $cache.get id
    rescue Memcached::Error
      query = URI.escape( q, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]") ).gsub('*', '%2A')
      response = Net::HTTP.get(URI.parse("http://query.yahooapis.com/v1/public/yql?q="+query+"&format=json"))
      $cache.set id, response, 900000
      data = JSON.parse(response).to_json
    end
    callback = params.delete('callback')
    if callback
      data = "#{callback}(#{data})"
    end
    data
  end

  def percent_encode( string )
    return URI.escape( string, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]") ).gsub('*', '%2A')
  end

end