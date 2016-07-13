# Price Point

---

## Install

The extension contains a rails generator that will add the necessary migrations and give you the option to run the migrations, or run them later, perhaps after installing other extensions. Once you have bundled the extension, run the install generator and its ready to use.

      rails generate spree_price_point:install

Easily add price point display to your product page:

      <%= render partial: 'spree/products/price_point', locals: { product: @product } %>

