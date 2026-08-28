require "spec_helper"

describe "requiring chef-gyoku" do
  # Guards the deferred require in Gyoku::Prettifier#prettify. These run in a
  # subprocess because this one has already loaded REXML via the prettifier
  # specs.
  def subprocess(script)
    lib = File.expand_path("../lib", __dir__)
    IO.popen([RbConfig.ruby, "-I", lib, "-e", script], &:read)
  end

  let(:rexml_loaded) { '$LOADED_FEATURES.any? { |f| f.end_with?("rexml/document.rb") }' }

  it "does not load REXML" do
    expect(subprocess("require 'chef-gyoku'; print #{rexml_loaded}")).to eq("false")
  end

  it "does not load REXML when building XML without pretty_print" do
    script = "require 'chef-gyoku'; " \
             "Gyoku.xml({ 'foo' => { 'bar' => 'baz' } }); " \
             "print #{rexml_loaded}"
    expect(subprocess(script)).to eq("false")
  end

  it "loads REXML when pretty_print is requested" do
    script = "require 'chef-gyoku'; " \
             "Gyoku.xml({ 'foo' => { 'bar' => 'baz' } }, pretty_print: true); " \
             "print #{rexml_loaded}"
    expect(subprocess(script)).to eq("true")
  end

  it "still prettifies correctly without an eager require" do
    script = "require 'chef-gyoku'; " \
             "print Gyoku.xml({ 'foo' => { 'bar' => 'baz' } }, pretty_print: true)"
    expect(subprocess(script)).to eq("<foo>\n  <bar>baz</bar>\n</foo>")
  end
end
