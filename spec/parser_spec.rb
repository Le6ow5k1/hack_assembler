require 'spec_helper'

require_relative '../parser'

describe Parser do
  describe '#parse_line' do
    subject(:parsed_line) { described_class.new.parse_line(line) }

    context 'A instruction' do
      let(:line) { '@37' }

      it do
        expect(parsed_line.address).to eq('37')
      end
    end

    context 'C instruction with dest and comp' do
      let(:line) { 'D=D-M' }

      it do
        expect(parsed_line.dest).to eq('D')
        expect(parsed_line.comp).to eq('D-M')
        expect(parsed_line.jump).to eq(nil)
      end
    end

    context 'C instruction with comp and jump' do
      let(:line) { 'D;JGT' }

      it do
        expect(parsed_line.dest).to eq(nil)
        expect(parsed_line.comp).to eq('D')
        expect(parsed_line.jump).to eq('JGT')
      end
    end

    context 'label declaration' do
      let(:line) { '   (LOOP)' }

      it do
        expect(parsed_line.label?).to eq(true)
        expect(parsed_line.name).to eq('LOOP')
      end
    end

    context 'symbol' do
      let(:line) { '@foo' }

      it do
        handle_symbol_proc = proc { |_symbol| 100 }
        parsed_line = described_class.new.parse_line(line, handle_symbol_proc)

        expect(parsed_line.address).to eq(100)
      end
    end

    context 'line with whitespace and comments' do
      let(:line) { '   D;JGT // jump if greater' }

      it 'ignores whitespace and comments' do
        expect(parsed_line.dest).to eq(nil)
        expect(parsed_line.comp).to eq('D')
        expect(parsed_line.jump).to eq('JGT')
      end
    end

    context 'whitespace line' do
      let(:line) { '   ' }

      it 'ignores it' do
        expect(parsed_line).to eq(nil)
      end
    end

    context 'comment line' do
      let(:line) { '  // D=1 some comment ' }

      it 'ignores it' do
        expect(parsed_line).to eq(nil)
      end
    end
  end
end
