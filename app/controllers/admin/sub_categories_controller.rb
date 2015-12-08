class Admin::SubCategoriesController < ApplicationController
  before_action :set_admin_sub_category, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_category
  # GET /admin/sub_categories
  # GET /admin/sub_categories.json
  def index
    @admin_sub_categories = @admin_category.sub_categories.where(:parent_id=>nil)
  end

  # GET /admin/sub_categories/1
  # GET /admin/sub_categories/1.json
  def show
  end

  # GET /admin/sub_categories/new
  def new
    set_admin_sub_category if params.include? "id"
    @admin_category = Category.find(params["category_id"])
    @admin_sub_category = SubCategory.new(:parent_id=>params["id"])
  end

  # GET /admin/sub_categories/1/edit
  def edit
  end

  # POST /admin/sub_categories
  # POST /admin/sub_categories.json
  def create
    @admin_sub_category = SubCategory.new(admin_sub_category_params)

    respond_to do |format|
      if @admin_sub_category.save
        format.html { redirect_to admin_category_sub_categories_path(@admin_category), notice: 'Sub category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_sub_category }
      else
        format.html { render :new }
        format.json { render json: @admin_sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sub_categories/1
  # PATCH/PUT /admin/sub_categories/1.json
  def update
    respond_to do |format|
      if @admin_sub_category.update(admin_sub_category_params)
        format.html { redirect_to admin_category_sub_categories_path(@admin_category), notice: 'Sub category was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_sub_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sub_categories/1
  # DELETE /admin/sub_categories/1.json
  def destroy
    @admin_sub_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_sub_categories_url, notice: 'Sub category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_sub_category
      set_admin_category
      @admin_sub_category = SubCategory.find(params[:id])
    end

    def set_admin_category
      @admin_category = Category.find(params["category_id"])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_sub_category_params
      params.require(:sub_category).permit(:title,:category_id,:parent_id)
    end
end
