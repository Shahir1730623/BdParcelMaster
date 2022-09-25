import 'package:excel/api/sheets/user_sheets_api.dart';
import 'package:excel/main.dart';
import 'package:excel/widget/user_form_widget.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widget/navigate_users_widget.dart';

class ModifySheetsPage extends StatefulWidget {
  const ModifySheetsPage({Key? key}) : super(key: key);

  @override
  State<ModifySheetsPage> createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  //User? user;

  List<User> users = [];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUsers();
  }

  Future getUsers() async {

    final users = await UserSheetsApi.getAll();

    //Fetching one single User
    //final user = await UserSheetsApi.getById(4);
    //print(user!.toJson());

    setState(() {
      this.users = users;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        children: [
          UserFormWidget(
              user: users.isEmpty ? null : users[index],
              //user: user, //For single User
              onSavedUser: (user) async {},
          ),
          const SizedBox(height: 16,),
          if(users.isNotEmpty) buildUserControls(),
        ],
      ),
    ),
  );

  Widget buildUserControls() => NavigateUsersWidget(
    text: '${index + 1}/${users.length} Users',
    onClickedNext: () {
      final nextIndex = index >= users.length - 1 ? 0 : index + 1;

      setState(() => index = nextIndex);
    },
    onClickedPrevious: () {
      final previousIndex = index <= 0 ? users.length - 1 : index - 1;

      setState(() => index = previousIndex);
    },
  );
}
