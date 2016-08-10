Rails.configuration.stripe = {
   :publishable_key => 'stripe_publishable_key',
   :secret_key      => 'stripe_api_key'
 }

Stripe.api_key = Rails.configuration.stripe[:secret_key]