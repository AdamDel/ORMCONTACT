require 'csv'
require 'securerandom'
require 'date'
require 'pg'

class EmailExistsAlready < StandardError  
end

class Contact

  attr_accessor :name, :email, :id
  def initialize(name, email, id)
        @name = name
        @email = email
        @id = id
  end
  def save 
    if !id.nil?
      self.class.connect.exec_params("UPDATE contacts SET name='#{name}', email='#{email}' WHERE id=#{id}")
    else
      self.class.connect.exec_params("INSERT INTO contacts(name, email) VALUES ('#{name}', '#{email}')")
    end
  end

  class << self

    def connect
      PG.connect(
        host: 'localhost',
        dbname: 'contactlist',
        user: 'development',
        password: 'development'
        )
    end
    def all
        connect.exec('SELECT * FROM contacts;') do |results|
        results.each do |contact|
        puts contact.inspect
        end
      end
    connect.close
    end
    
    def update(id, update_name, update_email)
       the_contact = Contact.find(id)
       updated = Contact.new(update_name, update_email, id)
       the_contact = updated
       the_contact.save
    end
    
    def destroy(id)
       connect.exec("DELETE FROM contacts WHERE id = #{id}")
    end

    def makesure_enter
      input = STDIN.gets.chomp
    end

    def create (name, email, id = nil)
       contact = Contact.new(name, email, id)
       contact.save
       contact
    end

    def find(id)
     puts connect.exec_params("SELECT * FROM contacts where id = #{id};")[0].inspect
    end

    def search(term)
       connect.exec("SELECT * FROM contacts where name = '#{term}' OR email = '#{term}';") do |results|
        results.each do |contact|
        puts contact.inspect
        end
      end
        connect.close
    end

  end

end
