class Writer
  def initialize(file_path, instructions)
    @file_path = file_path
    @instructions = instructions
  end

  def call
    File.open(@file_path, 'w+') do |f|
      f.puts(@instructions)
    end
  end
end
