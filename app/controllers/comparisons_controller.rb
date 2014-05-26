class ComparisonsController < ApplicationController
  respond_to :html

  def new
    @comparison_form = ComparisonForm.new
  end

  def create
    @comparison_form = ComparisonForm.new(comparison_params)
    flash[:notice] = 'Comparison successfully created.' if @comparison_form.save

    respond_with @comparison_form, location: items_url
  end

  private

  def comparison_params
    params.require(:comparison).permit(:winning_item_id)
  end
end
