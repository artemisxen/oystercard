require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entrance) { "bank" }
  let(:exit_st) { "aldgate" }

  it 'responds to #start' do
    expect(journey).to respond_to(:start).with(1)
  end

  it 'starts the journey and returns the entry station' do
    expect(journey.start(entrance)).to eq entrance
  end

  it 'stores the entry station' do
    journey.start(entrance)
    expect(journey.entry_station).to eq entrance
  end

  it 'responds to #finish' do
    expect(journey).to respond_to(:finish).with(1)
  end

  it 'returns the fare' do
    expect(journey.fare.class).to be Integer
  end

  it 'stores the exit station' do
    journey.finish(exit_st)
    expect(journey.exit_station).to eq exit_st
  end

  describe '#incomplete?' do
    context 'touched in but not touched out' do
      before { journey.start(:entrance) }
      it 'is expected to be incomplete' do
        expect(journey).to be_incomplete
      end

      it 'is expected to return PENALTY_FARE' do
        expect(journey.fare).to eq described_class::PENALTY_FARE
      end
    end

    context 'touched out without touching in before' do
      before { journey.finish(:exit_st) }
      it 'is expected to return PENALTY_FARE' do
        expect(journey.fare).to eq described_class::PENALTY_FARE
      end
    end

    context 'touched out after touching in' do
      before { journey.start(:entrance) }
      before { journey.finish(:exit_st) }
      it 'is expected to be complete' do
        expect(journey.incomplete?).to be false
      end
    end
  end
end
