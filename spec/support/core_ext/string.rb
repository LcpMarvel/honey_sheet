class String
  def raw!
    self.squish!.gsub!(/[[:space:]]+/, '')

    self
  end
end
