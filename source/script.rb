require "json"

def main
  possible_files = [
    File.expand_path("~/Library/Application Support/com.tinyapp.TablePlus/Data/Connections.plist"),
    File.expand_path("~/Library/Application Support/com.tinyapp.TablePlus-setapp/Data/Connections.plist"),
  ]

  connections_file = possible_files.find { |filepath| File.file?(filepath) }

  if connections_file.nil?
    error_message = {
      title: "Could not fetch connections",
      valid: false,
    }
    puts JSON.dump({items: [error_message]})
    return
  end

  output = parse_plist(connections_file).map do |connection|
    id = connection.fetch("ID")
    name = connection.fetch("ConnectionName")
    db_name = connection.fetch("DatabaseName")
    env = connection.fetch("Enviroment")
    {
      uid: id,
      title: name,
      subtitle: "[#{env}] #{db_name}",
      match: "#{name} #{env} #{db_name}",
      arg: "tableplus://?id=#{id}"
    }
  end
  puts JSON.dump({items: output})
end

def parse_plist(filepath)
  r, w = IO.pipe
  spawn("plutil -convert json -o - -", in: filepath, out: w)
  w.close
  Process.wait
  JSON.parse(r.read)
end

main
