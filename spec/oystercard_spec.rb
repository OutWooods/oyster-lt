require 'oyster_card'

describe OysterCard do
 subject(:card) { described_class.new }

 it "has a balance" do
   expect(card.balance).to eq 0
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
end
