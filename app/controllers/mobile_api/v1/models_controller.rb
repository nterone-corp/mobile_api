class MobileApi::V1::ModelsController < MobileApi::V1::BaseController

  def show
    @type = params[:type]
    @id = params[:id]

    @klass = @type.constantize
    if @klass < ActiveRecord::Base
      @object = @klass.find(@id)
      authorize @object, :show?
      respond_with @object
    else
      raise 'The type is wrong'
    end
  end

  def index
    @type = params[:type]

    @klass = @type.constantize
    if @klass < ActiveRecord::Base

      if params[:ids] == 'all'
        @objects = @klass.all.page(params[:page]).per(params[:per_page])
      else
        @ids = JSON.parse(params[:ids])
        @ids = Kaminari.paginate_array(@ids).page(params[:page]).per(params[:per_page])
        @objects = @klass.find(@ids)
      end

      if @objects.any?
        @objects.each do |object|
          authorize object, :show?
        end
      else
        skip_authorization
      end

      respond_with @objects
    else
      raise 'The type is wrong'
    end
  end

end
