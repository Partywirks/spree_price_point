module SpreePricePoint
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_price_point'

    initializer "spree_price_point.preferences", before: "spree.environment" do |app|
      Spree::AppConfiguration.class_eval do
        preference :use_master_variant_price_point, :boolean, :default => false
      end
    end

    config.to_prepare do
      # Load spree locales before decorators
      I18n.load_path += Dir.glob(
        File.join(
          File.dirname(__FILE__), '../../../config/locales', '*.{rb,yml}'
        )
      )
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      # Load lib's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), '../../lib/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
