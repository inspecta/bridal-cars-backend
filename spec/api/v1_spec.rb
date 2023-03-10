require 'swagger_helper'

RSpec.describe 'Bridal Cars API', type: :request do
  # User registration
  path '/users/' do
    post 'Register a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :user, in: :body, description: 'User object'

      response '200', 'User registered successfully.' do
        schema type: :object,
               properties: {
                 username: { type: :string }, email: { type: :string }, password: { type: :string }
               },
               required: %w[username email password]

        let(:user) do
          User.create(username: 'Username', email: 'email@example.com', password: 'email@example.com')
        end
        run_test!
      end

      response '500', 'Email already exists.' do
        let(:user) do
          User.create(username: 'Username', email: 'email@example.com', password: 'email@example.com')
        end
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        let(:user) do
          User.create(
            username: 'Username', email: 'invalid email', password: 'email@example.com'
          )
        end
        run_test!
      end
    end
  end

  # Login user
  path '/users/sign_in' do
    post 'Login user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :user_credentials, in: :body, schema: {
        type: :object,
        properties: { email: { type: :string }, password: { type: :string } },
        required: %w[email password]
      }

      response '200', 'User signed in successfully' do
        schema type: :object, properties: {
          status: { type: :object, properties: {
            code: { type: :integer }, message: { type: :string }
          } },
          data: { type: :object, properties: {
            id: { type: :integer }, email: { type: :string }, created_at: { type: :string, format: :date_time },
            updated_at: { type: :string, format: :date_time }, jti: { type: :string }, username: { type: :string }
          } }
        }

        let(:user_credentials) do
          { email: 'example@example.com', password: 'password' }
        end
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user_credentials) do
          { email: 'test@example.com', password: 'wrong_password' }
        end
        run_test!
      end
    end
  end

  # Logout the user
  path '/users/sign_out' do
    delete 'Logout user' do
      tags 'Users'
      produces 'application/json'
      security [bearerAuth: []]

      parameter name: 'Authorization', in: :header, type: :string, required: true

      response '200', 'User logged out' do
        let(:user) { create(:user) }
        let(:Authorization) { "Bearer #{user.token}" }

        run_test!
      end

      response '401', 'Invalid token' do
        let(:Authorization) { "Bearer #{invalid_token}" }
      end
    end
  end

  # Retrtieve all cars
  path '/cars' do
    get 'Retrieves all the bridal cars available' do
      tags 'Cars'
      produces 'application/json'
      response '200', 'All cars retrieved' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   model: { type: :string },
                   photo: { type: :string },
                   price: { type: :integer },
                   description: { type: :string },
                   reserved: { type: :boolean }
                 },
                 required: %w[name model photo price description]
               }
        run_test!
      end

      response '401', 'User is not authenticated' do
        let(:Authorization) { 'invalid token' }
        run_test!
      end
    end
  end

  # Get the details of a particular car
  path '/cars/{car_id}' do
    get 'Retrieves details of a particular car' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :car_id, in: :path, type: :integer

      response '200', 'Car found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 model: { type: :string },
                 photo: { type: :string },
                 price: { type: :integer },
                 description: { type: :string },
                 reserved: { type: :boolean }
               },
               required: %w[name model photo price description]

        let(:car_id) { 2 }
        run_test!
      end

      response '404', 'Car not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  # Add a new car
  path '/cars/' do
    post 'Add a new car' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :name, in: :query, type: :string, description: 'Name of the car'
      parameter name: :model, in: :query, type: :string, description: 'Model of the car'
      parameter name: :price, in: :query, type: :string, description: 'Reserve fare'
      parameter name: :description, in: :query, type: :string, description: 'Description of the car'
      parameter name: :photo, in: :query, type: :string, description: 'Car photo URL'

      response '200', 'Car added' do
        schema type: :object,
               properties: {
                 name: { type: :string }, model: { type: :string },
                 price: { type: :integer }, description: { type: :string },
                 photo: { type: :string }
               },
               required: %w[name model price description photo]

        let(:car) do
          Car.create(
            name: 'Mercedes', model: 'W-14', photo: 'mercedes-photo.png',
            price: 12, description: 'Best comfort you can get'
          )
        end
        run_test!
      end

      response '404', 'Car not added' do
        let(:car) { 'invalid' }
        run_test!
      end
    end
  end

  # Delete a particular car
  path '/cars/{id}' do
    delete 'Delete a car' do
      tags 'Cars'
      produces 'application/json'
      parameter name: :car_id, in: :path, type: :integer, description: 'Id of the car to delete'

      response '204', 'Car deleted.' do
        let(:id) { 2 }
        run_test!
      end

      response '404', 'Car not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  # Reserve a car
  path '/reservations' do
    post 'Reserve a car' do
      tags 'Reserve'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        type: :object, properties: {
          car_id: { type: :integer }, city: { type: :string }, duration: { type: :integer },
          reservation_date: { type: :string, format: 'date-time' }, user_id: { type: :integer }
        }, required: %w[car_id city duration reservation_date user_id]
      }

      response '201', 'car reserved successfully' do
        schema type: :object, properties: {
          car: {
            type: :object,
            properties: {
              id: { type: :integer }, name: { type: :string }, model: { type: :string },
              photo: { type: :string }, price: { type: :integer }, description: { type: :string }
            }, required: %w[id name model photo price description reserved]
          },
          reservation: {
            type: :object,
            properties: {
              car_id: { type: :integer }, city: { type: :string }, duration: { type: :integer },
              reservation_date: { type: :string, format: 'date-time' }, user_id: { type: :integer }
            }, required: %w[car_id city duration reservation_date user_id]
          }
        }, required: %w[car reservation]

        let(:reservation) do
          create(car_id: 1, city: 'San Francisco', duration: 2, reservation_date: '01/04/2023', user_id: 1)
        end

        run_test!
      end

      response '404', 'Car is not found' do
        let(:reservation) do
          create(car_id: 'string', city: 'San Francisco', duration: 2, reservation_date: '01/04/2023', user_id: 1)
        end

        run_test!
      end
    end
  end
end
