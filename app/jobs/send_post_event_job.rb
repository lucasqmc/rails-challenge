
class SendPostEventJob < ApplicationJob
  queue_as :default

  def perform(post)
    post.reload
    body = post.to_json(only: [:title, :content])

    response = Typhoeus.post("https://eom153qixyawv2.m.pipedream.net",
      headers: { "Content-Type" => "application/json" },
      body: body
    )
  end
end
