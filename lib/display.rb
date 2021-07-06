# frozen_string_literal: true

module Display
  def title(name)
    l = name.length
    puts " [+] #{name} "
    puts '-' * l * 2.9
    puts
  end

  def kernel_show(line, exp)
    print "  - #{line} (exp: #{exp})"
  end

  def result(res, ntab = 3)
    puts "\t" * ntab + "[ #{res} ]"
  end

  def display_fix_list(list)
    list.each { |l| puts "  - #{l}" } if list.length >= 2
  end

  def show_bad_mod(name)
    print "  - Checking if #{name} is not available"
  end
end
