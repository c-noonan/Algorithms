require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
    hash = HashMap.new(10)
    string.chars.each do |char|
        if hash.include?(char)
            hash.set(char, hash.get(char) - 1)
        else
            hash.set(char, 1)
        end
    end
    found_one = false
    hash.each do |k, v|
        if v == 1 && found_one == true
            return false
        end
        found_one = true if v == 1
    end
    true
end