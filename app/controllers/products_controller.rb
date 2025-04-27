class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  # Applying set_product to show/edit/update methods before any action
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    # Method to find product with id param
    def set_product
      @product = Product.find(params[:id])
    end

    # Program will only expect written params
    def product_params
      params.expect(product: [ :name, :description ])
    end
end
