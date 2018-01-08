require 'oyster_card'

describe OysterCard do
 subject(:card) {described_class.new}

 # it "has a balance which is a float" do
 #   expect(card.balance).to be_an_instance_of(Float)
 # end

 it "has a balance of 5" do
   expect(card.balance).to eq 0
 end
end
