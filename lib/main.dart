import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app_config.dart';
import 'firebase_options.dart';
import 'vaahextendflutter/base/base_controller.dart';
import 'vaahextendflutter/services/api_self_signed.dart';
import 'vaahextendflutter/services/data_storage/network/helpers/filter.dart';
import 'vaahextendflutter/services/data_storage/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  final Storage storage = Storage.createLocal(name: 'UserData');
  await storage.init();

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

class _MyTestAppState extends State<MyTestApp> {
  final Storage storage = Storage.createLocal(name: 'UserData');

  String value = 'Data';
  String updatedData = 'Updated Data';
  String? storedData;

  late UserLucky user1;
  late UserLucky user2;
  UserLucky emptyUser = UserLucky(name: 'null', age: 'null');
  createUsingFirebase() async {
    user1 = UserLucky(name: 'Firebase Check', age: '12');
  }

  createUsingMap() async {
    Map<String, dynamic> map1 = <String, dynamic>{
      'key': 'value',
      'key2': 'value2',
      'key3': ['value1arr', 'value2arr'],
    };
    await storage.create(key: 'map1', value: json.encode(map1));
    String result = await storage.read(key: 'map1');
    final map2 = json.decode(result);

    print('~~~> ' '$map2');
  }

  updateAndGet() async {
    print(await storage.read());
    user1 = UserLucky(name: 'Dave List', age: '22');
    user2 = UserLucky(name: 'User 2', age: '56');
    print(await storage.read(key: [
      'john',
      'dave',
    ]));
    print(await storage.read(key: 'dave'));
  }

  getData() async {
    var storedData1 = await storage.read(key: 'dave') as String;
    user1 = UserLucky.fromJson(storedData1);
  }

  @override
  void initState() {
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
                    final users = [
                      UserLucky(name: 'List A', age: '2'),
                      UserLucky(name: 'List B', age: '2'),
                      UserLucky(name: 'List C', age: '2'),
                      UserLucky(name: 'List D', age: '2'),
                      UserLucky(name: 'List E', age: '2'),
                      UserLucky(name: 'List F', age: '2'),
                      UserLucky(name: 'List G', age: '2'),
                      UserLucky(name: 'List H', age: '2')
                    ];
                    final friends = Friends(userLucky: users);
                    // await updateAndGet();
                    // storage.create(
                    //   key: 'friends',
                    //   value: friends.toJson(),
                    // );

                    final storedData = await storage.read(key: 'friends');
                    print('~~~>{$storedData}');
                    // user = UserLucky.fromJson(storedData ?? '');
                    // setState(() {
                    //   value = '${user.name} ${user.age}';
                    // });
                  },
                  child: const Text('Create'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await createUsingMap();
                      // await getData();
                      // setState(() {
                      //   value = user1.name;
                      // });
                    },
                    child: const Text('Show')),
                ElevatedButton(
                  onPressed: () async {
                    await updateAndGet();
                    setState(() {
                      updatedData = '${user1.name} ${user1.age}';
                    });
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print(await storage.read());
                  },
                  child: const Text('Read All'),
                ),
              ],
            ),
            Column(
              children: [
                Text(value),
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
        (map['userLucky'] as List<int>).map<UserLucky>(
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
