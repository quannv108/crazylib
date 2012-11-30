class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    logger.debug "new transaction"
    #@transaction = Transaction.new
    #check login
    if(user_signed_in?)
      logger.debug params
      #check book
      book = Book.find(:first, :conditions => {:id =>params[:id]})
      if(!book)
        respond_to do |format|
          format.html { redirect_to home_path, notice: 'Invalid Book.' }
        end
      return;
      end
      #check current_quantity
      if (!book.current_quantity)
        #book.current_quantity = book.quantity
        book.update_attributes(:current_quantity=>book.quantity)
      #book.save
      end
      #check user
      if(!current_user.books_borrow)
        current_user.update_attributes(:books_borrow => 0)
      end
      if(current_user.books_borrow > 3 )# FIX ME if use admin control
        #borrow enough books, can't borrow anymore
        redirect_to "/books/view?topic=#{book.type}&id=#{book.id}";
      return;
      end
      #check old transaction
      old_transactions = Transaction.find(:all, :conditions => {:book_id=>book.id, :user_id=>current_user.id})
      old_transactions.each do |old_transaction|
        if(old_transaction.status == 1)#borrow but haven't return
          redirect_to "/books/view?topic=#{book.type}&id=#{book.id}";
        #FIX ME, redirect to already borrow page
        return;
        end
      end
      if (book.current_quantity > 0)
        @transaction = Transaction.new();
        @transaction.book_id    = book.id;
        @transaction.user_id    = current_user.id;
        @transaction.day_borrow = Date.today.to_s;
        @transaction.day_return = (Date.current+14).to_s;
        @transaction.status     = 1 ;#dang muon
        @transaction.save;
        #current_quantity increase
        book.current_quantity -=1;
        book.save;
        #user borrow book increase
        current_user.update_attributes(:books_borrow => current_user.books_borrow+1)

        redirect_to "/books/view?topic=#{book.type}&id=#{book.id}";
      return;
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: 'You must login first.' }
      end
    # redirect_to new_user_session_path
    return;
    end
    redirect_to "/";
    return;
    respond_to do |format|
    #format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end
end