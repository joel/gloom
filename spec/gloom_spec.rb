# frozen_string_literal: true

class BasicImportModel
  include Gloom::Model
  include Gloom::Import

  column :alpha
  column :beta

  def self.name
    "BasicImportModel"
  end
end

RSpec.describe Gloom do
  let(:source_row) { %w[alpha beta] }
  let(:options)    { { foo: :bar } }
  let(:instance)   { klass.new(source_row, options) }
  let(:klass)      { BasicImportModel }

  describe "#valid?" do
    subject(:import_model_valid) { instance.valid? }

    context "with 1 validation" do
      before do
        klass.class_eval { validates :alpha, presence: true }
      end

      it do
        expect(import_model_valid).to be true
      end

      context "with empty row" do
        let(:source_row) { %w[] }

        it do
          expect(import_model_valid).to be false
          expect(instance.errors.full_messages).to eql ["Alpha can't be blank", "Alpha can't be blank"]
          expect(instance.attribute_objects[:alpha].column_name).to be :alpha
          expect(instance.attribute_objects[:alpha].attribute_errors).to eql ["can't be blank"]
          expect(instance.attribute_objects[:alpha].errors.full_messages).to eql ["Alpha can't be blank"]
        end
      end
    end
  end

  describe "#attribute_objects" do
    subject(:attribute_objects) { instance.attribute_objects }

    it "returns a hash of cells mapped to their column_name" do
      expect(attribute_objects.keys).to eql klass.column_names
      expect(attribute_objects.values.map(&:class)).to eql [Gloom::Import::Attribute] * 2
    end

    context "when invalid" do
      before do
        klass.class_eval { validates :alpha, format: { with: /\A\d+\z/ } }
      end

      it "returns the cells with the right attributes" do
        allow(instance).to receive(:valid?).and_call_original

        expect(instance.valid?).to be false

        expect(instance.errors.to_hash).to eql({ alpha: ["is invalid"] })
        expect(instance.errors.include?(:alpha)).to be true
        expect(instance.errors.messages_for(:alpha)).to eql(["is invalid"])
        expect(instance.errors.include?(:beta)).to be false
        expect(instance.errors.full_messages).to eql(["Alpha is invalid"])

        values = attribute_objects.values

        expect(values.map(&:column_name)).to eql %i[alpha beta]
        expect(values.map(&:value)).to eql [nil,  "beta"]
        expect(values.map(&:source_value)).to eql %w[alpha beta]
        expect(values.map(&:attribute_errors)).to eql [["is invalid"], []]
      end
    end
  end
end
