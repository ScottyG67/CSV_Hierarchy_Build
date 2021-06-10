require 'csv'
require 'pry'

imported_file = CSV.parse(File.read("data.csv"),headers: true, col_sep: ";")
imported_file.delete(nil)
imported_file["Parent"] = nil

def find_parent(row) 
    reversed_string = row[0].reverse
    index_of_char = reversed_string.index(".")
    if index_of_char
        parent = reversed_string.slice(index_of_char+1,reversed_string.length).reverse
        return parent
    else
        parent=reversed_string.slice(1,reversed_string.length).reverse
        return parent
    end

end

def build_hierarchy (table)
    table.each do |row|
        row["Parent"] = find_parent(row)
    end
    return table
end

def save_new_file(table)
    CSV.open("new_file.csv",'w') do |csv|
        table.each do |row|
          csv << row
        end
    end
end

new_table = build_hierarchy(imported_file)
save_new_file(new_table)

puts "Done"
