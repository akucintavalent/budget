require 'rails_helper'

RSpec.describe "Pages", type: :request do
  it 'GET /' do
    get('/')
    expect(response).to render_template('index')
    expect(response).to have_http_status(:ok)
  end
end
