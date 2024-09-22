class ValueParser
  def self.extract_kilometers(text)
    match = text.match(/(\d{1,2}\.\d{3})/)
    match ? match[1].gsub('.', '').to_i : nil
  end

  def self.extract_months(text)
    match = text.match(/(\d+)\sMonate/)
    match ? match[1].to_i : nil
  end
end
