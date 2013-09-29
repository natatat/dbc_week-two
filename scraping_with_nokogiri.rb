# Solution for Challenge: Scraping HN 1: Building Objects. Started 2013-09-25T16:33:04+00:00
require 'nokogiri'
require 'open-uri'
#write code that will take in URL and curl it to a file
#then open that file down here
 
html_file = open(ARGV[0])
DOC = Nokogiri::HTML(File.open(html_file))
 
 
 
class Post
  attr_reader :title, :comments, :obj_comments
  def initialize
    @title = DOC.search('.title > a:first-child').map{|link| link.inner_text}
    @url = DOC.search('.title > a:first-child').map{|link| link['href']}
    @points = DOC.search('.subtext > span:first-child').map{|span| span.inner_text}
    @item_id = DOC.search('.subtext > a:nth-child(3)').map{|link| link['href']}
    @comments = DOC.search('.comment > font:first-child').map{|comment| comment.inner_text}
    @user = DOC.search('.comhead > a:first-child').map{|element| element.inner_text}
    @obj_comments = []
  end
 
  def comment_counter
   "Number of comments: #{@comments.length}"
  end
 
  def add_user_comment(user_comment)
    @comments << Comment.new(user_comment).comment_text
  end
 
#this is supposed to create a new comment object for each comment in the HTML
  def mass_comment_creator
    @comments.each do |comment|
      @obj_comments << Comment.new(comment).comment_text
    end
  end

 #combines the user with each comment
 def user_comment_zipper
   @obj_comments.zip(@user)
 end
 
end
 
class Comment
  attr_reader :comment_text
 
 def initialize(comment_text)
    @comment_text = comment_text
 end
 
end
 
 
#puts 'this should return a part of a URL for the first comment' 
#puts DOC.search(' .comhead > a:first-child')[10]
#.map { |link| link['href']}
#puts DOC.search('.comhead > a:first-child')[10]  
#===========================================================================
 
post = Post.new
puts "Post title: #{post.title[0]}"
post.comments
puts post.comment_counter
 
post.add_user_comment("daniel sucks")
# puts post.comment_counter
# post.obj_comments
# puts post.comments
 
post.mass_comment_creator
# puts post.obj_comments
puts post.user_comment_zipper
 
# @user_id = DOC.search('.comhead > a:first-child'){|element| element['href']}
# @comment_link = DOC.search('.comhead > a:nth-child(2)'){|element| element['href']}