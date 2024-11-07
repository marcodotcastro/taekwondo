require 'rails_helper'

RSpec.describe Match, type: :model do
  describe '#time_remaining' do
    let(:duration) { 120 } # 2 minutos
    let(:match) { create(:match, duration: duration) }

    context 'when match has not started' do
      it 'returns full duration' do
        expect(match.time_remaining).to eq(duration)
      end
    end

    context 'when match is in progress' do
      before do
        freeze_time # Congela o tempo para os testes
        match.update(
          status: :in_progress,
          started_at: Time.current
        )
      end

      after do
        travel_back # Descongela o tempo após cada teste
      end

      it 'returns remaining time after 30 seconds' do
        travel(30.seconds) do
          expect(match.reload.time_remaining).to be_within(1).of(90)
        end
      end

      it 'returns remaining time after 1 minute' do
        travel(60.seconds) do
          expect(match.reload.time_remaining).to be_within(1).of(60)
        end
      end

      it 'returns remaining time near the end' do
        travel(115.seconds) do
          expect(match.reload.time_remaining).to be_within(1).of(5)
        end
      end

      it 'returns 0 when time has exceeded duration' do
        travel(125.seconds) do
          expect(match.reload.time_remaining).to eq(0)
        end
      end
    end

    context 'when match is finished' do
      it 'returns 0 regardless of time elapsed' do
        freeze_time
        match.update(
          status: :finished,
          started_at: Time.current - 30.seconds
        )
        expect(match.time_remaining).to eq(0)
        travel_back
      end
    end

    context 'with different durations' do
      it 'handles minimum duration (30 seconds)' do
        match = create(:match, duration: 30)
        expect(match.time_remaining).to eq(30)
      end

      it 'handles maximum duration (10 minutes)' do
        match = create(:match, duration: 600)
        expect(match.time_remaining).to eq(600)
      end
    end

    context 'edge cases' do
      it 'handles nil started_at' do
        match.update(started_at: nil)
        expect(match.time_remaining).to eq(duration)
      end

      it 'handles future started_at' do
        freeze_time
        match.update(
          status: :in_progress,
          started_at: 10.seconds.from_now
        )
        expect(match.time_remaining).to eq(duration)
        travel_back
      end

      it 'handles very small remaining times' do
        freeze_time
        match.update(status: :in_progress, started_at: Time.current)
        travel(119.9.seconds)
        expect(match.time_remaining).to be_within(1).of(0.1)
        travel_back
      end
    end
  end
end