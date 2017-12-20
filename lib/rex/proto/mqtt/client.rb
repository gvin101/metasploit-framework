# -*- coding: binary -*-

require 'mqtt'

##
# MQTT protocol support
##

module Rex
  module Proto
    module MQTT
      class Client

        def initialize(sock, opts = {})
          @sock = sock
          @opts = opts
        end

        def connect
          connect_opts = {
            client_id: @opts[:client_id],
            username: @opts[:username],
            password: @opts[:password]
          }
          connect = ::MQTT::Packet::Connect.new(connect_opts).to_s
          @sock.put(connect)
          res = @sock.get_once(-1, @opts[:read_timeout])
          ::MQTT::Packet.parse(res)
        end

        def connect?
          connect.return_code.zero?
        end

        def disconnect
          disconnect = ::MQTT::Packet::Disconnect.new().to_s
          @sock.put(disconnect)
        end
      end
    end
  end
end
