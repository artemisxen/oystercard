require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }
  let(:oyster_empty) { described_class.new }
  let(:amount) { 50 }
  let (:fare) { 2 }
  let(:entrance) { "bank" }
  let(:exit_st) { "aldgate" }
  let(:journey) { double :journey }

  context '#initialize' do
    it 'has balance of 0' do
      expect(oyster.balance).to eq(described_class::DEFAULT_BALANCE)
    end

    it 'checks that the card has en empty list of journeys by default' do
      expect(oyster.history).to be_empty
    end
  end

  context '#top_up' do
    it 'top up to balance' do
      expect{oyster.top_up(amount)}.to change { oyster.balance }.by(amount)
  end

   it 'limits balance to 90' do
     maximum_balance = Oystercard::LIMIT
     oyster.top_up(maximum_balance)
     expect{ oyster.top_up(amount)}.to raise_error "Maximum limit exceeded £#{maximum_balance}"
   end
 end

  context 'station state' do
  before(:each) { oyster.top_up(amount) }

  #  it 'touches in card' do
  #    oyster.touch_in(entrance)
  #    expect(oyster.journey.incomplete?).to be true
  #  end

   it 'does not allow to touch in if balance is less than minimum fare' do
     expect{ oyster_empty.touch_in(entrance) }.to raise_error("Sorry, not enough balance!")
   end
 end

  context "#touch_in" do
  end

   context '#touch_out' do
     before (:each) do
       oyster.top_up(amount)
       oyster.touch_in(entrance)
       oyster.touch_out(exit_st)
     end

    #  it 'touches out card' do
    #    expect(oyster.journey.incomplete?).to be false
    #  end

     it 'checks that a charge is made on touch out' do
       expect{ oyster.touch_out(exit_st) }.to change {oyster.balance}.by (-described_class::MINIMUM_FARE)
     end

     it 'creates a record in the journey history after touching in/out' do
      expect(oyster.history.count).to eq 1
    end
   end
end
