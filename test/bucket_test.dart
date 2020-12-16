import 'package:influxdb_client/api.dart';

import 'package:test/test.dart';

void main() {
  InfluxDBClient client;

  setUpAll(() {
    final token =
    String.fromEnvironment('INFLUXDB_API_TOKEN', defaultValue: 'my-token');
    final org = String.fromEnvironment('INFLUXDB_ORG', defaultValue: 'my-org');
    final url = String.fromEnvironment('INFLUXDB_URL',
        defaultValue: 'http://localhost:8086');

    client = InfluxDBClient(
        token: token,
        url: url,
        org: org,
        bucket: 'my-bucket',
        debugEnabled: true);
  });

  tearDownAll(() {
    client.close();
  });

  group('buckets', () {
    test('list', () {

    });
  });
}