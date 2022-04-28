class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    raise ActiveRecord::RecordNotFound, 'Record not found.' if cannot? :update, Payment.find(params[:id])
  end

  # POST /payments or /payments.json
  def create
    if current_user.nil?
      redirect_to payments_path
      return
    end
    name = payment_params[:name]
    amount = payment_params[:amount]
    @payment = Payment.new(name:, amount:)
    @payment.user_id = current_user.id
    payment_params[:categories].each do |category|
      @payment.categories.push(Category.find(category)) unless category == ''
    end

    respond_to do |format|
      if @payment.save
        format.html { redirect_to category_url(@payment.categories[0]), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    raise ActiveRecord::RecordNotFound, 'Record not found.' if cannot? :update, Payment.find(params[:id])

    name = payment_params[:name]
    amount = payment_params[:amount]
    categories = payment_params[:categories]
    categories.delete_at(0)
    categories = categories.map { |category_id| Category.find(category_id) }
    respond_to do |format|
      if @payment.update(name:, amount:, categories:)
        format.html { redirect_to payment_url(@payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    raise ActiveRecord::RecordNotFound, 'Record not found.' if cannot? :update, Payment.find(params[:id])

    @payment.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:name, :amount, categories: [])
  end
end
