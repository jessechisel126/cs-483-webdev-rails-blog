module BlogPostsHelper
  def trim_post_body(post_body)
    truncate post_body, length: 60, separator: /\w/, omission: "..."
  end
end
