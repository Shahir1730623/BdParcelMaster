import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:users/mainScreens/main_screen.dart';
import 'package:users/mainScreens/pickup_screen.dart';
import 'package:users/mainScreens/profile_screen.dart';
import 'package:users/mainScreens/trips_history_screen.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {

  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;

    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/images/top_header.png')
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/bdparcelmaster-71a1b.appspot.com/o/users%2F${currentFirebaseUser!.uid}%2Fpro-pic.png?alt=media&token=02b982af-2abb-467a-9291-c0979fc7f445'
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userModelCurrentInfo!.name!,
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            Text(
                              userModelCurrentInfo!.email!,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: "Montserrat Regular"),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      primary: false,
                      crossAxisCount: 2,
                      children: <Widget>[
                        // ElevatedButton.icon(
                        //   icon: const Icon(
                        //     Icons.add_circle,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () {
                        //
                        //   },
                        //   label: Text(
                        //     "Schedule",
                        //     style: const TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.white),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Color.fromARGB(255, 3, 133, 194),
                        //     fixedSize: const Size(208, 43),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context, MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
                        //   },
                        //   child: Card(
                        //     shape:RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)
                        //     ),
                        //     elevation: 4,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: <Widget>[
                        //         // SvgPicture.network(
                        //         //   'https://image.flaticon.com/icons/svg/1904/1904565.svg',
                        //         //   height: 128,
                        //         // ),
                        //         // Image.network(
                        //         //   'https://www.flaticon.com/free-icon/order_1356594'
                        //         // ),
                        //         Image.asset(
                        //             'images/order.png',
                        //           width: 50,
                        //         ),
                        //         Text(
                        //           'Orders',
                        //           style: cardTextStyle,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // GestureDetector(
                        //   child: Card(
                        //     shape:RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)
                        //     ),
                        //     elevation: 4,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: <Widget>[
                        //         // SvgPicture.network(
                        //         //   'https://image.flaticon.com/icons/svg/1904/1904527.svg',
                        //         //   height: 128,
                        //         // ),
                        //         Image.asset(
                        //           'images/notification.png',
                        //           width: 80,
                        //         ),
                        //         Text(
                        //           'Notification',
                        //           style: cardTextStyle,
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (c) => ProfileScreen()));
                          },
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // SvgPicture.network(
                                //   'https://image.flaticon.com/icons/svg/1904/1904437.svg',
                                //   height: 128,
                                // ),
                                Image.asset(
                                    'images/profile.png',
                                  width: 80,
                                ),
                                Text(
                                  'Profile',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
                            Navigator.push(context, MaterialPageRoute(builder: (c) => PickUpRequest()));
                          },
                          child: Card(
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            elevation: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // SvgPicture.network(
                                //   'https://image.flaticon.com/icons/svg/1904/1904437.svg',
                                //   height: 128,
                                // ),
                                Image.asset(
                                  'images/map.png',
                                  width: 80,
                                ),
                                Text(
                                  'Send a pickup Request',
                                  style: cardTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
