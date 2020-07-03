class TableDrawer
  CELL_LENGTH = 20
  ROW_LENGTH = 63

  attr_reader :headers, :rows, :total, :discount

  def initialize(headers, rows, total, discount)
    @headers = headers
    @rows = rows
    @total = total
    @discount = discount
  end

  def call
    output = "\n"
    output << render_break
    output << render_row(headers)
    output << render_break

    rows.each do |row|
      output << render_row(row)
    end
    output << render_break
    output << render_row("Total price: #{total}", ROW_LENGTH - 1)
    output << render_row("Discount: #{discount}", ROW_LENGTH - 1)
    output << render_break
    output << "\n"
    print output
  end

  private

  def render_row(row, pad = CELL_LENGTH)
    result = []
    row = [row] unless row.is_a?(Array)
    row.each do |cell|
      result << "#{render_cell(cell, pad)}"
    end
    "| #{result.join('|')}|\n"
  end

  def render_break
    "|#{'-' * ROW_LENGTH}|\n"
  end

  def render_cell(value, pad = CELL_LENGTH)
    "#{value}#{pad(value.to_s.length, pad)}"
  end

  def pad(length, pad = CELL_LENGTH)
    ' ' * (pad - length)
  end
end
