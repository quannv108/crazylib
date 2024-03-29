class BooksController < ApplicationController
  layout 'admin', :only => [:new,:show_all,:edit]
  # GET /books
  # GET /books.json
  def index
    topics = Book.select(:topic).uniq
    @books = Array.new
    topics.each do |topic|
      @book = Array.new
      @book = Book.find(:all,:conditions=>{:topic=>topic.topic})
      @books.push(@book)
    end
    @sciences = Book.find(:all,:conditions=>{:topic=>"1"});
    respond_to do |format|
      format.html # view.html
      format.json { render json: @sciences }
    end
  end
  
  def view
  book =  Book.find(params[:id]);
  views = book.seen_by.to_i+1; 
  book.update_attributes(:seen_by=>views);
  end
  #
  def newbook
  @books = Book.find(:all,:order=>"created_at DESC",:limit=>20);
  end
  
  def popular
  @books = Book.find(:all,:order=>"seen_by DESC",:limit=>20);
  end
  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    if (!@book.current_quantity)
      @book.update_attributes(:current_quantity=>:quantity)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
    @book = Book.find(:all,:conditions=>{:bookId=>params[:id]});
    respond_to do|format|
      format.html
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @book }
    end
  end
  
  def page
  respond_to do |format|
      format.html {render :layout => false}
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    params[:book][:current_quantity]=params[:book][:quantity]
    params[:book][:date_of_storing]=Date.today
    @book = Book.new(params[:book])
    respond_to do |format|
      if @book.save
        format.html { redirect_to "/admin/show_books", notice: 'Book was successfully created.' }
        #format.json { render json: @book, status: :created, location: @book }
      else
        format.html { redirect_to "/admin/add_book", notice: 'Failed'}
        #format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])
  #"/books/view?topic=<%=@book.topic%>&id=<%=@book.id%>"
    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to "/admin/show_books", notice: 'Book was successfully updated.' }
       format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  #def searchByTitle
   # @books = Book.searchByTitle params[:search]
  #end

  def search
    if params[:keyword]
      @books = Book.search(params[:filter].to_i ,params[:keyword])
    else
      @book = Book.find(:all)
    end
  end
  def show_all
    @books=Book.all
  end
end
