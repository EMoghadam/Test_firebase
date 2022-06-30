import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: SafeArea(child: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String tokenName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    saveToken(tokenName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Text(
          tokenName,
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        tokenName = token!;
      });
    });
  }

  Future<void> saveToken(String token) async {
    print("========================");
    await FirebaseFirestore.instance
        .collection("UsersToken")
        .doc("UserName")
        .set({"token": token});
    print(">>>>>>>>>>>>>>>>>>>>>>>>>");
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late String token = "token";
//
//   Future<String> getToken() async {
//     String? fcmToken = await FirebaseMessaging.instance.getToken();
//     print(fcmToken);
//
//     FirebaseMessaging.instance.onTokenRefresh.listen((fToken) {
//       fcmToken = fcmToken;
//     }).onError((err) {
//       print("erorrrrrrrrrrrrrrrrrrrrrr");
//     });
//     return fcmToken ?? "===>>>>>>>>>>>>>";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             token,
//             style: TextStyle(fontSize: 30, color: Colors.black),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           token = await getToken();
//           await Future.delayed(Duration(milliseconds: 5000));
//           setState(() {});
//         },
//         child: Text("+"),
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////////////////////////

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SafeArea(
//           child: Scaffold(
//         appBar: AppBar(
//           title: const Text("FireBase"),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => FirebaseFirestore.instance
//               .collection("testing")
//               .add({"timestamp": Timestamp.fromDate(DateTime.now())}),
//         ),
//         body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('testing').snapshots(),
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshat) {
//             if (!snapshat.hasData) return const SizedBox.shrink();
//             return ListView.builder(
//                 itemCount: snapshat.data?.docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final docData = snapshat.data?.docs[index].data();
//
//                   var dateTime = (docData["timestamp"] as Timestamp).toDate();
//                   return ListTile(title: Text(dateTime.toString()));
//                 });
//           },
//         ),
//       )),
//     );
//   }
// }
