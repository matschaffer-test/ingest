# frozen_string_literal: true

describe Device, type: :model do
  describe 'numeric_id validation' do
    it { expect(device_with(numeric_id: -1)).to be_invalid }
    it { expect(device_with(numeric_id: 0)).to be_valid }
    it { expect(device_with(numeric_id: 1)).to be_valid }
    it { expect(device_with(numeric_id: 2 ** 32)).to be_valid }
    it { expect(device_with(numeric_id: 2 ** 32 + 1)).to be_invalid }
    it { expect(device_with(numeric_id: 1.2)).to be_invalid }

    def device_with(numeric_id:)
      described_class.create(numeric_id: numeric_id, payload: { numeric_id: numeric_id })
    end
  end
end
