authorization do
  role :guest do
    has_permission_on :users, :to => [:read]
  end

  role :project_admin do
    has_permission_on :projects, :to => :manage do
      if_attribute :collaborator => true
    end
  end

  role :admin do
    has_permission_on :users, :to => [:delete]
  end
end

privileges do
  privilege :manage do
    includes :create, :read, :update, :delete
  end
end