class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :student_id, :presence => true
  validates :class_name, :presence => true
  validates :home_address, :presence => true
  validates :phone_number, :presence => true
  validates :nickname, :presence => true
  validates :email, :presence =>true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :student_id, :class_name, :home_address, :phone_number, :books_borrow,
                  :nickname
  after_create :send_welcome_mail
  after_create  :set_group
  after_create  :set_book_borrow
  after_create  :set_date
  def set_date
    self.register_date = Date.today
    self.end_date = Date.today+1825
    self.save
  end
  def set_group
    self.group=1
    self.save
  end
  def set_book_borrow
    self.books_borrow =0
    self.save
  end
  def send_welcome_mail
     Mailer.welcome_email(self.student_id, self.email).deliver
  end
  
  def is_borrowed(bookid)
    old_transactions = Transaction.find(:all,:conditions => {:book_id => bookid, :user_id => self.id})
    if (!old_transactions)
      return false;
    else
      old_transactions.each do |transaction|
        if(transaction.status == 1) #dang muon, chua tra
          return true;
        end
      end
      return false;
    end
  end
  def can_borrow_more
    if (self.books_borrow < 3)
      return true;
    else
      return false;
    end
  end
  def get_group_name
    group = Usergroup.find(:first,:conditions=>{:id=>self.group.to_i})
    if(group)
      return group.group_name
    end
    return "Unknown"
  end
end
