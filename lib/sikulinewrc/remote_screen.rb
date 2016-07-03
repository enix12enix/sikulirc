# require "sikulinewrc/command"

require "rexml/document"
require "uri"

module Sikulinewrc
  class RemoteScreen
    include Command
    include REXML
    
    def initialize(server, port="9000")
      @serv = URI("http://#{server}:#{port}/script.do")
    end
    
    def app_focus(content)
      execute_command(@serv, 'app_focus', :content => content)
    end

    def page_down
      execute_command(@serv, "page_down")
    end

    def set_min_similarity(similarity = 0.7)
      execute_command(@serv, 'set_min_similarity', :similarity => similarity)
    end
    
    def click(psc, timeout = 30)
      execute_command(@serv, "click", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def double_click(psc, timeout = 30)
      execute_command(@serv, "double_click", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def right_click(psc, timeout = 30)
      execute_command(@serv, "right_click", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def find(psc)
      execute_command(@serv, 'find', :psc => psc) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def type_in_field(psc, content)
      execute_command(@serv, 'type_in_field', :psc => psc, :content => content) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def wait(psc, timeout = 30)
      execute_command(@serv, "wait", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def drag_drop(psc, xoffset, yoffset)
      execute_command(@serv, "drag_drop", :psc => psc, :xoffset => xoffset, :yoffset => yoffset)   
    end
    
    def click_location(xoffset, yoffset)
      execute_command(@serv, "click_location", :xoffset => xoffset, :yoffset => yoffset)   
    end
    
    def send_alt_combkey(prskey)
      execute_command(@serv, "send_alt_combkey", :prskey => prskey)
    end
    
    def send_ctrl_combkey(prskey)
      execute_command(@serv, "send_ctrl_combkey", :prskey => prskey)
    end
    
    def exists(psc, timeout = 30)
      execute_command(@serv, "exists", :psc => psc, :timeout => timeout)
    end

    private

    def raise_exception(exception_message, psc)
      if exception_message.include? "FindFailed: can not find"
        raise Sikulinewrc::ImageNotFound, "The image '#{psc}' does not exist."
      else
        raise Sikulinewrc::CommandError, "Something wrong with the command.\n\n#{exception_message}" 
      end
    end

    def process_result(xml_dump, psc)
      doc = Document.new(xml_dump)
      if doc.elements["/script/status"].text == "FAIL"
        raise_exception(doc.elements["//message"].text, psc)
      end
    end
    
  end 
end
