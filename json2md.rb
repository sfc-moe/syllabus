require 'erb'
require 'json'
require 'date'

template = ERB.new(File.read('./md.erb'), 0, "%<>")

Dir["./raw_data/*.json"].each do |path|
  @json = JSON.parse(File.read(path))
  @id = @json['id']
  @name = @json['name']
  @term = @json['term']['name']
  date = DateTime.parse(@json['created_at']).to_date.to_s
  @post_time = date
  @body = @json['syllabus_body']
  
  File.write("./site/_posts/#{date}-syllabus-#{@id}.html", template.result)
end
