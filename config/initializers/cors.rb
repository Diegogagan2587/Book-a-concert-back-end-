# config/initializers/cors.rb

# Be sure to replace 'http://localhost:5173' with the actual origin of your React app.
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' 
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end