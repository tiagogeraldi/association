class DebtsController < ApplicationController
  before_action :authenticate_user!

  # GET /debts or /debts.json
  def index
    @debts = Debt.limit(100)
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # POST /debts or /debts.json
  def create
    @debt = Debt.new(debt_params)

    respond_to do |format|
      if @debt.save
        format.html { redirect_to debt_url(@debt), notice: "Débito criado." }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1 or /debts/1.json
  def destroy
    @debt = Debt.find(params[:id])
    @debt.destroy!

    respond_to do |format|
      format.html { redirect_to debts_url, notice: "Débito removido." }
      format.json { head :no_content }
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def debt_params
      params.require(:debt).permit(:person_id, :amount, :observation)
    end
end
