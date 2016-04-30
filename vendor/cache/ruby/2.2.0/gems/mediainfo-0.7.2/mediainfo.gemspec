# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mediainfo}
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Seth Thomas Rasmussen}]
  s.date = %q{2011-05-13}
  s.description = %q{Mediainfo is a class wrapping the mediainfo CLI (http://mediainfo.sourceforge.net)}
  s.email = %q{sethrasmussen@gmail.com}
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.markdown}, %q{lib/mediainfo.rb}, %q{lib/mediainfo/attr_readers.rb}, %q{lib/mediainfo/string.rb}]
  s.files = [%q{Changelog}, %q{LICENSE}, %q{Manifest}, %q{README.markdown}, %q{Rakefile}, %q{index.html.template}, %q{lib/mediainfo.rb}, %q{lib/mediainfo/attr_readers.rb}, %q{lib/mediainfo/string.rb}, %q{mediainfo.gemspec}, %q{test/mediainfo_awaywego_test.rb}, %q{test/mediainfo_broken_embraces_test.rb}, %q{test/mediainfo_dinner_test.rb}, %q{test/mediainfo_hats_test.rb}, %q{test/mediainfo_multiple_streams_test.rb}, %q{test/mediainfo_omen_image_test.rb}, %q{test/mediainfo_string_test.rb}, %q{test/mediainfo_subtilte_test.rb}, %q{test/mediainfo_test.rb}, %q{test/mediainfo_vimeo_test.rb}, %q{test/test_helper.rb}]
  s.homepage = %q{http://greatseth.github.com/mediainfo}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Mediainfo}, %q{--main}, %q{README.markdown}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{mediainfo}
  s.rubygems_version = %q{1.8.2}
  s.summary = %q{Mediainfo is a class wrapping the mediainfo CLI (http://mediainfo.sourceforge.net)}
  s.test_files = [%q{test/mediainfo_awaywego_test.rb}, %q{test/mediainfo_broken_embraces_test.rb}, %q{test/mediainfo_dinner_test.rb}, %q{test/mediainfo_hats_test.rb}, %q{test/mediainfo_multiple_streams_test.rb}, %q{test/mediainfo_omen_image_test.rb}, %q{test/mediainfo_string_test.rb}, %q{test/mediainfo_subtilte_test.rb}, %q{test/mediainfo_test.rb}, %q{test/mediainfo_vimeo_test.rb}, %q{test/test_helper.rb}]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
