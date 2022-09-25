import 'package:excel/page/create_sheets_page.dart';
import 'package:excel/page/modify_sheets_page.dart';
import 'package:flutter/material.dart';

import 'api/sheets/user_sheets_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Google Sheets API';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    //home: CreateSheetsPage(),
    home: ModifySheetsPage(),
  );
}

