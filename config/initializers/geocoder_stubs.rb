if Rails.env.development? or Rails.env.test?
  require 'socket'

  def machine_ip
    Socket.ip_address_list.find do |addr_info|
      ( addr_info.ipv4? and not addr_info.ipv4_loopback? ) or
      ( addr_info.ipv6? and not (
          addr_info.ipv6_sitelocal? or
          addr_info.ipv6_linklocal? or
          addr_info.ipv6_linklocal? or
          addr_info.ipv6_loopback?
      ) )
    end.ip_address
  end

  def external_ip
    `curl http://ipecho.net/plain`
  end

  class ActionDispatch::Request
    def location
      @location ||= Geocoder.search(external_ip)
    end
  end
end
