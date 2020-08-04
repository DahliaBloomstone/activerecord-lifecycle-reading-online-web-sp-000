class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case

  # New Code!!
  # before_save is called after validation occurs:
  # before_save :make_title_case
    before_validation :make_title_case #happens before validation, title cases the title then the validation runs 

  private
  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

# make sure validation always passes vefore every save
# rails to run our title-case algorithm on the title of the Post
# to make sure all of our Posts have the correctly formatted title, we are going to run make_title_case during the first of the available lifecycle points
# before_save
  def make_title_case
    self.title = self.title.titlecase
  end
end

#We'd expect that whenever Rails persists Post models to the database, (so #save and #create) this code will get run.
#bundle exec rails c (console):
# p = Post.create(title: "testing")
# p.valid? => false, it wasn't saved to the database
