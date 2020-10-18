# frozen_string_literal: true

require 'spec_helper'

require_relative '../c_instruction'

describe CInstruction do
  describe '#to_binary' do
    context 'M=1' do
      let(:instruction) { described_class.new('M', '1', nil) }

      it { expect(instruction.to_binary).to eq('1110111111001000') }
    end

    context 'D=D+1;JGT' do
      let(:instruction) { described_class.new('D', 'D+1', 'JGT') }

      it { expect(instruction.to_binary).to eq('1110011111010001') }
    end

    context 'AMD=D&M;JNE' do
      let(:instruction) { described_class.new('AMD', 'D&M', 'JNE') }

      it { expect(instruction.to_binary).to eq('1111000000111101') }
    end
  end
end
