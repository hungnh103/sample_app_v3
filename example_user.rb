class User
  attr_accessor :first_name, :last_name, :email

  def initialize attribute = {}
    @first_name = attribute[:first_name]
    @last_name = attribute[:last_name]
    @email = attribute[:email]
  end

  def full_name
    "#{@first_name} #{@last_name}"
  end

  def formatted_email
    full_name + " <#{@email}>"
  end

  def alphabetical_name
    "#{@last_name}, #{@first_name}"
  end
end
