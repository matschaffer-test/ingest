require 'bundler/setup'

load 'tasks/otr-activerecord.rake'

begin
  require 'annotate'
  Annotate.set_defaults(
    position_in_class: :after,
    exclude_tests: true,
    exclude_fixtures: true,
    exclude_factories: true,
    exclude_serializers: true
  )
  Annotate.load_tasks
rescue LoadError
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

task :environment do
  require_relative 'application'
end

namespace :db do
  task environment: :environment
end

namespace :workers do
  task s3_raw: :environment do
    Workers::S3Raw.new(
      ENV.fetch('S3_RAW_INPUT_QUEUE_URL', 'https://sqs.us-west-2.amazonaws.com/985752656544/ingest-measurements-to-s3-raw-dev'),
      ENV.fetch('S3_RAW_OUTPUT_BUCKET_NAME', 'safecastdata-us-west-2'),
      ENV.fetch('S3_RAW_OBJECT_PREFIX', 'ingest/dev/s3raw')
    ).run
  end

  task elastic_cloud: :environment do
    Workers::ElasticCloud.new(
        ENV.fetch('ELASTIC_CLOUD_INPUT_QUEUE_URL', 'https://sqs.us-west-2.amazonaws.com/985752656544/ingest-measurements-to-elasticcloud-dev'),
        ENV.fetch('ELASTIC_CLOUD_OUTPUT_CLUSTER_URL')
    ).run
  end
end
