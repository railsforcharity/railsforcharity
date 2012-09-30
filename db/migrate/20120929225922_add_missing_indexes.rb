class AddMissingIndexes < ActiveRecord::Migration
  class AddMissingIndexes < ActiveRecord::Migration
    def self.up
      add_index :authentications, :user_id
      add_index :avatars, [:avatarable_id, :avatarable_type]
      add_index :collaborators, :user_id
      add_index :collaborators, :project_id
      add_index :collaborators, [:user_id, :project_id]
      add_index :collaborators, [:project_id, :user_id]
      add_index :comments, [:commentable_id, :commentable_type]
      add_index :locations, [:locatable_id, :locatable_type]
      add_index :projects, :created_by
      add_index :taggings, [:taggable_id, :taggable_type]
      add_index :taggings, :tag_id
      add_index :taggings, [:tag_id, :task_id]
      add_index :taggings, [:task_id, :tag_id]
      add_index :tasks, :project_id
      add_index :tasks, :created_by
      add_index :tasks, :assigned_to
    end

    def self.down
      remove_index :authentications, :user_id
      remove_index :avatars, :column => [:avatarable_id, :avatarable_type]
      remove_index :collaborators, :user_id
      remove_index :collaborators, :project_id
      remove_index :collaborators, :column => [:user_id, :project_id]
      remove_index :collaborators, :column => [:project_id, :user_id]
      remove_index :comments, :column => [:commentable_id, :commentable_type]
      remove_index :locations, :column => [:locatable_id, :locatable_type]
      remove_index :projects, :created_by
      remove_index :taggings, :column => [:taggable_id, :taggable_type]
      remove_index :taggings, :tag_id
      remove_index :taggings, :column => [:tag_id, :task_id]
      remove_index :taggings, :column => [:task_id, :tag_id]
      remove_index :tasks, :project_id
      remove_index :tasks, :created_by
      remove_index :tasks, :assigned_to
    end
  end
end
