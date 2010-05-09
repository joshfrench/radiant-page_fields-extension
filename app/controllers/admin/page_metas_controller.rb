class Admin::PageMetasController < Admin::ResourceController
  def create
    self.model.attributes = params[model_symbol]
    @controller_name = 'page'
    @template_name = 'edit'
    render :partial => "admin/pages/meta_row", :object => model,
      :locals => { :meta_row_counter => params[:meta_row_counter].to_i}
  end
end
