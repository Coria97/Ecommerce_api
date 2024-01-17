RSpec.shared_examples 'successful response' do
  let(:expected_keys) { %i[message] }
  let(:status_code) { 200 }

  it 'returns a 200 status code' do
    expect(response).to have_http_status(status_code)
  end

  it 'returns a json response' do
    expect(response.headers['Content-Type']).to include('application/json')
  end

  it 'contains expected keys in the response body' do
    if response_body.is_a?(Array)
      expect(response_body.first.keys.map(&:to_sym)).to eq(expected_keys)
    else
      expect(response_body.keys.map(&:to_sym)).to eq(expected_keys)
    end
  end
end
