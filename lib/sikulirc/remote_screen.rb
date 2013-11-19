# require "sikulirc/command"

require "rexml/document"
require "uri"

module Sikulirc
  class RemoteScreen
    include Command
    include REXML
    
    def initialize(server, port="9000")
      @serv = URI("http://#{server}:#{port}/script.do")
    end
    
    def app_focus(app)
      execute_command(@serv, 'set_min_similarity', :content => app)
    end

    def page_down
      execute_command(@serv, "page_down")
    end

    def set_min_similarity(similarity = 0.7)
      execute_command(@serv, 'set_min_similarity', :content => similarity)
    end
    
    def click(psc, timeout = 120)
      execute_command(@serv, "click", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def find(psc)
      execute_command(@serv, 'find', :psc => psc) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def type_in_field(psc, content)
      execute_command(@serv, 'type_in_field', :psc => psc, :content => content) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def wait(psc, timeout = 120)
      execute_command(@serv, "wait", :psc => psc, :timeout => timeout) { |xml_dump| process_result(xml_dump, psc) }
    end
    
    def drag_drop(psc, xoffset, yoffset)
      execute_command(@serv, "drag_drop", :psc => psc, :xoffset => xoffset, :yoffset => yoffset)   
    end
    
    private

    def raise_exception(exception_message, psc)
      if exception_message.include? "FindFailed: can not find"
        raise Sikulirc::ImageNotFound, "The image '#{psc}' does not exist."
      else
        raise Sikulirc::CommandError, "Something wrong with the command.\n\n#{exception_message}" 
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
