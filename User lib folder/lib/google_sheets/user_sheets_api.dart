
import 'package:gsheets/gsheets.dart';
import 'package:users/models/rate_chart.dart';

import '../models/user.dart';
import '../models/zone_list.dart';


class UserSheetsApi {
  static const _credentials = r'''
    {
  "type": "service_account",
  "project_id": "bdparcelmaster-71a1b",
  "private_key_id": "8f80474978d748abd02caf20605c61b38f95e128",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCgcvt7A4Ehlz1S\nu7GMySblqQq1hVUtrF3ztdW2wT0vFt6lth20lp/xm+hnQBC8yBsQJeYlXQeSnZBi\nJ2fwFg/Ib44NOIhl9dzKODB8iCn0RIp0ZFRZwl+bLNzYJrYiS/p5VLk0MrYd58go\nFhPyrn0+yR7nduSLiX/9/QT3skBBMbR9QRUPwNs76ex75xtf0L6bBMkFAJaWrjbR\nU8IiuSpNLw5frKdDuzuG+dsMSUyY8JpptRhZPfZet1TlDvrthViJKfSMQG79MfDX\nS2zkda9OFy0JM9pa0CmsXHBWAzYJksIqrgWa8l/jaQL3t4moJmCF/co15NXaa5QR\nI6Jw2zZJAgMBAAECggEABKnlmI6CRR3uhMuwWOQq5YTblb71pMbMZ05Qfd1Rit9v\nuCIvlwVuyjjK0UokgmblmdCkMc9UWO+2rT0HJsxusoKC6Zb2/fxevyD8Jc6BEQN3\nVnPpG2p3Lsfny7+aToEQsNCkiSQf34V9Gk8upBXsIt75LzypNCDFGovtcPQFLUU5\nrPpk908DtOpOX3EZ8Ilg1tpe2Jf3fkAxv6ycj0EgPEDc9d6edNzaAzrtFPKWeF/i\n+gZpHpg8DMgoRkmqlsGIHE5ggpVn7Y3T2XuiB3y8OxKytFBWYhW1ohhHMcsGSl5z\naeXund6l75QdjRCjt7bB5UDamx9mcLU03G5pYLEbJQKBgQDdx5vip6pnkSTKLIdC\npsaqlMjSEKTCZY27QksJyX+wDIpUKSHsMXWbuUnlHA52FHZ2tVQrdcBaOgarHVIz\nEaBcizkHEUEGWUrnKWvlLmqYC86ytNo7VwLE1Nbf8kY6bu1sX7i/X0W/Y/fNcp1f\na+z/85em0qqgEP+ZJw/Oa6PJ/QKBgQC5NMpUUuEWCnnK6aJXHp4AU+IIGA2O1x3z\npE8HuSoi3B5PQLvOXq/O8M4CvqasgOminQVxZUNPeN5CIPrOf8+AAZf8naAXfF50\nmZgOTtpbUbPfmeymYhMzv7xPo1praz3C9Z0f0w/GtlVRLgmKiJU3q92j5nran3Yj\nwAh0BOH5PQKBgQCksqCcQIE2qj4U+d50699rPFSqU3vXdY08fC23lfECLz3m5Cjx\n+4ToYUB0KVK/89BJtb1NDQQMvTzIhFzP2g4py6ZNDk4oxdTvN/6NUtwMD/CvG8lY\n+fPvclQkOQpYSJp+udM8Iydry3RyGOSvwTlelmqPk7Dsb9MwzCZb1+npjQKBgEDf\niO+4iDdcPAUjiUXS561dtJL5OeaK22b4auZdqbDEQampFx/Wcuad2suDVIagMTZQ\nohNyUP2JbPDk9HVYt6oy5LYL0IPpgHx/QI/idwH9wG/WTtqJCAjcZG3Q3l86FUwx\nFHSNTb1hKMliwtzPstTpUp2Sof3qVUt4fH2HKFBRAoGBAKdxFKAlBLwMC9Gu4b0H\nhgcYqK5yu0YjXw/MgfLlLeta3pJwTA/l9hOqArWHEd2GD3mPvEcRXz1TlzjzxP7e\nrCcHkilS4V0NuNRxQuWddCK30ZfeB1FpQ/b+Jm4nL+0wYUUqZFydQRV7je/admRT\nYQo+Z8XN+9KEcLn1yqqcit0f\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@bdparcelmaster-71a1b.iam.gserviceaccount.com",
  "client_id": "101643351048927544196",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40bdparcelmaster-71a1b.iam.gserviceaccount.com"
}
  ''';

  static final _spreadsheetId = '1nglUMjHcZIcW-cn_dHeB96cEmIQwJzO-Srr0WSXV1ZM';
  static final _gsheets = GSheets(_credentials);

  static Worksheet? _userSheet, _rateSheet, _zoneSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
      _rateSheet = await _getWorkSheet(spreadsheet, title: 'Rate_chart');
      _zoneSheet = await _getWorkSheet(spreadsheet, title: 'Zone_list');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);

      final firstRow2 = RateChart.getCharts();
      _rateSheet!.values.insertRow(1, firstRow2);

      final firstRow3 = ZoneList.getZones();
      _zoneSheet!.values.insertRow(1, firstRow3);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try{
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if(_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<User?> getById(int id) async {
    if(_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future<Rate?> getById2(int id) async {
    if(_rateSheet == null) return null;

    final json = await _rateSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Rate.fromJson(json);
  }

  static Future<Zone?> getById3(int id) async {
    if(_zoneSheet == null) return null;

    final json = await _zoneSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Zone.fromJson(json);
  }

  static Future<List<User>> getAll() async {
    if(_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    //print(users![0]["id"]);
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future<List<Rate>> getAll2() async {
    if(_rateSheet == null) return <Rate>[];

    final rate = await _rateSheet!.values.map.allRows();
    // print(users2);
    return rate == null ? <Rate>[] : rate.map(Rate.fromJson).toList();
  }



  static Future insert(List<Map<String, dynamic>> rowList) async {
    if(_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}