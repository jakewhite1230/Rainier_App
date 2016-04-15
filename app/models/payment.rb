class Payment < ActiveRecord::Base
  belongs_to :tenant

  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year


  def self.month_options
  	Date::MONTHNAMES.compact.each_with_index.map {|name, i| ["#{i+1} - #{name}", i+1]}
  end

  def self.year_options
  	(Date.today.year..(Date.today.year+10)).to_a
  end

  def process_payment

    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account/apikeys
    Stripe.api_key = ENV[STRIPE_TEST_SECRET_KEY]


    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :source => token,
      :plan => "rainier-monthly",
      :email => "email"
    )


  end

end
