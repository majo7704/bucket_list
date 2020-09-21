admin = User.create! email: 'test@example.com', password: 'password', name: 'test', role: 'admin'
test1 = User.create! email: 'test1@example.com', password: 'password', name: 'test1'
test2 = User.create! email: 'test2@example.com', password: 'password', name: 'test2' 
test3 = User.create! email: 'test3@example.com', password: 'password', name: 'test3' 

1.upto(5) do |i|
  Idea.create! title: "Idea for #{admin.name} #{i} ", user: admin
  Idea.create! title: "Idea for #{test1.name} #{i} ", user: test1
  Idea.create! title: "Idea for #{test2.name} #{i} ", user: test2
  Idea.create! title: "Idea for #{test3.name} #{i} ", user: test3
end

admin.goals << test1.ideas.first
admin.goals << test2.ideas.first
admin.goals << test3.ideas.first
