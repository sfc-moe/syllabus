require 'net/http'
require 'net/https'

def send_request(course_id)
  uri = URI("https://sol.sfc.keio.ac.jp/api/v1/courses/#{course_id}?include%5B%5D=syllabus_body&include%5B%5D=term")

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
  req =  Net::HTTP::Get.new(uri)
  # Add headers
  req.add_field "Authorization", "Bearer #{ENV['AUTH']}"
  # Add headers
  req.add_field "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"

  # Fetch Request
  res = http.request(req)
  return res.code, res.body
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end

for i in (1..1778) do
  code, body = send_request(i)

  File.write("raw_data/#{i}.json", body) if code == '200'
end
