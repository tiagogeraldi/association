# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

User.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

# Método para gerar usuários
def generate_users(count)
    users = []
    count.times do
      user = {
        email: Faker::Internet.unique.email,
        encrypted_password: Faker::Internet.password(min_length: 8),
        reset_password_token: nil,
        reset_password_sent_at: nil,
        remember_created_at: nil,
        created_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)
      }
      users << user
    end
    users
  end
  
  # Método para gerar pessoas
  def generate_people(count, users)
    people = []
    count.times do
      person = {
        name: Faker::Name.name,
        phone_number: Faker::PhoneNumber.phone_number,
        national_id: Faker::IDNumber.valid,
        active: Faker::Boolean.boolean,
        created_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now),
        user_id: users.sample[:id] # Seleciona um usuário aleatório e pega seu ID
      }
      people << person
    end
    people
  end
  
  # Método para gerar dívidas
  def generate_debts(count, people)
    debts = []
    count.times do
      debt = {
        person_id: people.sample[:id], # Seleciona uma pessoa aleatória e pega seu ID
        amount: Faker::Number.between(from: 100, to: 10000).to_f,
        observation: Faker::Lorem.sentence,
        created_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 365, to: DateTime.now)
      }
      debts << debt
    end
    debts
  end
  
  # Gerar os dados
  puts "Gerando 50 usuários..."
  users = generate_users(50)
  puts "Gerando 100 pessoas..."
  people = generate_people(100, users)
  puts "Gerando 500 dívidas..."
  debts = generate_debts(500, people)
  
  # Exibir alguns exemplos para verificar
  puts "Exemplo de usuário:"
  puts users.first
  puts "\nExemplo de pessoa:"
  puts people.first
  puts "\nExemplo de dívida:"
  puts debts.first

