class CaesarCipher

    def initialize(input,c_shift,dirn)
        @input = input
        @c_shift = c_shift
        @dirn = dirn
        @output = ""
        @element = '';


        puts "Input:  >#{@input}<"
        puts "Shift:  >#{@c_shift}<"
        puts "Dirn:   >#{@dirn}<"

    end

    def encrypt

        @caesar_array = @input.split("");
       
        for @element in @caesar_array
        
            # puts "----------"

            # puts @element

            if @element == ' '

                # Do nothing

            elsif @dirn == 'L'

                going_down();

            else

                going_up();

            end

            # puts @element
        
            @output = @output + @element

        end

    end

    def going_down

        1.upto(@c_shift){ |x|

            if @element == 'A'
  
                @element = 'Z'

            else

                ascii = @element[0]
                ascii = ascii - 1

                @element = (ascii).chr

            end

            # puts "--- #{@element}"
        }

    end
    
    def going_up

        1.upto(@c_shift){ |x|

            if @element == 'Z'
  
                @element = 'A'

            else

                ascii = @element[0]
                ascii = ascii + 1

                @element = (ascii).chr

            end

            # puts "--- #{@element}"
        }

    end
    
    def printEncryption

        puts "Output: >#{@output}<"

    end

end

puts "Please write a sample Caesar Cipher sentence: "

caesar_input = gets.chomp

#puts "Original Sentence: >#{caesar_input}<"

caesar_input.gsub!(/[\W]/, " ")

caesar_input.gsub!(/\s+/, " ")

caesar_input.upcase!

#puts "Clean Sentence, without punctuation: >#{caesar_input}<"

puts "How many characters to move?: "

caesar_shift = gets.chomp

caesar_shift = Integer(caesar_shift)

#puts "Caesar Shift: >#{caesar_shift}<"

caesar_dirn = 'X'

while caesar_dirn != 'L' && caesar_dirn != 'R' do

    puts "Left or Right shift? [L/R]: "

    caesar_dirn = gets.chomp

    caesar_dirn.upcase!
end

#puts "Caesar Direction: >#{caesar_dirn}<"

#caesarObject = CaesarCipher.new("AB CDEFGHIJKLMNOPQRSTUVWXYZ", 3, 'L');

caesarObject = CaesarCipher.new(caesar_input, caesar_shift, caesar_dirn)

caesarObject.encrypt

caesarObject.printEncryption
