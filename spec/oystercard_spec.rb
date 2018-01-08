require 'oyster_card'

describe OysterCard do
 subject(:card) { described_class.new }
 let(:entry_station) { double :entry_station }

 it "has a balance" do
   expect(card.balance).to eq 0
 end
 it 'initializes not in journey' do
   expect(card).not_to be_in_journey
 end

 describe '#top_up' do
   it 'increases balance when topped up' do
     expect { card.top_up(5) }.to change { card.balance }.by (5)
   end
   # two options for test - test below would allow balance to be private if required
   it 'returns increased balance when topped up' do
     expect(card.top_up(8)).to eq 8
   end

   it 'raises error when topped up above default max balance' do
     max = OysterCard::BALANCE_MAX
     expect{card.top_up(max + 1)}.to raise_error("Maximum balance exceeded, max is #{max}")
   end
 end

 describe '#touch_in' do
   it 'will raise error if balance less than minimum fare' do
     expect { card.touch_in(entry_station) }.to raise_error "Insufficient funds available"
   end
   context 'card has been topped up' do
     before do
       card.top_up(OysterCard::MIN_FARE)
       card.touch_in(entry_station)
     end
     it 'changes in journey to true' do
       expect(card).to be_in_journey
     end
     it 'stores journey entry station' do
       expect(card.entry_station).to eq entry_station
     end
   end

 end
 describe '#touch_out' do
   before do
     card.top_up(OysterCard::MIN_FARE)
     card.touch_in(entry_station)
   end
   it 'changes in journey to false' do
     card.touch_out
     expect(card).not_to be_in_journey
   end

   it "changes balance by minimum fare" do
     expect { card.touch_out }.to change { card.balance }.by (-OysterCard::MIN_FARE)
   end
   it 'updates entry_station to nil' do
     card.touch_out
     expect(card.entry_station).to be_nil
   end
 end
end
