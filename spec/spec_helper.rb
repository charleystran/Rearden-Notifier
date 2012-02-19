require 'rearden_notifier'
require 'fakeweb'
require 'fakeweb_matcher'

RSpec.configure do |config|
  config.mock_with :mocha
  config.before(:each) do
    FakeWeb.allow_net_connect = false
    
    FakeWeb.register_uri :post, "http://notreal.com/bugs.xml", :body => "Success"
  end
end

def fakeweb_path(filename)
  File.expand_path(File.join(File.dirname(__FILE__), 'fakeweb', filename))
end
