# frozen_string_literal: true

module Gloom
  RSpec.describe Main do
    subject(:foo) { described_class.new }
    describe "#gloom" do
      context "when all is good" do
        let(:input) { "foo" }
        let(:result) { "foo" }

        it do
          expect(foo.gloom(input)).to eql(result)
        end
      end
    end
  end
end
