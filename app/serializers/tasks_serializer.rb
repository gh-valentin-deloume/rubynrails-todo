class TasksSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :done, :author_id, :id, :created_at
end
