require './lib/alba_habla'

RSpec.describe AlbaHabla do
  describe '#process_command' do
    context 'when no subcommand is given' do
      it 'passes the given command to #talk' do
        ah = AlbaHabla.new('./')
        allow(ah).to receive(:talk).with('blah blah')
        ah.process_command('blah blah')
      end
    end

    context 'when a subcommand is given' do
      it 'calls the subcommand with the rest of the given command' do
        ah = AlbaHabla.new('./')
        allow(ah).to receive(:read).with('fake_book')
        ah.process_command('read fake_book')
      end
    end
  end
end
