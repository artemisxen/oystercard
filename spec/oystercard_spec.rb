require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }
  let(:oyster_empty) { described_class.new }

  describe '#initialize' do
    it 'has balance of 0' do
      expect(oyster.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'top up to balance' do
     expect{oyster.top_up 50}.to change { oyster.balance }.from(0).to(50)
   end

   it 'limits balance to 90' do
     maximum_balance = Oystercard::MAXIMUM_BALANCE
     oyster.top_up(maximum_balance)
     expect{ oyster.top_up 1 }.to raise_error "Maximum limit exceeded £#{maximum_balance}"
   end
 end

 describe '#deduct' do
   it 'deducts fare from balance' do
     oyster.top_up(20)
     expect{ oyster.deduct 2 }.to change {oyster.balance}.from(20).to(18)
   end
 end

 describe 'station' do

  before do
    oyster.top_up(20)
  end

  it 'is initially not in a journey' do
    expect(oyster).not_to be_in_journey
  end

   it 'touches in card' do
     oyster.touch_in
     expect(oyster).to be_in_journey
   end

   it 'touches out card' do
     oyster.touch_in
     oyster.touch_out
     expect(oyster).not_to be_in_journey
   end

   it 'shows card is in use' do
     oyster.touch_in
     expect(oyster.in_journey?).to be true
   end

   it 'does not allow to touch in if balance is less than minimum fare' do
     expect{ oyster_empty.touch_in }.to raise_error("Sorry, not enough balance!")
   end
 end

end
