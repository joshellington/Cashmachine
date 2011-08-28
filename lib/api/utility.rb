#
class Utility
  def initialize
  end

  def hash(str)
    Digest::MD5.hexdigest(str)
  end

  def delete(key)
    begin
      $cache.delete key
      "success"
    rescue Memcached::Error
      "key does not exist"
    end
  end

  # def set_type(type)
  #   if 'xml'
  #     content_type 'text/xml', :charset => 'utf-8'
  #   else
  #     content_type 'application/json', :charset => 'utf-8'
  #   end
  # end

end