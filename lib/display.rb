module Display
  def title(name)
    l = name.length
    puts " [+] #{name} "
    puts "-" * l * 2.9
    puts
  end

  def kernel_show(line, exp)
    print "  - #{line} (exp: #{exp})"
  end

  def kernel_res(res, ntab = 3)
    puts "\t" * ntab + "[ #{@res} ]"
  end

  def kernel_correct_show(list)
    list.each { |l|
      puts "  - #{l}"
    }
  end
end
