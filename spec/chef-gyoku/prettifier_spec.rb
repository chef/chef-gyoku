RSpec.describe Gyoku::Prettifier do
  subject { described_class.new(options) }

  let(:options) { {} }

  describe "#prettify" do
    context "when xml is valid" do
      let(:xml) { Gyoku::Hash.build_xml(test: { pretty: "xml" }) }

      it "returns prettified xml" do
        expect(subject.prettify(xml)).to eq("<test>\n  <pretty>xml</pretty>\n</test>")
      end

      context "when indent option is specified" do
        let(:options) { { indent: 3 } }

        it "returns prettified xml with indent" do
          expect(subject.prettify(xml)).to eq("<test>\n   <pretty>xml</pretty>\n</test>")
        end
      end

      context "when compact option is specified" do
        let(:options) { { compact: false } }

        it "returns prettified xml without compacting text nodes" do
          expect(subject.prettify(xml)).to eq("<test>\n  <pretty>\n    xml\n  </pretty>\n</test>")
        end
      end
    end

    context "when xml is not valid" do
      let(:xml) { Gyoku::Array.build_xml(%w{one two}, "test") }

      it "raises an error" do
        expect { subject.prettify(xml) }.to raise_error REXML::ParseException
      end
    end
  end
end
