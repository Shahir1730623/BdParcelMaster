import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:users/google_sheets/user_sheets_api.dart';
import 'package:users/mainScreens/main_screen.dart';

import '../models/user.dart';
import '../widgets/buttons/icon_button.dart';
import '../widgets/buttons/icon_outline_button.dart';
import '../widgets/material_dialogs.dart';
import '../widgets/progress_dialog.dart';

class PickUpRequest extends StatefulWidget {
  const PickUpRequest({Key? key}) : super(key: key);

  @override
  State<PickUpRequest> createState() => _PickUpRequestState();
}

class _PickUpRequestState extends State<PickUpRequest> {

  List<User> users = [];

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();


  List<dynamic> countries = [];
  List<dynamic> weights = [];
  String? countryId;
  String? weightId;

  double _value = 0.0;
  String _country = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUsers();

    this.countries.add({"zone": 1, "country": "Afghanistan"});
    this.countries.add({"zone": 2, "country": "Albania"});
    this.countries.add({"zone": 3, "country": "Algeria"});
    this.countries.add({"zone": 4, "country": "American Samoa"});
    this.countries.add({"zone": 5, "country": "Andorra"});
    this.countries.add({"zone": 6, "country": "Angola"});
    this.countries.add({"zone": 7, "country": "Anguilla"});
    this.countries.add({"zone": 8, "country": "Antigua"});
    this.countries.add({"zone": 9, "country": "Argentina"});
    this.countries.add({"zone": 10, "country": "Armenia"});
    this.countries.add({"zone": 11, "country": "Aruba"});
    this.countries.add({"zone": 12, "country": "Australia"});
    this.countries.add({"zone": 13, "country": "Austria"});
    this.countries.add({"zone": 14, "country": "Azerbaijan"});
    this.countries.add({"zone": 15, "country": "Bahamas"});
    this.countries.add({"zone": 16, "country": "Bahrain"});
    this.countries.add({"zone": 17, "country": "Barbados"});
    this.countries.add({"zone": 18, "country": "Belarus"});
    this.countries.add({"zone": 19, "country": "Belgium"});
    this.countries.add({"zone": 20, "country": "Belize"});
    this.countries.add({"zone": 21, "country": "Benin"});
    this.countries.add({"zone": 22, "country": "Bermuda"});
    this.countries.add({"zone": 23, "country": "Bhutan"});
    this.countries.add({"zone": 24, "country": "Bolivia"});
    this.countries.add({"zone": 25, "country": "Bonaire"});
    this.countries.add({"zone": 26, "country": "Bosnia and Herzegovina"});
    this.countries.add({"zone": 27, "country": "Botswana"});
    this.countries.add({"zone": 28, "country": "Brazil"});
    this.countries.add({"zone": 29, "country": "Brunei"});
    this.countries.add({"zone": 30, "country": "Bulgaria"});
    this.countries.add({"zone": 31, "country": "Burkina Faso"});
    this.countries.add({"zone": 32, "country": "Burundi"});
    this.countries.add({"zone": 33, "country": "Cambodia"});
    this.countries.add({"zone": 34, "country": "Cameroon"});
    this.countries.add({"zone": 35, "country": "Canada"});
    this.countries.add({"zone": 36, "country": "Canary Islands"});
    this.countries.add({"zone": 37, "country": "Cape Verde"});
    this.countries.add({"zone": 38, "country": "Cayman Islands"});
    this.countries.add({"zone": 39, "country": "Central African Republic"});
    this.countries.add({"zone": 40, "country": "Chad"});
    this.countries.add({"zone": 41, "country": "Chile"});
    this.countries.add({"zone": 42, "country": "China, People's Republic"});
    this.countries.add({"zone": 43, "country": "Colombia"});
    this.countries.add({"zone": 44, "country": "Mariana Islands"});
    this.countries.add({"zone": 45, "country": "Comoros"});
    this.countries.add({"zone": 46, "country": "Congo"});
    this.countries.add({"zone": 47, "country": "Congo, The Democratic Republic"});
    this.countries.add({"zone": 48, "country": "Cook Islands"});
    this.countries.add({"zone": 49, "country": "Costa Rica"});
    this.countries.add({"zone": 50, "country": "Cote d'Ivoire"});
    this.countries.add({"zone": 51, "country": "Croatia"});
    this.countries.add({"zone": 52, "country": "Cuba"});
    this.countries.add({"zone": 53, "country": "Curacao"});
    this.countries.add({"zone": 54, "country": "Cyprus"});
    this.countries.add({"zone": 55, "country": "Czech Republic"});
    this.countries.add({"zone": 56, "country": "Denmark"});
    this.countries.add({"zone": 57, "country": "Djibouti"});
    this.countries.add({"zone": 58, "country": "Dominica"});
    this.countries.add({"zone": 59, "country": "Dominican Republic"});
    this.countries.add({"zone": 60, "country": "East Timor"});
    this.countries.add({"zone": 61, "country": "Ecuador"});
    this.countries.add({"zone": 62, "country": "Egypt"});
    this.countries.add({"zone": 63, "country": "El Salvador"});
    this.countries.add({"zone": 64, "country": "Eritrea"});
    this.countries.add({"zone": 65, "country": "Estonia"});
    this.countries.add({"zone": 66, "country": "Ethiopia"});
    this.countries.add({"zone": 67, "country": "Falkland Islands"});
    this.countries.add({"zone": 68, "country": "Faroe Islands"});
    this.countries.add({"zone": 69, "country": "Fiji"});
    this.countries.add({"zone": 70, "country": "Finland"});
    this.countries.add({"zone": 71, "country": "France"});
    this.countries.add({"zone": 72, "country": "French Guyana"});
    this.countries.add({"zone": 73, "country": "Gabon"});
    this.countries.add({"zone": 74, "country": "Gambia"});
    this.countries.add({"zone": 75, "country": "Georgia"});
    this.countries.add({"zone": 76, "country": "Germany"});
    this.countries.add({"zone": 77, "country": "Ghana"});
    this.countries.add({"zone": 78, "country": "Gibraltar"});
    this.countries.add({"zone": 79, "country": "Greece"});
    this.countries.add({"zone": 80, "country": "Greenland"});
    this.countries.add({"zone": 81, "country": "Grenada"});
    this.countries.add({"zone": 82, "country": "Guadeloupe"});
    this.countries.add({"zone": 83, "country": "Guam"});
    this.countries.add({"zone": 84, "country": "Guatemala"});
    this.countries.add({"zone": 85, "country": "Guernsey"});
    this.countries.add({"zone": 86, "country": "Guinea Republic"});
    this.countries.add({"zone": 87, "country": "Guinea-Bissau"});
    this.countries.add({"zone": 88, "country": "Guinea-Equatorial"});
    this.countries.add({"zone": 89, "country": "Guyana (British)"});
    this.countries.add({"zone": 90, "country": "Haiti"});
    this.countries.add({"zone": 91, "country": "Honduras"});
    this.countries.add({"zone": 92, "country": "Hong Kong"});
    this.countries.add({"zone": 93, "country": "Hungary"});
    this.countries.add({"zone": 94, "country": "Iceland"});
    this.countries.add({"zone": 95, "country": "India"});
    this.countries.add({"zone": 96, "country": "Indonesia"});
    this.countries.add({"zone": 97, "country": "Iran"});
    this.countries.add({"zone": 98, "country": "Iraq"});
    this.countries.add({"zone": 99, "country": "Ireland"});
    this.countries.add({"zone": 100, "country": "Israel"});
    this.countries.add({"zone": 101, "country": "Italy"});
    this.countries.add({"zone": 102, "country": "Ivory Coast"});
    this.countries.add({"zone": 103, "country": "Jamaica"});
    this.countries.add({"zone": 104, "country": "Japan"});
    this.countries.add({"zone": 105, "country": "Jersey"});
    this.countries.add({"zone": 106, "country": "Jordan"});
    this.countries.add({"zone": 107, "country": "Kazakhstan"});
    this.countries.add({"zone": 108, "country": "Kenya"});
    this.countries.add({"zone": 109, "country": "Kiribati"});
    this.countries.add({"zone": 110, "country": "Korea, D.P.R."});
    this.countries.add({"zone": 111, "country": "Korea, Republic"});
    this.countries.add({"zone": 112, "country": "KOSOVO"});
    this.countries.add({"zone": 113, "country": "Kuwait"});
    this.countries.add({"zone": 114, "country": "Kyrgyzstan"});
    this.countries.add({"zone": 115, "country": "Lao People's Democratic Republic"});
    this.countries.add({"zone": 116, "country": "Latvia"});
    this.countries.add({"zone": 117, "country": "Lebanon"});
    this.countries.add({"zone": 118, "country": "Lesotho"});
    this.countries.add({"zone": 119, "country": "Liberia"});
    this.countries.add({"zone": 120, "country": "Libya"});
    this.countries.add({"zone": 121, "country": "Liechtenstein"});
    this.countries.add({"zone": 122, "country": "Lithuania"});
    this.countries.add({"zone": 123, "country": "Luxembourg"});
    this.countries.add({"zone": 124, "country": "Macau"});
    this.countries.add({"zone": 125, "country": "Macedonia"});
    this.countries.add({"zone": 126, "country": "Madagascar"});
    this.countries.add({"zone": 127, "country": "Malawi"});
    this.countries.add({"zone": 128, "country": "Malaysia"});
    this.countries.add({"zone": 129, "country": "Maldives"});
    this.countries.add({"zone": 130, "country": "Mali"});
    this.countries.add({"zone": 131, "country": "Malta"});
    this.countries.add({"zone": 132, "country": "Marshall Islands"});
    this.countries.add({"zone": 133, "country": "Martinique"});
    this.countries.add({"zone": 134, "country": "Mauritania"});
    this.countries.add({"zone": 135, "country": "Mauritius"});
    this.countries.add({"zone": 136, "country": "Mayotte"});
    this.countries.add({"zone": 137, "country": "Mexico"});
    this.countries.add({"zone": 138, "country": "MICRONESIA"});
    this.countries.add({"zone": 139, "country": "Moldova"});
    this.countries.add({"zone": 140, "country": "Monaco"});
    this.countries.add({"zone": 141, "country": "Mongolia"});
    this.countries.add({"zone": 142, "country": "Montserrat"});
    this.countries.add({"zone": 143, "country": "Morocco"});
    this.countries.add({"zone": 144, "country": "Mozambique"});
    this.countries.add({"zone": 145, "country": "Myanmar"});
    this.countries.add({"zone": 146, "country": "Namibia"});
    this.countries.add({"zone": 147, "country": "Nauru"});
    this.countries.add({"zone": 148, "country": "Nepal"});
    this.countries.add({"zone": 149, "country": "NETHERLANDS ANTILLES"});
    this.countries.add({"zone": 150, "country": "Netherlands"});
    this.countries.add({"zone": 151, "country": "Nevis"});
    this.countries.add({"zone": 152, "country": "New Caledonia"});
    this.countries.add({"zone": 153, "country": "New Zealand"});
    this.countries.add({"zone": 154, "country": "Nicaragua"});
    this.countries.add({"zone": 155, "country": "Niger"});
    this.countries.add({"zone": 156, "country": "Nigeria"});
    this.countries.add({"zone": 157, "country": "Niue"});
    this.countries.add({"zone": 158, "country": "Norway"});
    this.countries.add({"zone": 159, "country": "North macedonia(mk)"});
    this.countries.add({"zone": 160, "country": "Oman"});
    this.countries.add({"zone": 161, "country": "Pakistan"});
    this.countries.add({"zone": 162, "country": "PALAU"});
    this.countries.add({"zone": 163, "country": "Panama"});
    this.countries.add({"zone": 164, "country": "Papua New Guinea"});
    this.countries.add({"zone": 165, "country": "Paraguay"});
    this.countries.add({"zone": 166, "country": "Peru"});
    this.countries.add({"zone": 167, "country": "Philippines"});
    this.countries.add({"zone": 168, "country": "Poland"});
    this.countries.add({"zone": 169, "country": "Portugal"});
    this.countries.add({"zone": 170, "country": "Puerto Rico"});
    this.countries.add({"zone": 171, "country": "Qatar"});
    this.countries.add({"zone": 172, "country": "Reunion, Island"});
    this.countries.add({"zone": 173, "country": "Romania"});
    this.countries.add({"zone": 174, "country": "Russian Federation"});
    this.countries.add({"zone": 175, "country": "Rwanda"});
    this.countries.add({"zone": 176, "country": "Saipan"});
    this.countries.add({"zone": 177, "country": "Samoa"});
    this.countries.add({"zone": 178, "country": "SAN MARINO"});
    this.countries.add({"zone": 179, "country": "Sao Tome & Principe"});
    this.countries.add({"zone": 180, "country": "Saudi Arabia"});
    this.countries.add({"zone": 181, "country": "Senegal"});
    this.countries.add({"zone": 182, "country": "Serbia & Montenegro"});
    this.countries.add({"zone": 183, "country": "Seychelles"});
    this.countries.add({"zone": 184, "country": "Sierra Leone"});
    this.countries.add({"zone": 185, "country": "Singapore"});
    this.countries.add({"zone": 186, "country": "Slovakia"});
    this.countries.add({"zone": 187, "country": "Slovenia"});
    this.countries.add({"zone": 188, "country": "Solomon Islands"});
    this.countries.add({"zone": 189, "country": "Somalia"});
    this.countries.add({"zone": 190, "country": "Somaliland"});
    this.countries.add({"zone": 191, "country": "South Africa"});
    this.countries.add({"zone": 192, "country": "Spain"});
    this.countries.add({"zone": 193, "country": "Sri Lanka"});
    this.countries.add({"zone": 194, "country": "St Helena"});
    this.countries.add({"zone": 195, "country": "St. Barthelemy"});
    this.countries.add({"zone": 196, "country": "St. Eustatius"});
    this.countries.add({"zone": 197, "country": "St. Kitts"});
    this.countries.add({"zone": 198, "country": "St. Lucia"});
    this.countries.add({"zone": 199, "country": "St. Maarten"});
    this.countries.add({"zone": 200, "country": "St. Vincent"});
    this.countries.add({"zone": 201, "country": "Sudan"});
    this.countries.add({"zone": 202, "country": "Suriname"});
    this.countries.add({"zone": 203, "country": "Swaziland"});
    this.countries.add({"zone": 204, "country": "Sweden"});
    this.countries.add({"zone": 205, "country": "Switzerland"});
    this.countries.add({"zone": 206, "country": "Syria"});
    this.countries.add({"zone": 207, "country": "Tahiti"});
    this.countries.add({"zone": 208, "country": "Taiwan"});
    this.countries.add({"zone": 209, "country": "Tajikistan"});
    this.countries.add({"zone": 210, "country": "Tanzania"});
    this.countries.add({"zone": 211, "country": "Thailand"});
    this.countries.add({"zone": 212, "country": "Togo"});
    this.countries.add({"zone": 213, "country": "Tonga"});
    this.countries.add({"zone": 214, "country": "Trinidad and Tobago"});
    this.countries.add({"zone": 215, "country": "Tunisia"});
    this.countries.add({"zone": 216, "country": "Turkey"});
    this.countries.add({"zone": 217, "country": "Turkmenistan"});
    this.countries.add({"zone": 218, "country": "Turks and Caicos Islands"});
    this.countries.add({"zone": 219, "country": "Tuvalu"});
    this.countries.add({"zone": 220, "country": "Uganda"});
    this.countries.add({"zone": 221, "country": "Ukraine"});
    this.countries.add({"zone": 222, "country": "U.A.E"});
    this.countries.add({"zone": 223, "country": "United Kingdom"});
    this.countries.add({"zone": 224, "country": "U.S.A"});
    this.countries.add({"zone": 225, "country": "Uruguay"});
    this.countries.add({"zone": 226, "country": "Uzbekistan"});
    this.countries.add({"zone": 227, "country": "Vanuatu"});
    this.countries.add({"zone": 228, "country": "Vatican city"});
    this.countries.add({"zone": 229, "country": "Venezuela"});
    this.countries.add({"zone": 230, "country": "Vietnam"});
    this.countries.add({"zone": 231, "country": "Virgin Islands (British)"});
    this.countries.add({"zone": 232, "country": "Virgin Islands (US)"});
    this.countries.add({"zone": 233, "country": "Yemen"});
    this.countries.add({"zone": 234, "country": "Zambia"});
    this.countries.add({"zone": 235, "country": "Zimbabwe"});



