class AdminAuthorizer < Authority::Authorizer
  def self.default(adjective, user)
    # Admin can do anything!
    user.has_role? :admin
  end

  def self.dashboard_accessible_by?(user)
    user.has_role? :admin
  end
end