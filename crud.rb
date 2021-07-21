load './db.rb'

module Crud
    def self.get_user(name)
        user = MyDB::User.filter(:name => name).first
        if user
            return user
        else
            return false
        end
    end

    def self.create_user(name, age, password)
        if self.get_user(name)
            return false
        else
            return MyDB::User[MyDB::User.insert(:name => name, :age => age, :password => password)]
        end
    end

    def self.login_user(name, password)
        user = self.get_user(name)
        if user
            if user.password == password
                return user
            else
                return false
            end
        else
            return false
        end
    end
end