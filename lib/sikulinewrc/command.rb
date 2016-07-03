require 'net/http'

module Sikulinewrc
  module Command
    
    COMMANDS = {}
    
    def self.load
      Dir.foreach(File.expand_path("../commands/", __FILE__)) do |file_name|
        if file_name == ".." or file_name == "."
          next
        end
        cmd = {}
        File.open(File.expand_path("../commands/#{file_name}", __FILE__)).each_with_index do |line, index|
          cmd["cmd#{index}"] = line.tr("\n", '')
        end
        COMMANDS[file_name] = cmd
      end
    end
    
    load
    
    def execute_command(uri, cmd_name, args_hash=nil, &block)
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(args_hash.nil? ? {"type"=> "sikuli"}.merge(COMMANDS.fetch(cmd_name)) : {"type"=> "sikuli"}.merge(COMMANDS.fetch(cmd_name)).merge(build_arg(args_hash)))
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end
      if block_given?
        yield res.body
      else
        res.body
      end
    end
    
    private
    
    def build_arg(args_hash)
      arg = Hash['args' => '|']
      args_hash.each do |k, v|
        arg['args'] = arg['args'] + "#{k}=#{v}|"
      end
      arg
    end
    
  end
end
