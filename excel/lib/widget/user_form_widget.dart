import 'package:excel/widget/button_widget.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {

  final formKey = GlobalKey<FormState>();

  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late bool isBeginner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final name = widget.user == null ? '' : widget.user!.name;
    final email = widget.user == null ? '' : widget.user!.email;
    final isBeginner = widget.user == null ? true : widget.user!.isBeginner;

    controllerName = TextEditingController(text: name);
    controllerEmail = TextEditingController(text: email);
    this.isBeginner = isBeginner;

    //controllerName = TextEditingController();
    //controllerEmail = TextEditingController();
    //this.isBeginner = true;
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildName(),
        const SizedBox(height: 16,),
        buildEmail(),
        const SizedBox(height: 16,),
        buildFlutterBeginner(),
        const SizedBox(height: 16,),
        buildSubmit(),
      ],
    ),
  );

  Widget buildName() => TextFormField(
    controller: controllerName,
    decoration: InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && value.isEmpty ? 'Enter Name' : null,
  );

  Widget buildEmail() => TextFormField(
    controller: controllerEmail,
    decoration: InputDecoration(
      labelText: 'Email',
      border: OutlineInputBorder(),
    ),
    validator: (value) => value != null && !value.contains('@') ? 'Enter Email': null,
  );

  Widget buildFlutterBeginner() => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    controlAffinity: ListTileControlAffinity.leading,
    value: isBeginner,
    title: Text('Is Flutter Beginner?'),
    onChanged: (value) => setState(() => isBeginner = value),
  );

  Widget buildSubmit() => ButtonWidget(
      text: 'Save',
      onClicked: () {
        final form = formKey.currentState!;
        final isValid = form.validate();

        if(isValid) {
          final user = User(
            name: controllerName.text,
            email: controllerEmail.text,
            isBeginner: isBeginner,
          );
          widget.onSavedUser(user);
        }
      },
  );
}
