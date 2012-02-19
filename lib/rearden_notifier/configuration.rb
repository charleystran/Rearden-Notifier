module ReardenNotifier

	class Configuration
	
		OPTIONS = [:project_key, :url].freeze

		attr_accessor :project_key, :url

		def initialize

		end

	end

end
