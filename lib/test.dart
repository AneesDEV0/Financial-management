import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("test")),
      body: const Column(
        children: [
          // SearchField(
          //   suggestions: const [],
          // )
        ],
      ),
    );
  }
}


































// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   runApp(MyMidApp());
// }

// class MyMidApp extends StatelessWidget {
//   const MyMidApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(useMaterial3: true),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     String name = "Hla Mousa";
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//     return Scaffold(
//       key: _scaffoldKey,
//       drawerScrimColor: Colors.white,
//       drawer: Drawer(
//         elevation: 25,
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.teal),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 40,
//                     child: Center(
//                       child: Text(
//                         name[0].toUpperCase(),
//                         style:
//                             TextStyle(fontSize: 30, color: Color(0xff949d9e)),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     "05938572",
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                   Text(
//                     name,
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "hla@gmail.com",
//                 style: TextStyle(color: Color(0xff7b7b7b)),
//               ),
//               leading: Icon(
//                 Icons.mail,
//                 color: Color(0xff888888),
//               ),
//             ),
//             Divider(),
//             ListTile(
//               title: Text(
//                 "Inbox",
//                 style: TextStyle(color: Color(0xff7b7b7b)),
//               ),
//               leading: Icon(
//                 Icons.inbox,
//                 color: Color(0xff888888),
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "Contact Us",
//                 style: TextStyle(color: Color(0xff7b7b7b)),
//               ),
//               leading: Icon(
//                 Icons.people,
//                 color: Color(0xff888888),
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "Offers",
//                 style: TextStyle(color: Color(0xff7b7b7b)),
//               ),
//               leading: Icon(
//                 Icons.local_offer,
//                 color: Color(0xff888888),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Container(
//         padding: EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: FloatingActionButton(
//             shape: CircleBorder(),
//             onPressed: () {},
//             backgroundColor: Colors.teal,
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//             )),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Colors.grey,
//           selectedItemColor: Colors.white,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: "Home ",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//             ),
//           ]),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             // open drawer
//             _scaffoldKey.currentState!.openDrawer();
//           },
//           icon: Icon(Icons.menu),
//           color: Colors.white,
//         ),
//         title: Text.rich(TextSpan(children: [
//           TextSpan(
//               text: "Al-Azhar ",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold)),
//           TextSpan(
//               text: "University ",
//               style: TextStyle(
//                   fontSize: 14,
//                   fontStyle: FontStyle.italic,
//                   color: Colors.white)),
//           TextSpan(
//               text: "in Gaza",
//               style: TextStyle(
//                 color: Colors.amber,
//                 letterSpacing: 4,
//                 fontSize: 12,
//               )),
//         ])),
//         backgroundColor: Colors.teal,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 150,
//                   // padding: EdgeInsets.all(8),
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                     color: Colors.grey,
//                     width: 1,
//                   )),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.amber,
//                           child: Text("Subject")),
//                       SizedBox(height: 4),
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.grey,
//                           child: Text("flutter")),
//                       SizedBox(height: 4),
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.grey,
//                           child: Text("java")),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 150,
//                   // padding: EdgeInsets.all(8),
//                   margin: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                     color: Colors.grey,
//                     width: 1,
//                   )),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.amber,
//                           child: Text("Subject Hour")),
//                       SizedBox(height: 4),
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.grey,
//                           child: Text("3")),
//                       SizedBox(height: 4),
//                       Container(
//                           padding: EdgeInsets.all(8),
//                           color: Colors.grey,
//                           child: Text("3")),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
