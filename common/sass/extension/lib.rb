require 'sass'

module CustomFunctions

  #指定した長さのリストを作る 
  def list(start, max, separator = Sass::Script::String.new("space"))
     assert_type separator, :String
    unless %w[auto space comma].include?(separator.value)
      raise ArgumentError.new("Separator name must be space, comma, or auto")
    end
  
    Sass::Script::List.new(
      Array.new(max.to_i){|index| Sass::Script::Number.new(index + start.to_i)},
      separator.value.to_sym
    )
    
  end
  
  #指定した長さのリストを、ランダムな配置で生成する
  def random_list(start, max, separator = Sass::Script::String.new("space"))
    assert_type separator, :String
    unless %w[auto space comma].include?(separator.value)
      raise ArgumentError.new("Separator name must be space, comma, or auto")
    end
    
    Sass::Script::List.new(
      Array.new(max.to_i){|index| Sass::Script::Number.new(index + start.to_i)}.sort_by{rand},
      separator.value.to_sym
    )
  end
  
  #行と列の最大値を指定すると、マス目の位置に相当するx,yを生成して返す。
  # (5, 5) => 5行5列 = 25個の [x,y]
  def random_table_list(cols, rows)
    arr = [];
    
    #行
    1.upto(cols.to_i) { |i|
      #列
      1.upto(rows.to_i) { |j|
        arr << Sass::Script::List.new([Sass::Script::Number.new(i), Sass::Script::Number.new(j)], :space)
      }
    }
    
    Sass::Script::List.new(arr.sort_by{rand}, :comma)
    
  end
end

module Sass::Script::Functions
  include CustomFunctions
end
