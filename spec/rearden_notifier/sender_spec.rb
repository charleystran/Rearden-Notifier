require 'spec_helper'
require 'active_support'
require 'active_support/core_ext'
require 'net/http'
require 'uri'

describe ReardenNotifier::Sender do
  before(:each) do
    @error = ActiveSupport::Notifications::Event.new("exception.notifier",
        DateTime.parse('2012/02/14 21:35:17'),
        DateTime.parse('2012/02/14 21:35:17'),
        "994506543ad0a9eb51aa",
        {:error_class=>'ActionController::RoutingError', 
        :message=>"No route matches \"/notfound\"",
        :stack=>"big long stack trace", 
        :session=>{"session_id"=>"150df57d212d24fdf237cc89784c5754", "_csrf_token"=>"UjvpKAr9cqgIBWUAWJm8tG+vBXFEp6uimJWrABO1JZE="}, 
        :ip_address=>"127.0.0.1"})
  end

  describe "when properly configured" do
    before(:each) do
      ReardenNotifier.configuration.stubs(:url).returns("http://notreal.com")
      ReardenNotifier.configuration.stubs(:project_key).returns('testing123')
    end

    it "should set the project key when initialized" do
      sender = ReardenNotifier::Sender.new
      sender.project_key.should eq("testing123")
    end

    it "should set the url when initialized" do
      sender = ReardenNotifier::Sender.new
      sender.url.should eq("http://notreal.com")
    end

    it 'should respond to send to notifier' do
      sender = ReardenNotifier::Sender.new
      sender.should respond_to('send_to_notifier')
    end

    it "should send the request to the URL" do
      ReardenNotifier::Sender.any_instance.stubs(:log_response).returns('success')
      URI::Generic.stubs(:request_uri).returns("not@real.com")
      sender = ReardenNotifier::Sender.new
      sender.send_to_notifier(@error)
      FakeWeb.should have_requested(:post, 'http://notreal.com/bugs.xml')
    end

  end

  describe "when not properly configured" do
    it 'should gracefully fail when config url is missing' do
      ReardenNotifier.configuration.stubs(:project_key).returns('testing123')
      ReardenNotifier.configuration.stubs(:url).returns(nil)
      ReardenNotifier::Sender.any_instance.stubs(:log_response).returns('success')
      sender = ReardenNotifier::Sender.new
      sender.send_to_notifier(@error).should eq("Configuration URL missing")
    end

    it 'should gracefully fail when config project_key is missing' do
      ReardenNotifier.configuration.stubs(:project_key).returns(nil)
      ReardenNotifier.configuration.stubs(:url).returns("http://notreal.com")
      ReardenNotifier::Sender.any_instance.stubs(:log_response).returns('success')
      sender = ReardenNotifier::Sender.new
      sender.send_to_notifier(@error).should eq("Configuration project key missing")
    end
  end


end
