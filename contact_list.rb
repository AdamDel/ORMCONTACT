
require_relative 'contact'

class ContactList
  def Interact_with_user


    case ARGV[0] 
      

      when nil
        menu = File.open('Main_menu.txt', "r").readlines.each do |line|
         puts line
        end
      
      when "new"
        ARGV.shift
        puts "What is the name of the contact?"
        name = gets.chomp.downcase.capitalize
        puts "what is the email?"
        email = gets.chomp.downcase

        Contact.create(name,email)
      when "update"
        ARGV.shift
        id = ARGV[0].to_i #+ " " + ARGV[1].to_s + " " + ARGV[2].to_s
        ARGV.shift
        puts "What is the new name of the contact?"
        name = gets.chomp.downcase.capitalize
        puts "what is the new email?"
        email = gets.chomp.downcase
        Contact.update(id, name, email)
      when "list"
        Contact.all
      when "destroy"
         ARGV.shift
          id = ARGV[0].to_i
        Contact.destroy(id)      
      when "show"
        ARGV.shift
        id = ARGV[0].to_i
        Contact.find(id)
      when "search"
        ARGV.shift
        term = ARGV[0]
        Contact.search(term)
      else 
      puts "Not a valid input"
      
    end  
  end
end

list = ContactList.new
list.Interact_with_user
