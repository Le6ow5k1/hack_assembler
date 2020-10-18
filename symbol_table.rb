# frozen_string_literal: true

require 'forwardable'

class SymbolTable
  extend Forwardable
  def_delegators :@table, :[], :[]=, :key?

  INITIAL = {
    'R0' => 0,
    'R1' => 1,
    'R2' => 2,
    'R3' => 3,
    'R4' => 4,
    'R5' => 5,
    'R6' => 6,
    'R7' => 7,
    'R8' => 8,
    'R9' => 9,
    'R10' => 10,
    'R11' => 11,
    'R12' => 12,
    'R13' => 13,
    'R14' => 14,
    'R15' => 15,
    'SCREEN' => 16_384,
    'KBD' => 24_576,
    'SP' => 0,
    'LCL' => 1,
    'ARG' => 2,
    'THIS' => 3,
    'THAT' => 4
  }.freeze

  def initialize
    @table = INITIAL.dup
  end
end