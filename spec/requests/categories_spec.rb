require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  it 'GET /categories' do
    sign_in User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    get('/categories')
    expect(response).to render_template('index')
    expect(response).to have_http_status(:ok)
  end

  it 'GET /categories/:id' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    get("/categories/#{category.id}")
    expect(response).to render_template('show')
    expect(response).to have_http_status(:ok)
  end

  it 'GET /categories/new' do
    sign_in User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    get('/categories/new')
    expect(response).to render_template('new')
    expect(response).to have_http_status(:ok)
  end

  it 'POST /categories' do
    sign_in User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    post('/categories',
         params: { category: { name: 'Category #n',
                               icon: ActionController::Base.helpers.image_path('education.png') } })
    expect(Category.last.name).to eq 'Category #n'
    expect(Category.last.icon).to eq ActionController::Base.helpers.image_path('education.png')
    expect(response).to redirect_to("/categories/#{Category.last.id}")
  end

  it 'PUT /categories/:id' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    put("/categories/#{category.id}",
        params: { category: { name: 'Category num.1', icon: ActionController::Base.helpers.image_path('other.png') } })
    category.reload
    expect(category.name).to eq 'Category num.1'
    expect(category.icon).to eq ActionController::Base.helpers.image_path('other.png')
    expect(response).to redirect_to("/categories/#{category.id}")
  end

  it 'GET /categories/:id/edit' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    get("/categories/#{category.id}/edit")
    expect(response).to render_template('edit')
    expect(response).to have_http_status(:ok)
  end

  it 'DELETE /categories/:id' do
    user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password', confirmed_at: Time.now)
    category = Category.create!(user:, name: 'Category #1',
                                icon: ActionController::Base.helpers.image_path('education.png'))
    sign_in user
    delete("/categories/#{category.id}")
    expect(response).to redirect_to(categories_url)
    expect(Category.where(id: category.id)[0]).to eq nil
  end
end
