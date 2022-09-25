import 'package:excel/api/sheets/user_sheets_api.dart';
import 'package:excel/main.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widget/button_widget.dart';
import '../widget/user_form_widget.dart';

class CreateSheetsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      // child: ButtonWidget(
      //   text: 'Save',
      //   onClicked: () async {
      child: SingleChildScrollView(
        child: UserFormWidget(
          onSavedUser: (user) async {

            final id = await UserSheetsApi.getRowCount() + 1;
            final newUser = user.copy(id: id);

            await UserSheetsApi.insert([newUser.toJson()]);
            //insertUsers();

            // final user = User(
            //   id: 1,
            //   name: 'Paul',
            //   email: 'paul@gmail.com',
            //   isBeginner: true,
            // );
            // await UserSheetsApi.insert([user.toJson()]);



            // final user = {
            //   UserFields.id: 1,
            //   UserFields.name: 'Tanvir',
            //   UserFields.email: 'tanvir@outlook.com',
            //   UserFields.isBeginner: true,
            // };
            // await UserSheetsApi.insert([user]);
          },
        ),
      ),
    ),
  );

  Future insertUsers() async {

    final users = [
      User(id: 1, name: 'John', email: 'john@gmail.com', isBeginner: true)
    ];

    final jsonUsers = users.map((user) => user.toJson()).toList();

    await UserSheetsApi.insert(jsonUsers);
  }

}
