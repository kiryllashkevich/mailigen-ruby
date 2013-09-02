require 'spec_helper'

describe Mailigen::Api do
  describe Mailigen::Api do

    before(:all) do
      @invalid_mailigen = invalid_mailigen_obj
      @mailigen = valid_mailigen_obj
    end
    
    context "initialize with no api key" do

      it "raise error" do
        expect { Mailigen::Api.new }.to raise_error(Mailigen::NoApiKeyError)
      end

    end

    context "initialize" do

      it "returns object with api key" do
        expect(@invalid_mailigen).not_to be(nil)
        expect(@invalid_mailigen.api_key).to eq("fookey")
      end

    end

    describe "api_url" do

      context "secure" do

        it "return url" do
          obj = Mailigen::Api.new "fookey", true
          expect(obj.api_url).to eq("https://api.mailigen.com/1.3/?output=json")
        end

      end

      context "default (unsecure)" do
        it "return url" do
          expect(@invalid_mailigen.api_url).to eq("http://api.mailigen.com/1.3/?output=json")
        end
      end

    end

    if valid_mailigen_obj
      describe "call" do

        describe "ping" do

          context "invalide mailigen key" do
            it "returns error" do
              resp = @invalid_mailigen.call :ping
              expect(resp["code"]).to eq(104)
              expect(resp["error"]).to eq("Invalid Mailigen API Key: fookey")
            end
          end

          context "valide mailigen key" do
            it "returns OK" do
              resp = @mailigen.call :ping
              expect(resp).to eq("Everything's Ok!")
            end
          end

        end

        describe "lists" do
          before(:all) do
            # Creates list
            resp = @mailigen.call :listCreate, {title: "testListRspec", options: {permission_reminder: "Your in", notify_to: "foo@bar.com", subscription_notify: false}}
            @list_id = resp
          end
          after(:all) do
            # Removes list
            resp = @mailigen.call :listDelete, {id: @list_id}
          end

          context "createList" do
            it "returns list id" do
              expect(@list_id).not_to be(nil)
            end
          end

          context "lists" do
            it "returns lists containg testListRspec" do
              exists = false
              resp = @mailigen.call :lists
              selected_lists = resp.select { |list| list["name"] == "testListRspec" }
              expect(selected_lists.size).to eq(1)
            end
          end

          context "listMergeVars" do
            it "returns array with vars" do
              resp = @mailigen.call :listMergeVars, {id: @list_id}
              expect(resp.size).to eq(3)
            end
          end

          context "listMergeVarAdd" do
            it "returns true" do
              params = {id: @list_id, tag: "FOO", name: "FooName"}
              resp = @mailigen.call :listMergeVarAdd, params
              expect(resp).to eq("true")
            end
          end
        end
      end

    end

  end
end