module PivotalTracker
  class Iteration
    include HappyMapper

    class << self
      def all(project, options={})
        params = PivotalTracker.encode_options(options)
        parse(Client.connection["/projects/#{project.id}/iterations#{params}"].get)
      end
      
      def current(project)
        array = parse(Client.connection["projects/#{project.id}/iterations/current"].get)
        array.first if array
      end

      def done(project)
        array = parse(Client.connection["projects/#{project.id}/iterations/done"].get)
        array.first if array
      end

      def all_done(project)
        parse(Client.connection["projects/#{project.id}/iterations/done"].get)
      end

      def backlog(project)
        array = parse(Client.connection["projects/#{project.id}/iterations/backlog"].get)
        array.first if array
      end
    end

    element :id, Integer
    element :number, Integer
    element :start, DateTime
    element :finish, DateTime
    has_many :stories, Story

  end
end
