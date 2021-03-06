describe WebhookPayment do
  let(:student) { FactoryBot.create(:user_with_credit_card) }
  let(:payment) { FactoryBot.create(:payment_with_credit_card, student: student, amount: 600_00) }

  it 'creates webhook with endpoint' do
    webhook = WebhookPayment.new({ payment: payment })
    expect(webhook.endpoint).to eq ENV['ZAPIER_WEBHOOK_URL']
  end

  it 'creates webhook with payload' do
    webhook = WebhookPayment.new({ payment: payment })
    expect(webhook.payload).to eq PaymentSerializer.new(payment).as_json
  end

  it 'creates webhook with payload that includes event_name when provided' do
    webhook = WebhookPayment.new({ event_name: 'test', payment: payment })
    expect(webhook.payload).to eq PaymentSerializer.new(payment).as_json.merge({ event_name: 'test' })
  end
end
