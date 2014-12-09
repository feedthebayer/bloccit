class PostPolicy < ApplicationPolicy
  def update?
    create? && (record.user == user || user.admin?)
  end

  def destroy?
    user.present? && can_moderate?
  end
end
