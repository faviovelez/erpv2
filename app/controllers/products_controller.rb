class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
  end

  def edit
  end

  def create
    @product = Product.new
    create_gallery
    respond_to do |format|
      if @product.save(product_params)
        format.html { redirect_to @product, notice: 'El producto fue creado exitosamente.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      create_gallery
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'El producto fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to cosas_url, notice: 'EL produto fue eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

private

  def create_gallery
    params[:product][:gallery].each do |key, value|
      @product.gallery = Gallery.create(image: value)
    end
  end

  def product_params
    params.fetch(:product, {}).permit(gallery_attributes: [:image])
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
