require 'rails_helper'

describe MobileApi::V1::ModelsController do
  context 'GET show' do
    before { get :show }
    it { expect(response).to be_success }
  end
end
