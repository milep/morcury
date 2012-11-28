module ApplicationHelper
  def localized_path(locale)
    opts = params.slice(:controller, :action, :slug)
    opts.delete(:slug) if opts[:slug] == "/"
    opts[:locale] = locale

    url_for(opts)
  end
end
