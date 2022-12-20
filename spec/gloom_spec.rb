# frozen_string_literal: true

RSpec.describe Gloom do
  let(:source_row) { %w[alpha beta] }
  let(:options)    { { foo: :bar } }
  let(:instance)   { klass.new(source_row, options) }

  describe "#valid?" do
    subject(:import_model_valid) { instance.valid? }

    let(:klass) do
      Class.new do
        include Gloom::Model
        include Gloom::Import

        column :id

        def self.name
          "Whatever"
        end
      end
    end

    context "with 1 validation" do
      before do
        klass.class_eval { validates :id, presence: true }
      end

      it do
        expect(import_model_valid).to be true
      end

      context "with empty row" do
        let(:source_row) { %w[] }

        it do
          expect(import_model_valid).to be false
          expect(instance.errors.full_messages).to eql ["Id can't be blank"]
        end
      end
    end
  end
end
