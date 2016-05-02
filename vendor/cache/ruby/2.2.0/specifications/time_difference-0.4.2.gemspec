# -*- encoding: utf-8 -*-
# stub: time_difference 0.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "time_difference"
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["TM Lee"]
  s.date = "2015-03-24"
  s.description = "TimeDifference is the missing Ruby method to calculate difference between two given time. You can do a Ruby time difference in year, month, week, day, hour, minute, and seconds."
  s.email = ["tmlee.ltm@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "TimeDifference is the missing Ruby method to calculate difference between two given time. You can do a Ruby time difference in year, month, week, day, hour, minute, and seconds."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
