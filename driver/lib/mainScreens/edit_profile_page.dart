import 'dart:io';


import 'package:driver/mainScreens/storage_service.dart';
import 'package:driver/tabPages/profile_tab.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';


import '../global/global.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final Storage storage = Storage();

  // Create a reference to a file from a Google Cloud Storage URI
  final gsReference = FirebaseStorage.instance.refFromURL("gs://bdparcelmaster-71a1b.appspot.com/users/${currentFirebaseUser!.uid}/pro-pic.png");


  final imageUrl = FirebaseStorage.instance.ref().child("users/${currentFirebaseUser!.uid}/pro-pic.png").getDownloadURL();

  @override
  Widget build(BuildContext context) => Scaffold(
    //appBar: buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: 'https://firebasestorage.googleapis.com/v0/b/bdparcelmaster-71a1b.appspot.com/o/users%2F${currentFirebaseUser!.uid}%2Fpro-pic.png?alt=media&token=02b982af-2abb-467a-9291-c0979fc7f445',
          isEdit: true,
          onClicked: () async {
            final results = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );

            if(results == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "No File selected",
                  ),
                ),
              );
              return null;
            }

            final path = results.files.single.path!;
            final fileName = results.files.single.name;

            print(path);
            print(fileName);

            storage.uploadFile(path, fileName).then((value) => print('Done'));
          },
        ),


        // FutureBuilder(
        //     future: storage.downloadURL('pro-pic.png'),
        //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        //       if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        //         return Container(
        //           width: 300,
        //           height: 250,
        //           child: Image.network(
        //             snapshot.data!,
        //             fit: BoxFit.cover,
        //           ),
        //         );
        //       }
        //       if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
        //         return CircularProgressIndicator();
        //       }
        //       return Container();
        //     }
        // ),

        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Full Name',
          text: driverModelCurrentInfo!.name!,
          onChanged: (name) {},
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          label: 'Email',
          text: driverModelCurrentInfo!.email!,
          onChanged: (email) {},
        ),
        const SizedBox(height: 24),
        // TextFieldWidget(
        //   label: 'About',
        //   text: "user.about",
        //   maxLines: 5,
        //   onChanged: (about) {},
        // ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => ProfileTabPage()));
            },
            child: Text("Save")
        )
      ],
    ),
  );
}
