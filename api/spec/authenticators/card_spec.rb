require 'spec_helper'

RSpec.describe CardAuthenticator do
  let(:number) { nil }

  subject { described_class.new(number) }

  describe '#valid?' do
    it 'should not be valid' do
      expect(subject).to_not be_valid
    end

    context 'with invalid card' do
      let(:number) { 'ABC123' }

      it 'should not be valid' do
        expect(subject).to_not be_valid
      end
    end

    context 'with valid card' do
      let(:card)   { create :card }
      let(:number) { card.number }

      it 'should be valid' do
        expect(subject).to be_valid
      end

      context 'with one period' do
        let(:date)    { Time.parse('Nov, 3 2016 11:00:00') }
        let(:periods) { [build(:period, start_at: Time.parse('Nov, 2 2016'), end_at: Time.parse('Nov, 5 2016'), hours: hours)] }
        let(:user)    { build :user, periods: periods }
        let(:card)    { create :card, user: user }
        let(:hours)   { [] }
        let(:days)    { {} }

        before { Timecop.freeze date }
        after  { Timecop.return }

        it 'should be valid' do
          expect(subject).to be_valid
        end

        context 'when date not belongs to period' do
          let(:date) { Time.parse('Nov, 10 2016') }

          it 'should not be valid' do
            expect(subject).to_not be_valid
          end
        end

        context 'and more periods' do
          let(:periods) { [
            build(:period, start_at: Time.parse('Nov, 2 2016'),  end_at: Time.parse('Nov, 5 2016'),  hours: hours),
            build(:period, start_at: Time.parse('Nov, 10 2016'), end_at: Time.parse('Nov, 20 2016')),
          ] }

          it 'should be valid' do
            expect(subject).to be_valid
          end

          context 'when date not belongs to period' do
            let(:date) { Time.parse('Nov, 22 2016') }

            it 'should not be valid' do
              expect(subject).to_not be_valid
            end
          end

          context 'with multiple hours' do
            let(:hours) { [
              create(:hour, start_at: Time.parse('10:00:00'), end_at: Time.parse('12:00:00'), days: days),
              create(:hour, start_at: Time.parse('14:00:00'), end_at: Time.parse('18:00:00'))
            ] }

            it 'should be valid' do
              expect(subject).to be_valid
            end

            context 'when date belong to afternoon' do
              let(:date) { Time.parse('Nov, 3 2016 15:30:00') }

              it 'should be valid' do
                expect(subject).to be_valid
              end
            end

            context 'when date is at night' do
              let(:date) { Time.parse('Nov, 3 2016 18:30:00') }

              it 'should be valid' do
                expect(subject).to_not be_valid
              end
            end

            context 'when date not belongs to hours' do
              let(:date) { Time.parse('Nov, 12 2016') }

              it 'should not be valid' do
                expect(subject).to be_valid
              end
            end

            context 'with days' do
              let(:days) { { monday: true, thursday: true } }

              it 'should be valid' do
                expect(subject).to be_valid
              end

              context 'with monday' do
                let(:days) { { monday: true, thursday: false } }

                it 'should not be valid' do
                  expect(subject).to_not be_valid
                end
              end
            end
          end
        end

        context 'with one hour' do
          let(:hours) { [create(:hour, start_at: Time.parse('10:00:00'), end_at: Time.parse('12:00:00'), days: days)] }

          it 'should be valid' do
            expect(subject).to be_valid
          end

          context 'when hours not belongs' do
            let(:date) { Time.parse('Nov, 3 2016 12:01:00') }

            it 'should not be valid' do
              expect(subject).to_not be_valid
            end
          end

          context 'with days' do
            let(:days) { { monday: true, thursday: true } }

            it 'should be valid' do
              expect(subject).to be_valid
            end

            context 'with monday' do
              let(:days) { { monday: true, thursday: false } }

              it 'should not be valid' do
                expect(subject).to_not be_valid
              end
            end
          end
        end
      end

      context 'with holidays' do
        let(:date)     { Time.parse('Nov, 3 2016 11:00:00') }
        let!(:holiday) { create :holiday, happen_at: date }
        let(:user)     { build :user }
        let(:card)     { create :card, user: user }

        before { Timecop.freeze date }
        after  { Timecop.return }

        it 'should not be valid' do
          expect(subject).to_not be_valid
        end

        context 'and user have holiday' do
          let(:user) { build :user, holidays: [holiday] }

          it 'should be valid' do
            expect(subject).to be_valid
          end
        end
      end
    end
  end
end
