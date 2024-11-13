require 'uri'

class UrlShortenerController < ApplicationController

  def generate_short_url
    url = params[:url]

    return render :json => {error: "invalid_url"}, status: 400 unless valid_url?(url)

    hash_link = Digest::SHA1.hexdigest(url)[8..16]
    ShortLink.create!(url: url, link_hash: hash_link)

    render :json => {url: url, hash_link: hash_link }
  rescue StandardError => e
    return render :json => {error: e.message, status: 500 }
  end

  def redirect_to_short_link_url

    link_hash = params[:link_hash]

    return render :json => {error: "invalid_url"}, status: 400 if link_hash.blank?

    short_link = ShortLink.find_by(link_hash: link_hash)

    return render :json => {error: "invalid_url"}, status: 400 if short_link.blank?
    return render :json => {error: "invalid_url"}, status: 400 if short_link.url.blank?

    if short_link.access_count.nil?
      short_link.update!(access_count: 1)
    else
      new_access_count = short_link.access_count + 1
      short_link.update!(access_count: new_access_count )
    end

    redirect_to(short_link.url, allow_other_host: true)
  rescue StandardError => e
    return render :json => {error: e.message, status: 500 }
  end

  def top_100_urls
    short_link_list = ShortLink.where.not(access_count: nil).order(access_count: :desc).limit(100)

    return render :json => {result: "no links"}, status: 404 if short_link_list.blank?

    top_links_list = short_link_list.map { |link| { url: link.url, access_count: link.access_count } }

    render :json => {result: top_links_list}
  end

  private

  def valid_url?(url)
    return false if url.blank?

    url.slice(URI::regexp(%w(http https))) == url
  end
end
