module ActionDispatch

  class ShowExceptions

    def render_exception(env, exception)
        log_error(exception)
        exception = original_exception(exception)
        puts '---'
        puts Rails.env.to_s
        if Rails.env.to_s == "production"
          options = {:ip_address => env['REMOTE_ADDR'],:session => env['rack.session']}
          handle_error(exception, options)
        end
        request = Request.new(env)
        if @consider_all_requests_local || request.local?
          rescue_action_locally(request, exception)
        else
          rescue_action_in_public(exception)
        end
      rescue Exception => failsafe_error
        $stderr.puts "Error during failsafe response: #{failsafe_error}\n #{failsafe_error.backtrace * "\n "}"
        FAILSAFE_RESPONSE
      end

    def original_exception(exception)
      if registered_original_exception?(exception)
        exception.original_exception
      else
        exception
      end
    end

    def registered_original_exception?(exception)
      exception.respond_to?(:original_exception) && @@rescue_responses.has_key?(exception.original_exception.class.name)
    end



    def handle_error(exception, options)
    #log_error(exception)
    
      ActiveSupport::Notifications.instrument("exception.notifier", 
        :error_class => exception.class, 
        :message => exception.message,
        :stack => exception.backtrace.join("\n"), 
        :session => options[:session],
        :ip_address => options[:ip_address]) 
        #puts "Env: #{request.env}" 

	  end
  end


end

