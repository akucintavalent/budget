require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  it 'GET /payments' do
    sign_in User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    get('/payments')
    expect(response).to render_template('index')
    expect(response).to have_http_status(:ok)
  end

  it 'GET /payments/:id' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    get("/payments/#{payment.id}")
    expect(response).to render_template('show')
    expect(response).to have_http_status(:ok)
  end

  it 'GET /payments/new' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    get('/payments/new')
    expect(response).to render_template('new')
    expect(response).to have_http_status(:ok)
  end

  it 'POST /payments' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    post('/payments', params: { payment: { name: 'Payment #n', amount: 33, categories: [category.id] } })
    expect(Payment.last.name).to eq 'Payment #n'
    expect(Payment.last.amount).to eq 33
    expect(Payment.last.categories[0]).to eq category
    expect(response).to redirect_to("/payments/#{Payment.last.id}")
  end

  it 'PUT /payments/:id' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    put("/payments/#{payment.id}", params: { payment: { name: 'Payment ###', amount: 333, categories: [category.id] } })
    payment.reload
    expect(payment.name).to eq 'Payment ###'
    expect(payment.amount).to eq 333
    expect(response).to redirect_to("/payments/#{payment.id}")
  end

  it 'GET /payments/:id/edit' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    get("/payments/#{payment.id}/edit")
    expect(response).to render_template('edit')
    expect(response).to have_http_status(:ok)
  end

  it 'DELETE /payments/:id' do
    user = User.create!(name: 'Badman', email: 'meri@example.com', password: 'password', confirmed_at: Time.now)
    sign_in user
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    payment = Payment.new(user:, name: 'Payment #1', amount: 731)
    payment.categories.push(category)
    payment.save
    delete("/payments/#{payment.id}")
    expect(response).to redirect_to(payments_url)
    expect(Payment.where(id: payment.id)[0]).to eq nil
  end
end
