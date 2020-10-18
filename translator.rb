# frozen_string_literal: true

require_relative 'reader'
require_relative 'parser'
require_relative 'symbol_table'

class Translator
  INITIAL_VARS_ADDRESS = 16

  def initialize(reader)
    @reader = reader
    @parser = Parser.new
    @symbol_table = SymbolTable.new
  end

  def call
    handle_label_declarations

    parsed_lines = []
    @current_var_address = INITIAL_VARS_ADDRESS
    @reader.each do |line|
      parsed = @parser.parse_line(line, method(:handle_symbol).to_proc)

      if parsed && !parsed.label?
        parsed_lines << parsed.to_binary
      end
    end

    parsed_lines
  end

  private

  def handle_label_declarations
    instruction_number = 0

    @reader.each do |line|
      parsed = @parser.parse_line(line)
      next unless parsed

      if parsed.label?
        @symbol_table[parsed.name] = instruction_number
      else
        instruction_number += 1
      end
    end
  end

  def handle_symbol(symbol)
    found_value = @symbol_table[symbol]
    if found_value
      found_value
    else
      @symbol_table[symbol] = @current_var_address
      var_address = @current_var_address
      @current_var_address += 1

      var_address
    end
  end
end
