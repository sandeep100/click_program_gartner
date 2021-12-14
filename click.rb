require 'date'

clicks = [ { ip:'22.22.22.22', timestamp:'3/11/2016 02:02:58', amount: 7.00 }, { ip:'11.11.11.11', timestamp:'3/11/2016 02:12:32', amount: 6.50 }, { ip:'11.11.11.11', timestamp:'3/11/2016 02:13:11', amount: 7.25 }, { ip:'44.44.44.44', timestamp:'3/11/2016 02:13:54', amount: 8.75 }, { ip:'22.22.22.22', timestamp:'3/11/2016 05:02:45', amount: 11.00 }, { ip:'44.44.44.44', timestamp:'3/11/2016 06:32:42', amount: 5.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 06:35:12', amount: 2.00 }, { ip:'11.11.11.11', timestamp:'3/11/2016 06:45:01', amount: 12.00 }, { ip:'11.11.11.11', timestamp:'3/11/2016 06:59:59', amount: 11.75 }, { ip:'22.22.22.22', timestamp:'3/11/2016 07:01:53', amount: 1.00 }, { ip:'11.11.11.11', timestamp:'3/11/2016 07:02:54', amount: 4.50 }, { ip:'33.33.33.33', timestamp:'3/11/2016 07:02:54', amount: 15.75 }, { ip:'66.66.66.66', timestamp:'3/11/2016 07:02:54', amount: 14.25 }, { ip:'22.22.22.22', timestamp:'3/11/2016 07:03:15', amount: 12.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 08:02:22', amount: 3.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 09:41:50', amount: 4.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 10:02:54', amount: 5.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 11:05:35', amount: 10.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 13:02:21', amount: 6.00 }, { ip:'55.55.55.55', timestamp:'3/11/2016 13:02:40', amount: 8.00 }, { ip:'44.44.44.44', timestamp:'3/11/2016 13:02:55', amount: 8.00 }, { ip:'55.55.55.55', timestamp:'3/11/2016 13:33:34', amount: 8.00 }, { ip:'55.55.55.55', timestamp:'3/11/2016 13:42:24', amount: 8.00 }, { ip:'55.55.55.55', timestamp:'3/11/2016 13:47:44', amount: 6.25 }, { ip:'55.55.55.55', timestamp:'3/11/2016 14:02:54', amount: 4.25 }, { ip:'55.55.55.55', timestamp:'3/11/2016 14:03:04', amount: 5.25 }, { ip:'55.55.55.55', timestamp:'3/11/2016 15:12:55', amount: 6.25 }, { ip:'22.22.22.22', timestamp:'3/11/2016 16:02:36', amount: 8.00 }, { ip:'55.55.55.55', timestamp:'3/11/2016 16:22:11', amount: 8.50 }, { ip:'55.55.55.55', timestamp:'3/11/2016 17:18:19', amount: 11.25 }, { ip:'55.55.55.55', timestamp:'3/11/2016 18:19:20', amount: 9.00 }, { ip:'22.22.22.22', timestamp:'3/11/2016 23:59:59', amount: 9.00 } ]


ch = Hash.new{0}
clicks.each{|l|
    # p l
    dtp = DateTime.parse l[:timestamp]
    # puts "#{l[:ip]} #{l[:timestamp]} dtp #{dtp} #{dtp.hour} #{dtp.minute}"
     ch[l[:ip]] +=1
     # p ch
}

# p ch

newClick = []

clicks.each{|l|
    newClick << l unless ch[l[:ip]] > 10
}

# p newClick

ra = Array.new(25){Array.new}
p ra

newClick.each{|l|
    dtp = DateTime.parse l[:timestamp]
    el  = dtp.hour + 1
    # p el
    # p l
    # p ['before', ra[el]]
    if ra[el].length == 0
        ra[el] = Hash.new{0}
        ra[el][l[:ip]] = l
        ra[el][:val] = l[:amount]
    else
        if l[:amount] > ra[el][:val]
            ra[el] = Hash.new{0}
            ra[el][l[:ip]] = l
            ra[el][:val] = l[:amount]
        else
            if l[:amount] == ra[el][:val]
                if ra[el][l[:ip]] == 0
                    ra[el][l[:ip]] = l
                else
                    # sleep 1
                    p 'same ip and value'
                    if (DateTime.parse ra[el][l[:ip]][:timestamp]) > dtp
                        p 'replace before'
                        p ra[el][l[:ip]]
                        ra[el][l[:ip]] = l 
                        p 'replace after'
                        p ra[el][l[:ip]]
                        sleep 1
                    end
                end
            end
        end
        # p ['after', ra[el]]
    end
}
ra.each_with_index{|l,i|
    # p [i,l]
}
puts "*******************************"
p ra
raa = ra.to_a

p raa

final = []

ra.each{|l|
    # puts "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    next if l.empty?
    p l
    la = l.to_a
    p la
    la.each{|l2|
        l2a = l2.to_a
        p 'a'
        p l2a
        p 'val' if l2a[0] == :val
        final << l2a[1] unless l2a[0] == :val
        p 'b'
    }
}

p final