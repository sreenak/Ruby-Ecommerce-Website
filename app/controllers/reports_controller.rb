class Admin::ReportsController < AdminController
  def index
    @brocades = Brocade.page params[:brocade]
  end
end