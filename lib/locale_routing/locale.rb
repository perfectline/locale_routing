module Perfectline
  module LocaleRouting
    # class containing Locale handling methods
    class Locale
      class << self

        # locale matching pattern
        def match_params_locale
          @@match_params_locale ||= %r(^/((#{I18n.available_locales.map{|o| Regexp.escape(o.to_s)}.join('|')})(?=/|$)))
        end

        def match_url
          @@match_url ||= %r(^(http.?://[^/]*)?(.*))
        end

        # prepend locale to generated url

        def prepend(result, locale)
          # check the results
          url = result.is_a?(Array) ? result.first : result
          locale = I18n.locale if locale.nil?

          # substitute the locale
          url.sub!(self.match_url){"#{$1}/#{locale}#{$2}"}
        end

        # extract and set locale
        def extract(path, env)
          case Perfectline::LocaleRouting::Config.match_from
            when :params    then path = extract_from_params(path)
            when :host      then extract_from_host(env)
          end

          return path
        end

        def extract_from_params(path)
          # match for configured locales and remove them
          replacement = path.sub!(self.match_params_locale, '')
          locale = I18n.default_locale

          # if matches were found, set the locale and new path
          if (not replacement.nil?)
            path = replacement
            locale = $1.to_sym
          else
            RAILS_DEFAULT_LOGGER.info "No valid locale string found in the URL, falling back to #{locale}"
          end

          # set the locale and return the 'cleaned' path string
          I18n.locale = locale and return path
        end

        def extract_from_host(env)
          if env[:host].nil?
            raise "Valid host not found (Perfectline::LocaleRouting.match_from = :host)."
          end

          host = env[:host].to_s
          locale = I18n.default_locale
          mappings = Perfectline::LocaleRouting::Config.host_mapping

          if mappings.nil? || mappings.empty?
            RAILS_DEFAULT_LOGGER.warn "Perfectline::LocaleRouting.host_mapping is nil or empty."
          end

          puts mappings.inspect

          mappings.each do |element|
            unless host.match(%r(^#{element[:host]}$)).nil?
              locale = element[:locale] and break
            end
          end

          I18n.locale = locale
        end
      end
    end
  end
end