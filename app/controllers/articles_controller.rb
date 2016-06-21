class ArticlesController < ApplicationController
  
  before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]


def download
    @articles = Article.all
    respond_to do |format| 
       format.xlsx {render xlsx: 'download',filename: "articles.xlsx"}
    end
end

  def index
  	@articles = Article.all
  end

  def new
  @article = Article.new
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

   def destroy

    @article = Article.find_by_id(params[:id])

    if @article.destroy

        flash[:notice] = "Success Delete a Records"

        redirect_to action: 'index'

    else

        flash[:error] = "fails delete a records"

        redirect_to action: 'index'

    end

end

  def update

 @article = Article.find_by_id(params[:id])

 if @article.update(params_article)

    flash[:notice] = "Success Update Records"

    redirect_to action: 'index'

 else

    flash[:error] = "data not valid"

    render 'edit'

 end

end

 def show

        @article = Article.find_by_id(params[:id])

        @comments = @article.comments.order("id desc")

        @comment = Comment.new

    end

  def create
   @article = Article.new(params_article)

    if @article.save

        flash[:notice] = "Success Add Records"

        redirect_to action: 'index'

    else

        flash[:error] = "data not valid"

        render 'new'
    end
  end

  def export
  @article = Article.find_by_id(params[:id])
    @comments = @article.comments.all
    @comment = Comment.new
    filename = "article.xlsx"
    respond_to do|format|
      format.html
      format.xlsx{}
    end   

  def import
     spreadsheet = open_spreadsheet(file)
    page_article = spreadsheet.sheet('Article')

    (2..page_article.last_row).each do |no_row|
      @article = Article.create(
        title: page_article.row(no_row)[0],
        content: page_article.row(no_row)[1],
      status: page_article.row(no_row)[2])
    end

    page_comment = spreadsheet.sheet('Comment')
    (2..page_comment.last_row).each do |no_row|
      @comments = Comment.create(
        article_id: @article.id,
        user_is: page_comment.row(no_row)[1],
      content: page_comment.row(no_row)[2])
    end
  end

  end
   private

    def params_article

        params.require(:article).permit(:title, :content, :status)

    end




end

