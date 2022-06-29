import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text("FireBase"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => FirebaseFirestore.instance
              .collection("testing")
              .add({"timestamp": Timestamp.fromDate(DateTime.now())}),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('testing').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshat) {
            if (!snapshat.hasData) return const SizedBox.shrink();
            return ListView.builder(
                itemCount: snapshat.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var docData = snapshat.data?.docs[index].data();

                  var dateTime = (docData["timestamp"] as Timestamp).toDate();
                  return ListTile(title: Text(dateTime.toString()));
                });
          },
        ),
      )),
    );
  }
}
