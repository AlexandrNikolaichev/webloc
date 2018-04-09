#!/usr/bin/env ruby

$sites = [[ARGV[0],ARGV[1]]]
$s = "00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"

$sites.each do |site|
  url = site[0]
  name = site[1].gsub("/","_")
  File.open("#{name}.webloc",'w') do |f|
    f.write %(<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>URL</key>
	<string>http://#{url}</string>
</dict>
</plist>
)
  end
  `xattr -wx com.apple.FinderInfo "#{$s}" '#{name}.webloc'`
  `plutil -convert binary1 '#{name}.webloc'`
end
