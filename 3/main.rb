def part1
  symbol_position = []
  lines = IO.read('input.txt').split("\n").map{|line| line.split('')}
  re = Regexp.new('\d|\.')
  re2 = Regexp.new('\d')
  sum = 0
  lines.each_with_index do |symbols, line_index|
    current_number = ""
    start_index = nil
    symbols.each_with_index do |symbol, symbol_index|
      if re2.match(symbol)
        current_number += symbol
        start_index = symbol_index-1 if start_index.nil?
      end
      if (!re2.match(symbol) || symbol_index == symbols.length-1) && current_number != ""
        current_number = current_number.to_i
        index_1 = start_index
        index_2 = symbol_index
        index_1 = 0 if index_1 < 0
        index_2 = symbols.length-1 if index_2 >= symbols.length

        if !re.match(symbols[index_1])
          sum += current_number
        elsif !re.match(symbol)
          sum += current_number
        elsif line_index > 0 && lines[line_index-1][index_1..index_2].select{ |s| !re.match(s) }.count > 0
          sum += current_number 
        elsif line_index < lines.length-1 && lines[line_index+1][index_1..index_2].select{ |s| !re.match(s) }.count > 0
          sum += current_number 
        else
          puts "not added"
        end 
        current_number = ""
        start_index = nil
      end
    end
  end
  puts sum
end

def part2
  symbol_position = []
  lines = IO.read('input.txt').split("\n").map{|line| line.split('')}
  re2 = Regexp.new('\d')
  map = {}
  lines.each_with_index do |symbols, line_index|
    current_number = ""
    start_index = nil
    symbols.each_with_index do |symbol, symbol_index|
      if re2.match(symbol)
        current_number += symbol
        start_index = symbol_index if start_index.nil?
      elsif symbol == "*"
        map[line_index] = {} if map[line_index].nil?
        map[line_index][symbol_index] = "*"
      end

      if (!re2.match(symbol) || symbol_index == symbols.length-1) && current_number != ""
        current_number = current_number.to_i
        (start_index..symbol_index-1).each do |i|
          map[line_index] = {} if map[line_index].nil?
          map[line_index][i] = current_number
        end
        current_number = ""
        start_index = nil
      end
    end
  end

  sum = 0
  map.each do |line_index, columns|
    columns.each do |colum_index, value|
      if value == "*"
        min_column = colum_index-1
        max_column = colum_index+1
        min_line = line_index-1
        max_line = line_index+1
        adjacent_values = []
        (min_line..max_line).each do |line|
          previous_value = []
          (min_column..max_column).each do |column|
            value = !map[line].nil? && !map[line][column].nil? && map[line][column] != "*" ? map[line][column] : nil  
            if value != nil && (previous_value.count == 0 || (value != previous_value[1] || column - 1 != previous_value[0]))
              adjacent_values << value
              previous_value = [column, value]
            elsif value != nil && value == previous_value[1]
              previous_value = [column, value]
            end
          end
        end
        if adjacent_values.count == 2
          sum += adjacent_values[0]  * adjacent_values[1]
        end
      end
    end
  end
  puts sum
end

part1()
part2()