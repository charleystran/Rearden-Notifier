module ReardenNotifier
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def create_intializer
      template 'initializer/rearden_notifier.rb', 'config/initializers/rearden_notifer.rb'
    end

  end
end
