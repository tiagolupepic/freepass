require 'spec_helper'

describe AuthenticatorService do
  subject { described_class.new(name, content) }

  context 'User' do
    let(:name)    { 'user' }
    let(:content) { '123456' }
    let(:user)    { create :user }
    let(:auth)    { double valid?: true, object: user }

    before do
      allow(UserAuthenticator).to receive(:new).with(content).and_return auth
    end

    it 'should return hash' do
      expect(subject.run).to eq ({ success: true, user: user })
    end

    it 'should create event' do
      subject.run

      expect(Event.count).to eq 1
    end
  end

  context 'Admin' do
    let(:name)    { 'admin' }
    let(:content) { '123456' }
    let(:user)    { create :user, role: 'admin' }
    let(:auth)    { double valid?: true, object: user }

    before do
      allow(AdminAuthenticator).to receive(:new).with(content).and_return auth
    end

    it 'should return hash' do
      expect(subject.run).to eq ({ success: true, user: user })
    end

    it 'should create event' do
      subject.run

      expect(Event.count).to eq 1
    end
  end

  context 'Card' do
    let(:name)    { 'card' }
    let(:content) { '999' }
    let(:user)    { create :user }
    let(:auth)    { double valid?: true, object: user }

    before do
      allow(CardAuthenticator).to receive(:new).with(content).and_return auth
    end

    it 'should return hash' do
      expect(subject.run).to eq ({ success: true, user: user })
    end

    it 'should create event' do
      subject.run

      expect(Event.count).to eq 1
    end
  end
end
