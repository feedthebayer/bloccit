class FavoriteMailer < ActionMailer::Base
  default from: "bbayer3@gmail.com"

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@bayer-bloccit.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@bayer-bloccit.com>"
    headers["References"] = "<post/#{post.id}@bayer-bloccit.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
