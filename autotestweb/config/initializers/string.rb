class String
  def pure_html
    self.gsub(/<[^>]*>/, "")
  end
end
