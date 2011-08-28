#
class LastFM

  def initialize
  end

  def event(artist, limit = 50, type = 'json', params)
    if artist

      if type.nil?
        type = 'json'
      end

      # id = username.to_s+'_'+type.to_s+'_'+limit.to_s
      id = Digest::MD5.hexdigest(artist.to_s+type.to_s+limit.to_s)

      if type == 'xml'
        begin # Cache valid
          data = $cache.get id
        rescue Memcached::Error # Cache invalid
          response = Net::HTTP.get(URI.parse(URI.encode("http://ws.audioscrobbler.com/2.0/?method=artist.getevents&artist="+artist.to_s+"&autocorrect=1&limit="+limit.to_s+"&api_key=008e54f5a2ba4ed33637a1ca81257f19")))
          $cache.set id, response, 600000
          data = response
        end
      else
        begin
          data = $cache.get id
        rescue Memcached::Error
          response = Net::HTTP.get(URI.parse(URI.encode("http://ws.audioscrobbler.com/2.0/?method=artist.getevents&artist="+artist.to_s+"&autocorrect=1&limit="+limit.to_s+"&api_key=008e54f5a2ba4ed33637a1ca81257f19")))
          data = CobraVsMongoose.xml_to_hash(response).to_json
          $cache.set id, response, 600000
        end
        callback = params.delete('callback')
        if callback
          data = "#{callback}(#{data})"
        end
      end
      data
    else
      "Please enter artist."
    end
  end

end