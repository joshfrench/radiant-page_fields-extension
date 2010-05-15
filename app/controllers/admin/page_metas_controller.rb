class Admin::PageMetasController < Admin::ResourceController
  def create
    self.model.attributes = params[model_symbol]
    @controller_name = 'page'
    @template_name = 'edit'
    render :partial => "page_meta", :object => model,
      :locals => { :page_meta_counter => params[:page_meta_counter].to_i}
  end
end
