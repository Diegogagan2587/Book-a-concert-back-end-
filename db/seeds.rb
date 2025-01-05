# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#Ariaga Creates an account and create an Indepentent Concert

@user_one = User.find_or_create_by(name: "Ariana Grande", email: "ariana@mail.com", password:'123456');

@ariana_concert = Concert.create(
  title: "Ariana Grande Live Concert",
  organizer: @user_one,
  description: "Ariana Concert: Ariana Grande is an American singer, songwriter, and actress. A multi-platinum, Grammy Award-winning recording artist, she is known for her wide vocal range, which critics have often compared to that of Mariah Carey.",
  img: "https://www.billboard.com/files/styles/900_wide/public/media/Ariana-Grande-2019-cr-Getty-billboard-1548.jpg",
  price: 100,
  date: "2021-10-10",
  city: "New York",
)

# Then anohther user creates an account and buys a ticket or reserve for the concert

@user_two = User.find_or_create_by(name: "Alejandro Magnus", email: "alejandro@mail.com", password:'123456');
@reservation = Reservation.create(
  user: @user_two,
  concert: @ariana_concert,
  date: @ariana_concert.date,
  city: @ariana_concert.city,
)