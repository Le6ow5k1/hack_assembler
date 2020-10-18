# frozen_string_literal: true

require 'spec_helper'

require_relative '../a_instruction'

describe AInstruction do
  describe '#to_binary' do
    let(:instruction) { described_class.new('21') }

    it 'translates to binary correctly' do
      expect(instruction.to_binary).to eq('0000000000010101')
    end
  end
end
