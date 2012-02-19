# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rearden_notifier/version"

Gem::Specification.new do |s|
  s.name        = "rearden_notifier"
  s.version     = ReardenNotifier::VERSION
  s.authors     = ["Charley Stran"]
  s.email       = ["charley.stran@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Gem that sends error reports to a Rearden error tracking app}
  s.description = %q{Gem that sends error reports to a Rearden error tracking app}

  s.rubyforge_project = "rearden_notifier"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "fakeweb-matcher"
  # s.add_runtime_dependency "rest-client"
end
