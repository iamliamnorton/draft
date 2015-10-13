class Guest
  def email
    ""
  end

  def credit
    0
  end

  def guest?
    true
  end

  def admin
    false
  end
  alias_method :admin?, :admin
end
