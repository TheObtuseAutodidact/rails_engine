class InvoiceItem < ActiveRecord::Base
  def self.format_currency
    "#{unit_price.slice(0..-3)}.#{unit_price.slice(-2..-1)}"
  end
end
