# config/initializers/cors.rb

# Be sure to replace 'http://localhost:5173' with the actual origin of your React app.
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173",
            "https://book-a-concert.onrender.com"
    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      max_age: 86400
  end
end
