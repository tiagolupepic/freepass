VCR.configure do |c|
  c.cassette_library_dir = File.join(__dir__, "fixtures/cassettes")
  c.hook_into :webmock
  c.ignore_hosts 'elasticsearch.dev.azk.io', '127.0.0.1'
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end
