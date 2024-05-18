import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourtasks/helpers/commons.dart';

import 'app_config.dart';
import 'firebase_options.dart';
import 'vaahextendflutter/base/base_controller.dart';
import 'vaahextendflutter/services/api_self_signed.dart';
import 'vaahextendflutter/services/data_storage/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory appDocDirectory = await getApplicationDocumentsDirectory();
  Future<void> initHive() async {
    Directory dir = appDocDirectory;
    await Directory('${dir.path}/dir').create(recursive: true).then((Directory directory) async {
      Hive.init(directory.path);
    });
  }

  await initHive();
  // await Supabase.initialize(
  //   url: 'https://embgcnouywpgunriudxi.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVtYmdjbm91eXdwZ3Vucml1ZHhpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk4OTk3NDMsImV4cCI6MjAyNTQ3NTc0M30.kRmshqh_welj6_fv-CE5sIDv5h3PzwofGOJseqnGHwI',
  // );

  // final db = Database(useFirestore: false, collectionName: 'countries');
  // var iVlue = await db.getCollection(
  //     filter: Filter(column: 'name', operator: Operator.neq, value: 'South Korea'));
  // var iVlueq =
  //     await db.getDocument(filter: Filter(column: 'name', operator: Operator.eq, value: 'USA'));
  // //await db.setDocument({'id': 6, 'name': 'Jamaica'});
  // // await db.updateDocument({'name': 'Dummy Country'},
  // //     neq: Neq(column: 'name', value: 'Manhattan'));
  // print('~~~> $iVlue, Type: ${iVlue.runtimeType}');
  // print('~~~> $iVlueq, Type: ${iVlueq.runtimeType}');
  BaseController baseController = Get.put(BaseController());
  HttpOverrides.global = SelfSignedHttps();
  //await baseController.init(app: const MyTestApp(), errorApp: const MyTestApp());

  runApp(MaterialApp(
    routes: {
      '/': (context) => const MyTestApp(),
    },
  ));

  // await baseController.init(
  //   firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  //   app: const AppConfig(),
  //   errorApp: const ErrorAppConfig(),
  // ); // Pass main app as argument in init method
}

class MyTestApp extends StatefulWidget {
  const MyTestApp({super.key});

  @override
  State<MyTestApp> createState() => _MyTestAppState();
}

// class _MyTestAppState1 extends State<MyTestApp> {
//   @override
//   Widget build(BuildContext context) {
//   }
// }

class _MyTestAppState extends State<MyTestApp> {
  final Storage storage = Storage.createEncryptedLocal('vaultBox');

  String value = 'Data';
  String updatedData = 'Updated Data';
  String? storedData;

  late UserLucky user1;
  late UserLucky user2;
  UserLucky emptyUser = UserLucky(name: 'null', age: 'null');
  checkAssertion() async {
    // await storage.createAll(values: {
    //   'key2': 'Value2',
    //   'key3': 'Value3',
    //   'key4': 'Value4',
    //   'key5': 'Value5',
    // });
    print('>>> ${await storage.readAll()}');
  }

  create() async {
    await storage.create(key: 'key34', value: '34');
  }

  createAll() async {
    await storage.createAll(values: {
      'key2': 'Value2',
      'key3': 'Value3',
      'key4': 'Value4',
      'key5': 'Value5',
    });
  }

  read() async {
    smartPrint(await storage.read(key: 'key34'));
    final value1 = await storage.read(key: 'key1');
    setState(() {
      storedData = value1;
    });
  }

  readAll() async {
    smartPrint(await storage.readAll(keys: ['key1', 'key2', 'key3', 'key34']));
    final value1 = await storage.readAll(keys: ['key1', 'key2', 'key3', 'key34']);
    setState(() {
      storedData = '$value1';
    });
  }

  delete() async {
    await storage.delete(key: 'key34');
  }

  deleteAll() async {
    await storage.deleteAll(keys: ['key1', 'key2', 'key3']);
  }

  @override
  void initState() {
    storage.init();
    // _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    readAll();
                    //read();
                    //delete();
                    //deleteAll();
                    //create();
                    //createAll();
                  },
                  child: const Text('Create'),
                ),
                ElevatedButton(onPressed: () async {}, child: const Text('Show')),
                ElevatedButton(
                  onPressed: () async {
                    readAll();
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await storage.deleteAll();
                  },
                  child: const Text('Delete All'),
                ),
              ],
            ),
            Column(
              children: [
                Text('$storedData'),
                Text(updatedData),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Friends {
  final List<UserLucky> userLucky;
  Friends({
    required this.userLucky,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userLucky': userLucky.map((x) => x.toMap()).toList(),
    };
  }

  factory Friends.fromMap(Map<String, dynamic> map) {
    return Friends(
      userLucky: List<UserLucky>.from(
        (map['userLucky'] as List<dynamic>).map<UserLucky>(
          (x) => UserLucky.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Friends.fromJson(String source) =>
      Friends.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserLucky {
  String name;
  String age;
  UserLucky({
    required this.name,
    required this.age,
  });

  UserLucky copyWith({
    String? name,
    String? age,
  }) {
    return UserLucky(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return <dynamic, dynamic>{
      'name': name,
      'age': age,
    };
  }

  factory UserLucky.fromMap(Map<dynamic, dynamic> map) {
    return UserLucky(
      name: map['name'].toString(),
      age: map['age'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLucky.fromJson(String source) =>
      UserLucky.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, age: $age)';

  @override
  bool operator ==(covariant UserLucky other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
