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

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => Amount.default,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    if current_user.update(premium: true)
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
