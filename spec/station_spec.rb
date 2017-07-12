require 'station'

describe Station do
  subject(:station) { described_class.new(name, zone) }
  let(:name) { "Bank" }
  let(:zone) { 1 }

  it "knows its name" do
    expect(subject.name).to eq name
  end

  it "knows its zone" do
    expect(subject.zone).to eq zone
  end
end
