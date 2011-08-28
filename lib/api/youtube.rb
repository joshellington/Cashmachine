#
class Youtube

  def initialize
  end

  def playlist(id, limit = 25, params)
    if id
      begin
        pp "Cache valid"
        data = $cache.get id+'_'+limit.to_s
      rescue Memcached::Error
        pp "Cache invalid"
        response = Net::HTTP.get(URI.parse("http://gdata.youtube.com/feeds/api/playlists/"+id.to_s+"?v=2&alt=jsonc&count="+limit.to_s))
        $cache.set id+'_'+limit.to_s, response, 900000
        data = JSON.parse(response).to_json
      end
      callback = params.delete('callback')
      if callback
        data = "#{callback}(#{data})"
      end
      # content_type :json
      data
    else
      "No ID."
    end
  end

end