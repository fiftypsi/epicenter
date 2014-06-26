def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def create_subscription
  Balanced.configure(ENV['BALANCED_API_KEY'])
  bank_account = Balanced::BankAccount.new(
    :account_number => '9900000002',
    :account_type => 'checking',
    :name => 'Johann Bernoulli',
    :routing_number => '021000021'
  ).save
  subscription = Subscription.create(account_uri: bank_account.href)
end

def create_verified_subscription
  subscription = create_subscription
  subscription.update(verified: true)
  subscription
end