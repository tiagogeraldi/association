puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

1000.times do |counter|
  puts "Creating user #{counter}"
  User.create email: Faker::Internet.email, password: '111111'
end

3000.times do |counter|
  puts "Inserting Person #{counter}"

  attrs = {
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: CPF.generate,
    active: [true, false].sample,
    user: User.order('random()').first
  }
  person = Person.create(attrs)

  5.times do |debt_counter|
    puts "Inserting Debt #{debt_counter}"
    person.debts.create(
      amount: Faker::Number.between(from: 1, to: 200),
      observation: Faker::Lorem.paragraph
    )
  end
end
