# frozen_string_literal: true

CInstruction = Struct.new(:dest, :comp, :jump) do
  COMP_TO_BINARY = {
    '0' => '0101010',
    '1' => '0111111',
    '-1' => '0111010',
    'D' => '0001100',
    'A' => '0110000',
    'M' => '1110000',
    '!D' => '0001101',
    '!A' => '0110001',
    '!M' => '1110001',
    '-D' => '0001111',
    '-A' => '0110011',
    '-M' => '1110011',
    'D+1' => '0011111',
    'A+1' => '0110111',
    'M+1' => '1110111',
    'D-1' => '0001110',
    'A-1' => '0110010',
    'M-1' => '1110010',
    'D+A' => '0000010',
    'D+M' => '1000010',
    'D-A' => '0010011',
    'D-M' => '1010011',
    'A-D' => '0000111',
    'M-D' => '1000111',
    'D&A' => '0000000',
    'D&M' => '1000000',
    'D|A' => '0010101',
    'D|M' => '1010101'
  }.freeze

  DEST_TO_BINARY = {
    nil => '000',
    'M' => '001',
    'D' => '010',
    'MD' => '011',
    'A' => '100',
    'AM' => '101',
    'AD' => '110',
    'AMD' => '111'
  }.freeze

  JUMP_TO_BINARY = {
    nil => '000',
    'JGT' => '001',
    'JEQ' => '010',
    'JGE' => '011',
    'JLT' => '100',
    'JNE' => '101',
    'JLE' => '110',
    'JMP' => '111'
  }.freeze

  def to_binary
    "111#{comp_to_binary}#{dest_to_binary}#{jump_to_binary}"
  end

  def label?
    false
  end

  private

  def comp_to_binary
    COMP_TO_BINARY.fetch(comp)
  end

  def dest_to_binary
    DEST_TO_BINARY.fetch(dest)
  end

  def jump_to_binary
    JUMP_TO_BINARY.fetch(jump)
  end
end
