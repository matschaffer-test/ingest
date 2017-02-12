console.log("Loading...");

var AWS = require("aws-sdk");
var pg = require("pg");

exports.handler = function (event, context) {
  console.log("Executing handler...");

  var kmsCiphertextBlob = "AQECAHhgIhnk/OBcCJf4MqZfZ7iHJgVwLFvtgjt1K9LI3pxoZQAAAG4wbAYJKoZIhvcNAQcGoF8wXQIBADBYBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDCd5PkbEuvXWyBUPagIBEIArS6M9oXbPFeXYS3fSzN2Qgdu2HKcAs1iSM+ZNuG4BfDIfNvKTBR3GVrwwXw==";
  var kms = new AWS.KMS({ region: "us-west-2" });

  kms.decrypt({ CiphertextBlob: new Buffer(kmsCiphertextBlob, "base64") }, function(err, data) {
    if (err) throw err;

    console.log("Decrypting...");

    var password = data.Plaintext.toString("ascii");
    var client = new pg.Client({
      user: "eitoball",
      password: password,
      database: "safecast",
      port: 5432,
      host: "safecastingest-prd-replica1.c5c18y253gxp.us-west-2.rds.amazonaws.com",
      ssl: true
    });

    console.log("Connected...");

    client.connect(function(err) {
      if (err) throw err;

      client.query("SELECT * FROM measurements ORDER BY created_at DESC LIMIT 1", function(err, result) {
        if (err) throw err;
        console.log(result.rows[0]);
        client.end(function(err) {
          if (err) throw err;
        });
      });
    });
  });
};
