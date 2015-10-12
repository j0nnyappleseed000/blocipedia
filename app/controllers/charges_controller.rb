class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     email: current_user.email,
     description: "Blocipedia Membership - #{current_user.name}",
     amount: 15_00
    }
  end

  def create

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => 15_00,
      :description => 'Blocipedia Membership',
      :currency    => 'usd'
    )

    current_user.update_attributes!(role: 'premium')

    if current_user.premium?
        redirect_to user_path(current_user)
    else
      flash[:error] = "There was an error upgrading your account. Please try again."
      redirect_to edit_user_registration_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charges_path
  end
end
