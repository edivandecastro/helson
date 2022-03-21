require 'rails_helper'

RSpec.describe Service::Context, type: :model do
  describe ".build" do
    it "return an object instance of Service::Context" do
      expect(described_class.build).to be_instance_of(Service::Context)
    end

    context "when have params" do
      let(:name) { Faker::Name.name }

      it "return an object instance with your methods" do
        expect(described_class.build({ name: name }).name).to eq(name)
      end
    end
  end

  describe "#fail!" do
    let(:name) { Faker::Name.name }

    it "raise StandardError" do
      expect { described_class.build({ name: name }).fail! }.to raise_error(StandardError)
    end
  end

  describe "#fail" do
    let(:name) { Faker::Name.name }

    it "return true" do
      expect(described_class.build({ name: name }).fail).to be true
    end

    context "when have params" do
      let(:message) { "message error" }

      it "an error message is set in context" do
        context = described_class.build({ name: name })
        context.fail({ error: message })
        expect(context.error).to eq(message)
      end
    end
  end

  describe "#failure?" do
    let(:name) { Faker::Name.name }

    context "when have fail" do
      it "return true" do
        context = described_class.build({ name: name })
        context.fail

        expect(context.failure?).to be true
      end
    end

    context "when not have fail" do
      it "return false" do
        context = described_class.build({ name: name })

        expect(context.failure?).to be false
      end
    end
  end

  describe "#success?" do
    let(:name) { Faker::Name.name }

    context "when have fail" do
      it "return false" do
        context = described_class.build({ name: name })
        context.fail

        expect(context.success?).to be false
      end
    end

    context "when not have fail" do
      it "return true" do
        context = described_class.build({ name: name })

        expect(context.success?).to be true
      end
    end
  end
end
