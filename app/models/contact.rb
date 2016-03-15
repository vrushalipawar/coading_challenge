class Contact < ActiveRecord::Base
  @@letters = {"1" => ["1"],
             "2" => ["a", "b", "c", "2"],
             "3" => ["d", "e", "f", "3"],
             "4" => ["g", "h", "i", "4"],
             "5" => ["j", "k", "l", "5"],
             "6" => ["m", "n", "o", "6"],
             "7" => ["p", "q", "r", "s", "7"],
             "8" => ["t", "u", "v", "8"],
             "9" => ["w", "x", "y", "z", "9"]
           }

  scope :search_contact, ->(search_input, search_text) {where("CAST(number AS TEXT) like '%#{search_input}%' OR name ilike #{search_text}")}

  def self.get_search_text(num)
    keys = num.chars.map{|digit| @@letters[digit]}
    keys = keys.shift.product(*keys).map(&:join)
    return keys.join("%' OR name ilike '%")
  end
end
