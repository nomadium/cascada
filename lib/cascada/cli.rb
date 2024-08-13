module Cascada
  module CLI
    def self.run(argv)
      if argv.empty?
        puts "usage: cascada <torrent|magnet url>"
        exit 1
      end
      torrent = BEncode.load_file(argv[0])
      summary = torrent.reject { |k, _| k == "info" }
      npieces = torrent["info"]["pieces"].length
      info = torrent["info"].map do |k, v|
        [k, (k != "pieces") ? v : "#{v[0..8]}... (#{npieces} bytes)"]
      end
      summary["info"] = info.to_h
      pp summary
    end
  end
end
