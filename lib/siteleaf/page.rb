module Siteleaf
  class Page < Entity

    attr_accessor :id, :title, :body, :slug, :url, :parent_id, :site_id, :published_at, :created_at, :updated_at, :meta
    protected :id=, :created_at=, :updated_at=
    
    def create_endpoint
      "sites/#{self.site_id}/pages"
    end
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def posts
      result = Client.get "pages/#{self.id}/posts"
      result.map { |r| Post.new(r) } if result
    end
    
    def pages
      result = Client.get "pages/#{self.id}/pages"
      result.map { |r| self.new(r) } if result
    end
    
    def page
      Page.find(self.parent_id) if self.parent_id
    end
    
  end
end