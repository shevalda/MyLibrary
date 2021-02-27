require './app/controller'

class Main
  loop do
    print '$ '
    input = gets.chomp
    output = Controller.execute(input)

    break if output == false

    puts output
  end
end
