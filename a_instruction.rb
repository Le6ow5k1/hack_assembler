# frozen_string_literal: true

AInstruction = Struct.new(:address) do
  def to_binary
    "0#{address_to_binary}"
  end

  def label?
    false
  end

  private

  def address_to_binary
    binary = address.to_i.to_s(2)
    '%015d' % binary
  end
end
