module Api
  module V1
    class ProjectsController < BaseController
      def index
        projects = Project.all

        render json: projects, meta: {message: "projects information"}, root: 'projects',
          each_serializer: ProjectSerializer
      end
    end
  end
end