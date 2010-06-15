require 'tokyo_messenger'

module TokyoMessenger
  module DualMaster
    class NoServersAvailable < StandardError; end
    class DB
      def initialize(servers = [], failure_retry_period = 30)
        raise "Too many servers" if servers.size > 2
        @servers              = servers
        @failure_retry_period = failure_retry_period 
        @failed_servers       = {}
        @current_connection   = nil
      end

      def current_connection
        @current_connection ||= make_connection
      end

      def current_server
        current_connection.server
      end
      
      def method_missing(method_name, *args, &block)
        current_connection.send(method_name, *args)
      rescue TokyoMessengerError
        fail_current_server
        retry
      end

      private

      def available_server
        @servers.sort_by { rand }.find { |s| server_available?(s) }
      end

      def make_connection
        s = available_server
        raise NoServersAvailable if s.nil?
        connect_to(s)
      rescue TokyoMessengerError
        fail_server(s)
        retry
      end

      def connect_to(s)
        host, port = s.split(':')
        TokyoMessenger::DB.new(host, port.to_i)
      end

      def fail_current_server
        fail_server(current_server)
      end

      def fail_server(s)
        @current_connection = nil
        @failed_servers[s] = Time.now
      end

      def server_available?(s)
        @failed_servers[s].nil? || retry_failed_server?(s)
      end

      def retry_failed_server?(s)
        (@failed_servers[s] + @failure_retry_period) < Time.now
      end
    end
  end
end
