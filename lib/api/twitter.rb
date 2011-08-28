#
class Twitter

  def initialize
  end

  def user_timeline(username, limit = 25, type = 'json', params = nil)
    if username

      if type.nil?
        type = 'json'
      end

      # id = username.to_s+'_'+type.to_s+'_'+limit.to_s
      id = username.to_s+type.to_s+limit.to_s

      if type == 'xml'
        begin # Cache valid
          data = $cache.get id
        rescue Memcached::Error # Cache invalid
          response = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/user_timeline."+type.to_s+"?include_entities=true&include_rts=true&screen_name="+username+"&count="+limit.to_s))
          $cache.set id, response, 300000
          data = response
        end
      else
        begin
          data = $cache.get id
        rescue Memcached::Error
          response = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/user_timeline."+type.to_s+"?include_entities=true&include_rts=true&screen_name="+username+"&count="+limit.to_s))
          data = JSON.parse(response).to_json
          $cache.set id, response, 300000
        end
        callback = params.delete('callback')
        if callback
          data = "#{callback}(#{data})"
        end
      end
      data
    else
      "Please enter username."
    end
  end

  def search(query, limit = 25, type = "json", params = nil)
    if query

      if type.nil?
        type = 'json'
      end

      # id = username.to_s+'_'+type.to_s+'_'+limit.to_s
      id = Digest::MD5.hexdigest(username.to_s+type.to_s+limit.to_s)

      if type == "xml"
        begin
          data = $cache.get id
        rescue Memcached::Error
          response = Net::HTTP.get(URI.parse("http://search.twitter.com/search."+type.to_s+"?q="+query+"&result_type=mixed&rpp="+limit.to_s))
          $cache.set id, response, 300000
          data = response
        end
      else
        begin
          data = $cache.get id
        rescue Memcached::Error
          response = Net::HTTP.get(URI.parse("http://search.twitter.com/search."+type.to_s+"?q="+query+"&result_type=mixed&rpp="+limit.to_s))
          $cache.set id, response, 300000
          data = JSON.parse(response).to_json
        end
        callback = params.delete('callback')
        if callback
          data = "#{callback}(#{data})"
        end
      end
      data
    else
      "Please enter username."
    end
  end
  
end