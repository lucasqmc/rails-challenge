require 'rails_helper'

RSpec.describe "UrlShorteners", type: :request do
  describe "GET /top_100_urls" do

    context 'when there is short_links with access count' do

      before do
        (1..150).each do |val|
          ShortLink.create!(url: "http://testa.com#{val}", link_hash: "12312#{val}" , access_count: val )
        end
      end

      it 'should return success response ' do
        get "/top_100_urls"
        expect(response).to have_http_status(:success)
      end


      it 'should return an array with 100 elements ordered by access count' do
        get "/top_100_urls"

        expected_array = ShortLink.where.not(access_count: nil).order(access_count: :desc).limit(100).map { |link| { url: link.url, access_count: link.access_count } }

        expect(JSON.parse(response.body)['result'].count).to eq(100)
        expect(JSON.parse(response.body)['result']).to eq(expected_array.as_json)
      end
    end

    context 'when there is no short_links with access count' do
      it 'should return not found response' do
        get "/top_100_urls"
        expect(response).to have_http_status(:not_found)
      end
    end

  end
end
