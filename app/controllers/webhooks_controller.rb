class WebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
       # receive POST from Stripe
        payload = request.body.read
        signature_header = request.env['HTTP_STRIPE_SIGNATURE']
        endpoint_secret = 'whsec_c6f208a21dd071bb6473aec3643166c1c663bc3cb5d1e55c43ad9ea8507fcfec' #Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
        event = nil

        begin
            event = Stripe::Webhook.construct_event(
                payload, signature_header, endpoint_secret
            )
        rescue JSON::ParserError => e
            # Invalid payload
            render json: {message: e}, status: 400
            return
        rescue Stripe::SignatureVerificationError => e
            # Invalid signature
            render json: {message: e}, status: 400
            return
        end

        # Handle the event
        case event.type
        when 'checkout.session.completed'
            return if !User.exists?(event.data.object.client_reference_id)
            fullfill_order(event.data.object)
        # Payment is successful and the subscription is created.
        # Provision the subscription and save the customer ID to your database.
        when 'checkout.session.async_payment_succeeded'
        # Some payments take longer to succeed (usually noncredit card payments)
        # You could do logic here to account for that.
        when 'invoice.payment_succeeded'
            # return if a subscription id isn't present on the invoice
            return unless event.data.object.subscription.present?
            # Continue to provision the subscription as payments continue to be made.
            # Store the status in your database and check when a user accesses your service.
            stripe_subscription = Stripe::Subscription.retrieve(event.data.object.subscription)
            subscription = Subscription.find_by(subscription_id: stripe_subscription)

            subscription.update(
                current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
                current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
                plan: stripe_subscription.plan.id,
                interval: stripe_subscription.plan.interval,
                status: stripe_subscription.status,
            )
        # Continue to provide the subscription as payments continue to be made.
        # Store the status in your database and check when a user accesses your service.
        # This approach helps you avoid hitting rate limits.
        when 'invoice.payment_failed'
        # The payment failed or the customer does not have a valid payment method.
        # The subscription becomes past_due. Notify the customer and send them to the
        # customer portal to update their payment information.
        else
            puts "Unhandled event type: #{event.type}"
        end
    end
    private

        def fullfill_order(checkout_session)
            # Find user and assign customer id from Stripe
            user = User.find(checkout_session.client_reference_id)
            user.update(stripe_id: checkout_session.customer)

            # Retrieve new subscription via Stripe API using susbscription id
            stripe_subscription = Stripe::Subscription.retrieve(checkout_session.subscription)

            # Create new subscription with Stripe subscription details and user data
            Subscription.create(
                customer_id: stripe_subscription.customer,
                current_period_start: Time.at(stripe_subscription.current_period_start).to_datetime,
                current_period_end: Time.at(stripe_subscription.current_period_end).to_datetime,
                plan: stripe_subscription.plan.id,
                interval: stripe_subscription.plan.interval,
                status: stripe_subscription.status,
                subscription_id: stripe_subscription.id,
                user: user,
            )
        end
end
