User.create(username: 'admin', email: 'admin@twintter.com', password: 'password',
  password_confirmation: 'password', role: :admin, first_name: 'John',
  last_name: 'Doe')
User.create(username: 'user', email: 'user@twintter.com', password: 'password',
  password_confirmation: 'password', role: :user, first_name: 'John',
  last_name: 'Smith')
User.create(username: 'guest', email: 'guest@twintter.com', password: 'password',
  password_confirmation: 'password', role: :guest, first_name: 'John',
  last_name: 'Finn')
