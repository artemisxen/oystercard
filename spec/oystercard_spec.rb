require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }
  let(:oyster_empty) { described_class.new }
  let(:amount) { 50 }
  let (:fare) { 2 }

  describe '#initialize' do
    it 'has balance of 0' do
      expect(oyster.balance).to eq(described_class::DEFAULT_BALANCE)
    end
  end

  describe '#top_up' do
    it 'top up to balance' do
     expect{oyster.top_up(amount)}.to change { oyster.balance }.by(amount)
   end

   it 'limits balance to 90' do
     maximum_balance = Oystercard::LIMIT
     oyster.top_up(maximum_balance)
     expect{ oyster.top_up(amount)}.to raise_error "Maximum limit exceeded £#{maximum_balance}"
   end
 end

 describe '#deduct' do
   it 'deducts fare from balance' do
     oyster.top_up(amount)
     expect{ oyster.deduct(fare) }.to change {oyster.balance}.by -fare
   end
 end

 describe 'station' do

  before(:each) { oyster.top_up(amount)}

  it 'is initially not in a journey' do
    expect(oyster).not_to be_in_journey
  end

   it 'touches in card' do
     oyster.touch_in
     expect(oyster).to be_in_journey
   end


   it 'shows card is in use' do
     oyster.touch_in
     expect(oyster.in_journey?).to be true
   end

   it 'does not allow to touch in if balance is less than minimum fare' do
     expect{ oyster_empty.touch_in }.to raise_error("Sorry, not enough balance!")
   end
 end

 context '#top_out' do
   before (:each) do
     oyster.top_up(amount)
     oyster.touch_in
     oyster.touch_out
   end

   it 'touches out card' do
     expect(oyster).not_to be_in_journey
   end

   it 'checks that a charge is made on touch out' do
     expect{ oyster.touch_out }.to change {oyster.balance}.by -described_class::MINIMUM_FARE
   end

 end

end
