class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     email: current_user.email,
     description: "Blocipedia Membership - #{current_user.name}",
     amount: 1500 
    }
  end

  def create
    @amount = params[:amount]
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => Amount.default,
      :source      => token,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    current_user.update_attributes!( role: "premium" )
    if user.premium?
        redirect_to new_charge_path
    else
      flash[:error] = "There was an error upgrading your account. Please try again."
      redirect_to edit_user_registration_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charges_path
  end
end
