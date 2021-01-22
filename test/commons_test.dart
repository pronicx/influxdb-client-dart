import 'package:influxdb_client/api.dart';

/// enable HTTP tracing
bool debugEnabled=true;

/// global test properties
InfluxDBClient client;
String orgName;
Organization organization;

String generateBucketName() {
  var time = DateTime.now();
  return 'test_bucket_${time.millisecondsSinceEpoch}_IT';
}

Future<Bucket> createTestBucket() async {
  var bucketName = generateBucketName();
  var request = PostBucketRequest(
      orgID: organization.id, name: bucketName, retentionRules: null);
  return await client.getBucketsApi().postBuckets(request);
}

Future<void> deleteTestBucket(Bucket bucket) {
  return client.getBucketsApi().deleteBucketsID(bucket.id);
}

void setupClient() {
  final token =
      String.fromEnvironment('INFLUXDB_API_TOKEN', defaultValue: 'my-token');
  orgName = String.fromEnvironment('INFLUXDB_ORG', defaultValue: 'my-org');
  final url = String.fromEnvironment('INFLUXDB_URL',
      defaultValue: 'http://localhost:8086');

  client = InfluxDBClient(
      token: token,
      url: url,
      org: orgName,
      bucket: 'my-bucket',
      debugEnabled: debugEnabled);
}

Future<Organization> findMyOrg() async {
  var orgList = await client.getOrganizationsApi().getOrgs();
  return orgList.orgs.firstWhere((org) {
    print(org.name + ' ? '+ orgName);
    return org.name == orgName;});
}

void main () {

}
