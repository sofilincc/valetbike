class Purchase::CheckoutsController < ApplicationController
  #before_action :authenticate_user!
  # def index 
  # end 
  def create
    price = params[:price_id] # passed in via the hidden field in pricing.html.erb
    mode = params[:mode_id]
    if mode == 'payment'
      session = Stripe::Checkout::Session.create(
      #customer: current_user.stripe_id,
      #client_reference_id: current_user.id,
      success_url: root_url,
      cancel_url: membership_url,
      payment_method_types: ['card'],
      mode: mode,
      customer_email: 'example@gmail.com',
      line_items: [{
        quantity: 1,
        price: price,
      }]
      )
      #render json: { session_id: session.id } # if you want a json response
      redirect_to session.url, allow_other_host: true

    else
      session = Stripe::Checkout::Session.create(
        customer: current_user.stripe_id,
        client_reference_id: current_user.id,
        success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: membership_url,
        payment_method_types: ['card'],
        mode: mode,
        #customer_email: 'example@gmail.com',
        line_items: [{
          quantity: 1,
          price: price,
        }]
      )
      #render json: { session_id: session.id } # if you want a json response
      redirect_to session.url, allow_other_host: true
    end
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = Stripe::Customer.retrieve(session.customer)
  end
end

