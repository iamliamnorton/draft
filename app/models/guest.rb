class Guest
  def email
    ""
  end

  def guest?
    true
  end

  def admin
    false
  end
  alias_method :admin?, :admin
end
