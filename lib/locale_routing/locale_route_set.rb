module Perfectline
  module LocaleRouting
    # module containing methods for RouteSet extending
    module LocaleRouteSet

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.alias_method_chain(:recognize_path, :locale)
        base.alias_method_chain(:generate, :locale)
        base.alias_method_chain(:extract_request_environment, :locale)
      end

      module InstanceMethods

        # TODO: support locale in subdomain and top level domain extension
        def recognize_path_with_locale(path, env)
          # set locale and strip it from the path for recognition
          path = Perfectline::LocaleRouting::Locale.extract(path, env)
          # process the route and add the locale parameter to return value
          returning recognize_path_without_locale(path, env) do |params|
            params[:locale] = I18n.locale
          end
        end

        def generate_with_locale(*args)
          # check if locale is set
          locale = args.first.delete(:locale)

          returning generate_without_locale(*args) do |result|
            Perfectline::LocaleRouting::Locale.prepend(result, locale)
          end
        end

        # override request env extraction to include more info
        def extract_request_environment_with_locale(request)
          # merge the original hash with new info
          extract_request_environment_without_locale(request).merge({
                  :host => request.host,
                  :port => request.port,
                  :domain => request.domain,
                  :subdomain => request.subdomains.first,
                  :subdomains => request.subdomains
          })
        end
      end
    end
  end
end