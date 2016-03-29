Post.all.each_with_index do |post, index|
  3.times.each { |n| Comment.create(text: "comment #{index} #{n}", post: post) }
end
