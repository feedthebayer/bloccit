class CommentPolicy < ApplicationPolicy
  def update?
    create? && (record.user == user || user.admin?)
  end

  def destroy?
    update? || user.moderator?
  end
end