    this.weights.add({"id": 1, "weight": "1"});
    this.weights.add({"id": 2, "weight": "2"});
    this.weights.add({"id": 3, "weight": "3"});
    this.weights.add({"id": 4, "weight": "4"});
    this.weights.add({"id": 5, "weight": "5"});
    this.weights.add({"id": 6, "weight": "6"});
    this.weights.add({"id": 7, "weight": "7"});
    this.weights.add({"id": 8, "weight": "8"});
    this.weights.add({"id": 9, "weight": "9"});
    this.weights.add({"id": 10, "weight": "10"});
    this.weights.add({"id": 11, "weight": "11"});
    this.weights.add({"id": 12, "weight": "12"});
    this.weights.add({"id": 13, "weight": "13"});
    this.weights.add({"id": 14, "weight": "14"});
    this.weights.add({"id": 15, "weight": "15"});
    this.weights.add({"id": 16, "weight": "16"});
    this.weights.add({"id": 17, "weight": "17"});
    this.weights.add({"id": 18, "weight": "18"});
    this.weights.add({"id": 19, "weight": "19"});
    this.weights.add({"id": 20, "weight": "20"});
    this.weights.add({"id": 21, "weight": "21"});
    this.weights.add({"id": 22, "weight": "22"});
    this.weights.add({"id": 23, "weight": "23"});
    this.weights.add({"id": 24, "weight": "24"});
    this.weights.add({"id": 25, "weight": "25"});
    this.weights.add({"id": 26, "weight": "26"});
    this.weights.add({"id": 27, "weight": "27"});
    this.weights.add({"id": 28, "weight": "28"});
    this.weights.add({"id": 29, "weight": "29"});
    this.weights.add({"id": 30, "weight": "30"});
  }

  Future<void> getData() async {

    print(nameTextEditingController.text.trim());
    print(addressTextEditingController.text.trim());
    print(weightId);
    print(countryId);

    int weightId2 = int.parse(weightId!);
    int countryCode = int.parse(countryId!);
    final rate = await UserSheetsApi.getById2(weightId2);
    print(rate);
    final zone = await UserSheetsApi.getById3(countryCode);
    print(zone);

    var value = zone!.toJson()["Zone"];
    var country = zone.toJson()["Country"];
    var value2 = rate!.toJson()["Zone $value"];

    print(value2);

    print(country);

    setState(() {
      _value = value2;
      _country = country;
    });
  }

  Future getUsers() async {

    final users = await UserSheetsApi.getAll();
    print("11111111111");
    print(users);

    //Fetching one single User
    final user = await UserSheetsApi.getById(2);
    print("22222222222");
    print(user!.toJson());

    final user2 = await UserSheetsApi.getById2(1);
    print("33333333333");
    //print(user2!.toJson2());
    print(user2!.toJson()["Weight (Kg)"]);

    final users2 = await UserSheetsApi.getAll2();
    print("777777777777");
    //print(users2);
    for(var i = 0; i <= 29;i++){
      print(users2[i].id);
    }

    print("888888888888");
    print( (await UserSheetsApi.getAll2())[1].id);

    setState(() {
      this.users = users;
    });
  }

  validateForm(){
    if(nameTextEditingController == null){
      Fluttertoast.showToast(msg: "Enter Receiver name");
    }
    else if(addressTextEditingController == null){
      Fluttertoast.showToast(msg: "Enter Receiver address");
    }
    else if(_country == null){
      Fluttertoast.showToast(msg: "Select Country");
    }
    else if(weightId == null){
      Fluttertoast.showToast(msg: "Select Weight");
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen(
        receiverName: nameTextEditingController.text,
        receiverAddress: addressTextEditingController.text,
        //receiverCountry: countryId!,
        receiverCountry: _country,
        weight: weightId!,
        amount: _value.toString(),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xff0ce8f9),
                    Color(0xff45b7fe)
                  ])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 150,
                  width: 350,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff80f85f),
                        Color(0xff54ef29)
                      ]),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 3,
                            color: Colors.black12)
                      ],
                      borderRadius: BorderRadius.circular(200).copyWith(
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0))),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xff80f85f),
                          Color(0xff54ef29)
                        ]),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 3,
                              color: Colors.black12)
                        ],
                        borderRadius: BorderRadius.circular(200).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pickup Parcel",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                        Text(
                          ' Request',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff45b7fe),
                              shadows: [
                                Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                    blurRadius: 5)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
                  child: TextField(
                    controller: nameTextEditingController,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Receiver Name',
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)
                            ),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.white
                            )
                        )
                    ),
                  ),
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
                  child: TextField(
                    controller: addressTextEditingController,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Colors.white,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Receiver Address',
                        hintStyle:
                        TextStyle(color: Colors.white, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)
                            ),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30).copyWith(
                                bottomRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            borderSide: BorderSide(color: Colors.white
                            )
                        )
                    ),
                  ),
                ),

                FormHelper.dropDownWidget(
                  context,
                  "Select Country",
                  this.countryId,
                  this.countries,
                  (onChangedVal) {
                    this.countryId = onChangedVal;
                    print("Selected Country: $onChangedVal");

                    // this.states = this.statesMasters.where(
                    //       (stateItem) => stateItem["ParentId"].toString() ==
                    //       onChangedVal.toString(),
                    // ).toList();
                    // this.stateId = null;
                    setState(() {

                    });
                  },
                      (onValidateVal) {
                    if(onValidateVal == null) {
                      return 'Please Select Country';
                    }
                    return null;
                  },
                  //borderColor: Theme.of(context).primaryColor,
                  //borderFocusColor: Theme.of(context).primaryColor,
                  borderColor: Colors.white,
                  borderFocusColor: Colors.white,
                  borderRadius: 30,
                  optionValue: "zone",
                  optionLabel: "country",
                  hintColor: Colors.white,
                ),
                SizedBox(height: 10,),
                FormHelper.dropDownWidget(
                  context,
                  "Select Weight",
                  this.weightId,
                  this.weights,
                      (onChangedVal) {
                    this.weightId = onChangedVal;
                    print("Selected Weight: $onChangedVal");

                    // this.states = this.statesMasters.where(
                    //       (stateItem) => stateItem["ParentId"].toString() ==
                    //       onChangedVal.toString(),
                    // ).toList();
                    // this.stateId = null;
                    setState(() {

                    });
                  },
                      (onValidateVal) {
                    if(onValidateVal == null) {
                      return 'Please Select Weight';
                    }
                    return null;
                  },
                  borderColor: Colors.white,
                  borderFocusColor: Colors.white,
                  borderRadius: 30,
                  optionValue: "id",
                  optionLabel: "weight",
                ),

                SizedBox(height: 10,),

                // Padding(
                //   padding:
                //   EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                //   child: TextField(
                //     style: TextStyle(color: Colors.white, fontSize: 14.5),
                //     decoration: InputDecoration(
                //         prefixIconConstraints: BoxConstraints(minWidth: 45),
                //         prefixIcon: Icon(
                //           Icons.account_circle,
                //           color: Colors.white70,
                //           size: 22,
                //         ),
                //         border: InputBorder.none,
                //         hintText: 'Receiver Address',
                //         hintStyle:
                //         TextStyle(color: Colors.white60, fontSize: 14.5),
                //         enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30).copyWith(
                //                 bottomRight: Radius.circular(0),
                //                 topLeft: Radius.circular(0)),
                //             borderSide: BorderSide(color: Colors.white38)),
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30).copyWith(
                //                 bottomRight: Radius.circular(0),
                //                 topLeft: Radius.circular(0)),
                //             borderSide: BorderSide(color: Colors.white70))),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Padding(
                //       padding: EdgeInsets.only(right: 30),
                //       child: Text('Forgot Password?',
                //           style:
                //           TextStyle(color: Colors.white70, fontSize: 13)),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 40,
                // ),
                // Center(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       btn1(context),
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext c){
                          return ProgressDialog(message: "Calculating amount, Please wait...",);
                        }
                    );
                    await Future.delayed(Duration(seconds: 1)).then((value) => getData());
                    Navigator.pop(context);
                    showDialog(context: context,
                        builder: (context){
                          return Dialog(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              width: double.infinity,
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: new Text("Total Amount",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 23,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: new Text(
                                      '$_value',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(['Test', 'List']);
                                        },
                                        text: 'Cancel',
                                        iconData: Icons.cancel_outlined,
                                        textStyle: TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),

                                      const SizedBox(width: 25.0),

                                      IconsButton(
                                        onPressed: () {
                                          validateForm();
                                        },
                                        text: "Confirm",
                                        iconData: Icons.delete,
                                        color: Colors.green,
                                        textStyle: TextStyle(color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(30).copyWith(
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Color(0xff80f85f),
                          Color(0xff54ef29)
                        ])),
                    child: Text('Send Request',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget btn1(BuildContext context) {
  //   return MaterialButton(
  //     color: Colors.grey[300],
  //     minWidth: 300,
  //     onPressed: () => Dialogs.materialDialog(
  //         msg: 'Are you sure ? you can\'t undo this',
  //         title: "Delete",
  //         color: Colors.white,
  //         context: context,
  //         dialogWidth: kIsWeb ? 0.3 : null,
  //         onClose: (value) => print("returned value is '$value'"),
  //         actions: [
  //           IconsOutlineButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(['Test', 'List']);
  //             },
  //             text: 'Cancel',
  //             iconData: Icons.cancel_outlined,
  //             textStyle: TextStyle(color: Colors.grey),
  //             iconColor: Colors.grey,
  //           ),
  //           IconsButton(
  //             onPressed: () {},
  //             text: "Delete",
  //             iconData: Icons.delete,
  //             color: Colors.red,
  //             textStyle: TextStyle(color: Colors.white),
  //             iconColor: Colors.white,
  //           ),
  //         ]),
  //     child: Text("Show Material Dialog"),
  //   );
  // }
}