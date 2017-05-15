
require_relative './../spec_helper.rb'

describe HelpService do
  describe '#call' do
    it "Response have the main commands" do
      response = HelpService.new({}).call()
      expect(response).to match('help')
      expect(response).to match('Add to FAQ')
      expect(response).to match('Remove ID')
      expect(response).to match('What do you know about X')
      expect(response).to match('Search for hashtag X')
      expect(response).to match('Questions and Answers')
    end
  end
end
