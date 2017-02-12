# CSV Exporter

AWS Lambda function to export measurements to S3 in CSV format

## Usage

```
$ npm install
$ npm run build
$ terraform apply
$ aws lambda invoke --function-name "csv_exporter" outupu
```

## TODO

* Convert result in CSV
* Save CSV formatted result into S3
* Execute lambda function periodically
