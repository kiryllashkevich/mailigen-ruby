require 'spec_helper'

describe Mailigen do

  context "module" do

    it "exists" do
      expect(Mailigen).not_to be(nil)
    end

  end

  context "defaults" do

    it "has api_host" do
      expect(Mailigen::api_host).to eq("api.mailigen.com")
    end

    it "has api_version" do
      expect(Mailigen::api_version).to eq("1.3")
    end

  end

end