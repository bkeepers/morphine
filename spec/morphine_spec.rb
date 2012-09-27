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

    it 'defines writer method to change service' do
      container.client = 'new client'
      container.client.should eq('new client')
    end

    it 'passes arguments through to the block' do
      Container().register(:pass_through) { |argument| argument }
      container.pass_through(:a).should == :a
    end
  end
end
