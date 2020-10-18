require_relative './reader'
require_relative './translator'
require_relative './writer'

file_path = ARGV.first

reader = Reader.new(file_path)
translated_instructions = Translator.new(reader).call
Writer.new("#{file_path}.hack", translated_instructions).call
