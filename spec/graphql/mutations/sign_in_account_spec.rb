# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::SignInAccount do
  let(:mutation) { described_class.new(object: nil, context: context, field: nil) }

  let_it_be(:account) { create(:account, password: 'password') }
  let(:context) { { current_account: account } }

  describe '正しい引数を持っていること' do
    subject { described_class }

    it { is_expected.to accept_argument(:email).of_type('String!') }
    it { is_expected.to accept_argument(:password).of_type('String!') }
  end

  describe '#resolve' do
    subject { mutation.resolve(**params) }

    context '正しいログイン情報' do
      let(:params) { { email: account.email, password: 'password' } }

      it 'OK' do
        result = subject
        expect(result).to have_key(:account)
        expect(result).to have_key(:token)
        expect(result[:account]).to be_a Account
        expect(result[:token]).to be_a String
      end
    end

    context '不正なログイン情報' do
      let(:params) { { email: account.email, password: 'hoge' } }

      it 'UnauthorizedError' do
        expect { subject }.to raise_error(Exceptions::UnauthorizedError)
      end
    end
  end
end
