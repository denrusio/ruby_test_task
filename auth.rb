load './crud.rb'

module MyAuth
    class Auth
        def register(name, age, password)
            return Crud::create_user(name, age, password)
        end
    
        def login(name, password)
            return Crud::login_user(name, password)
        end
    end
end