# LocaleRouting

LocaleRouting makes using I18N locale from an url parameter or hostname seamless.  
It taps into the route recognition and generation methods and checks or adds the locale when nessecary.

The plugin loads its available locales from Rails default I18N class.  
For every request, it check the configured part the URL match any of the locale definitions exposed by `I18n.available_locales`.
If a locale string is found, the application `I18n.local`e is changed and the locale is passed via `params[:locale]`.

Access to mapped URLs is wrapped also, the current I18n.locale is always prepended to the generated URLs parameters.  
Additionally you can pass a `{:locale => "en}` option to your link helpers, which will inject the given locale into the output URL.
This parameter defaults to I18n.locale.

No routes have to be changed to use this functionality.

## Installation

There are several different ways to install this plugin.  

### Installing as Rails gem dependency

To add **locale_routing** as a gem dependecy, add this to your `config/environment.rb` like this:
	Rails::Initializer.run do |config| block
	...
	  config.gem 'perfectline-locale_routing', :lib => 'locale_routing', :source => 'http://gems.github.com'
	...
	end

To install this gem (and other missing gem dependencies) run `rake gems:install`.

### Installing the gem manually

This requires you to have at least RubyGems version 1.2 (run `gem -v` to check your current version).
As the gem is built by GitHub, you have to add GitHub as a gem source on your environment (if you havent done it already):
	sudo gem sources -a http://gems.github.com

Install the plugin library:
	sudo gem install perfectline-locale_routing

To include them gem in your application, add this to the bottom of your `environment.rb` or in an initializer:
	require 'locale_routing'
 
### Install as a plugin via Git

Alternatively you can use `script/plugin` to export the code into your applications `vendor/plugins` directory.
	'script/plugin install git://github.com/perfectline/locale_routing.git'

## Configuration

To enable or disable the locale routing set `Perfectline::LocaleRouting::Config.enabled = true/false`.  
To specifiy which part of the URL should be matched for the locale identifier, set `Perfectline::LocaleRouting::Config.match_from = option`

### Available options for match_from are:
*   **:params**  
    Searches for a 2 letter locale string in the parameters, specifically in the first query stirng token.   
    Found token is matched against I18n.available_locales and if no such locale exists, it will fall back to the default locale.

    Example:
        www.myapp.com resolves to root controller with the default locale
        www.myapp.com/en resolves to root controller with locale => "en"
        www.myapp.com/foo/bar resolves to "foo" controller, "bar" action with default locale
        www.myapp.com/fr/foo/bar resolves to "foo" controller, "bar" action with locale => "fr"

*   **:host**  
    Searches for configured matches in the domain name. If a match is found, the configured locale is then checked against I18n.available_locales.  
    If the configured locale does not exist in available locales, it will fall back to the default locale.

    Configuring host to locale mappings is done via `Perfectline::LocaleRouting::Config.mapping do |block|`.
    Hash key must be the hostname pattern to be matched and value is the locale string.  
    Hostname patterns are like simplified regexp patterns with * wildcard support.  
    Mappings matching is similar to route config - first match found is used, rest is ignored.

    Example:
        Perfectline::LocaleRouting::Config.mapping do |map|
          map.match "en.dev.*", "en", # matches en.dev.yoursite.com and en.dev.mysite.co.uk
          map.match "*.dev.*",  "en", # matches foo.dev.yoursite.com and www.dev.yoursite.com but not en.dev.mysite.com as its defined AFTER that mapping
          map.match "en.*",     "en", # matches en.yoursite.com but not en.dev.yoursite.com or en.foo.dev.yoursite.com as its defined AFTER that mapping
          map.match "*.com",    "en", # matches anything with a .com TLD
        end

## Warning
This plugin has not been fully tested with all possible cases except perhaps the params locale matching.  
As you can see there are no tests yet either, although they will be created as soon as possible.  
So if you do run into issues or have any improvement ideas, feel free to contact the authors.  

## Honorable mentions
This plugin is inspired by the "routing-filter" plugin by **Sven Fuchs**.

## Authors:
**Tanel Suurhans** - tanel.suurhans_at_perfectline_d0t_ee  
**Tarmo Lehtpuu** - tarmo.lehtpuu_at_perfectline_d0t_ee

## License
Copyright 2009 by PerfectLine LLC (<http://www.perfectline.co.uk>) and is released under the MIT license.
