#
class Facebook

  def initialize
  end

  def photos(id, params)
    if id
      begin
        pp "Cache valid"
        data = $cache.get id
      rescue Memcached::Error
        pp "Cache invalid"
        response = Net::HTTP.get(URI.parse("http://graph.facebook.com/"+id.to_s+"/photos"))
        $cache.set id, response, 900000
        data = JSON.parse(response).to_json
      end
      callback = params.delete('callback')
      if callback
        data = "#{callback}(#{data})"
      end
      data
    else
      "No ID."
    end
  end

end