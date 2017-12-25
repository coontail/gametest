class Hash
  
  def get_deep(*fields)
    fields.inject(self) {|acc,e| acc[e] if acc.is_a?(Hash)}
  end

end