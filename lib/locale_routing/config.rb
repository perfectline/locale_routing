module Perfectline
  module LocaleRouting

    class Mapper
      def initialize(config)
        @config = config
      end

      def match(host, locale)
        @config.add_host_match(host, locale)
      end
    end

    @locale_match_options = [:params, :host]
    @host_mapping = []

    # defaults
    @enabled = true
    @match_from = :params

    class << self

      def enabled?
        @enabled
      end

      def enabled=(enabled)
        @enabled = (enabled.nil? || enabled == false) ? false : true
      end

      def match_from
        @match_from
      end

      def match_from=(location)
        unless @locale_match_options.include?(location.to_sym)
          raise "#{location.to_sym} is not supported as Perfectline::LocaleRouting.match_from option."
        end

        @match_from = location.to_sym
      end

      def host_mapping
        @host_mapping
      end

      def add_host_mapping(host, locale)
        @host_mapping.push({:host => host.to_s.gsub('.', '\.').gsub('*', '.*'), :locale => locale.to_s})
      end

      def mapping
        yield Mapper.new(self)
      end

      # straps the LocaleRouteSet module into ActionControllers RouteSet
      def bootstrap
        ActionController::Routing::RouteSet.send(:include, Perfectline::LocaleRouting::LocaleRouteSet) if self.enabled?
      end

    end
  end
end