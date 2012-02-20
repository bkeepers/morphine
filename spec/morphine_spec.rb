require 'spec_helper'

describe Morphine do
  let :Container do
    Class.new do
      include Morphine
    end
  end

  let(:container) { Container().new }

  describe 'register' do
    before do
      Container().register(:client) { 'client' }
    end

    it 'yields block to instantiate dependency' do
      container.client.should == 'client'
    end

    it 'memoizes result' do
      container.client.object_id.should == container.client.object_id
    end

    it 'instance evals block to resolve dependencies' do
      Container().register(:service) { Struct.new(:client).new(client) }
      container.service.client.should == container.client
    end
  end
end