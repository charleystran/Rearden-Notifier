module ReardenNotifier

	class Sender

		attr_accessor :project_key, :url

		def initialize
			self.url = ReardenNotifier.configuration.url unless ReardenNotifier.configuration.url.blank?
			self.project_key = ReardenNotifier.configuration.project_key unless ReardenNotifier.configuration.project_key.blank?
		end

		def send_to_notifier(event)
      return "Configuration URL missing" if  self.url.blank?
      return "Configuration project key missing" if  self.project_key.blank?
      payload = event.payload
			data = {:error => payload[:error_class].to_s,
              :message => payload[:message].to_s,
              :stack => payload[:stack],
              :session => payload[:session].to_s,
              :ip_address => payload[:ip_address],
              :error_time => event.time - 6.hours,
              :project_key => self.project_key}
			bug = data.to_xml(:root => "bug", :dasherize => false, :skip_types => true, :skip_instruct => true)
		  send_to_host(bug)
		end

		def send_to_host(bug)
			uri = URI.parse("#{self.url}/bugs.xml")
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Post.new(uri.request_uri)
			request.body = bug
			request.set_content_type("text/xml")
			response, data = http.request(request)
			log_response(response.code.to_i, response.message, data)
		end

    def log_response(code, message, data)
			rearden_log ||= Logger.new("#{Rails.root.to_s}/log/rearden_log.log")
			if code >= 200 && code < 300
				rearden_log.info "Success"
			else
				rearden_log.info "#{Time.now} failure: #{message}\n #{data}"
			end
    end

	end

end
