require 'spec_helper'

require_relative '../translator'
require 'pathname'

describe Translator do
  let(:translator) { described_class.new(reader) }

  describe '#call' do
    context 'with label declaration and usage' do
      let(:file_path) do
        File.expand_path('fixtures/translator/label.txt', File.dirname(__FILE__))
      end
      let(:reader) do
        reader_double = double
        allow(reader_double).to receive(:each).
          and_yield('  @10').
          and_yield('  M=0').
          and_yield('').
          and_yield('(LOOP)').
          and_yield('  @LOOP')

        reader_double
      end

      it 'translates the label usage correctly' do
        result = translator.call
        # label is declared before instruction 2
        # so label usage translates to 10 in binary
        expect(result[2]).to eq('0000000000000010')
      end
    end

    context 'with variables' do
      let(:file_path) do
        File.expand_path('fixtures/translator/variables.txt', File.dirname(__FILE__))
      end
      let(:reader) do
        reader_double = double
        allow(reader_double).to receive(:each).
          and_yield('@foo').
          and_yield('@bar').
          and_yield('@baz')

        reader_double
      end

      it 'translates the variables addresses correctly, starting from 16' do
        result = translator.call
        expect(result).to eq(
          [
            '0000000000010000',
            '0000000000010001',
            '0000000000010010'
          ]
        )
      end
    end
  end
end
