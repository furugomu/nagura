class DojoSweeper < ActionController::Caching::Sweeper
  observe Dojo # This sweeper is going to keep an eye on the Dojo model
 
  # If our sweeper detects that a Dojo was created call this
  def after_create(dojo)
    expire_cache_for(dojo)
  end
 
  # If our sweeper detects that a Dojo was updated call this
  def after_update(dojo)
    expire_cache_for(dojo)
  end
 
  # If our sweeper detects that a Dojo was deleted call this
  def after_destroy(dojo)
    expire_cache_for(dojo)
  end
 
  private
  def expire_cache_for(dojo)
    # Expire the index page now that we added a new dojo
    expire_page('/index')
  end
end
