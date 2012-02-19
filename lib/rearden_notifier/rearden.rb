module ReardenNotifier
  class Railtie < Rails::Railtie

    initializer "rearden.initialize" do |app|
 
      ActiveSupport::Notifications.subscribe "exception.notifier" do |*args|
        if Rails.env.to_s == "production"
          event = ActiveSupport::Notifications::Event.new(*args)
          sender = Sender.new
          sender.send_to_notifier(event)
        end
      end

    end
  end
end

