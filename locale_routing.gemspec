# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{locale_routing}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tanel Suurhans", "Tarmo Lehtpuu"]
  s.date = %q{2009-05-03}
  s.description = %q{A library for configuring/parsin locales from url params or hostname for I18n.}
  s.email = %q{tanel.suurhans@perfectline.ee}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "README.markdown",
    "Rakefile",
    "VERSION.yml",
    "lib/locale_routing.rb",
    "lib/locale_routing/config.rb",
    "lib/locale_routing/locale.rb",
    "lib/locale_routing/locale_route_set.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/perfectline/locale_routing/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{LocaleRouting makes parsing I18N locale from an url parameters/hostname seamless.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end