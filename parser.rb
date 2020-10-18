# frozen_string_literal: true

require_relative 'a_instruction'
require_relative 'c_instruction'
require_relative 'label'

class Parser
  A_INSTRUCTION_PREFIX = '@'
  COMMENT_PREFIX = '//'
  LABEL_DECLARATION_PREFIX = '('
  DEST_SEPARATOR = '='
  JUMP_SEPARATOR = ';'

  def parse_line(line, handle_symbol_proc = nil)
    line.strip!

    if a_instruction?(line)
      if handle_symbol_proc
        parse_a_instruction(line, &handle_symbol_proc)
      else
        parse_a_instruction(line)
      end
    elsif c_instruction?(line)
      parse_c_instruction(line)
    elsif label_declaration?(line)
      parse_label(line)
    end
  end

  private

  def a_instruction?(line)
    line.start_with?(A_INSTRUCTION_PREFIX)
  end

  def c_instruction?(line)
    first_two_chars = line[0..1]
    return false if first_two_chars.empty?

    first_two_chars != COMMENT_PREFIX &&
      first_two_chars[0] != LABEL_DECLARATION_PREFIX
  end

  def label_declaration?(line)
    line.start_with?(LABEL_DECLARATION_PREFIX)
  end

  def parse_a_instruction(line)
    symbol_or_value = line[1..-1]
    is_symbol = symbol_or_value.match?(/\A[a-zA-Z]/)
    if is_symbol && block_given?
      value = yield(symbol_or_value)
      AInstruction.new(value)
    else
      AInstruction.new(symbol_or_value)
    end
  end

  def parse_c_instruction(line)
    strip_inline_comments(line)

    if line.include?('=')
      dest, rest = line.split(DEST_SEPARATOR)
      comp, jump = rest.split(JUMP_SEPARATOR)
    else
      comp, jump = line.split(JUMP_SEPARATOR)
    end

    CInstruction.new(dest, comp, jump)
  end

  def parse_label(line)
    name = line.gsub(/\(|\)/, '')
    Label.new(name)
  end

  def strip_inline_comments(line)
    line.sub!(%r{(//.*)}, '')
    line.strip!
  end
end
