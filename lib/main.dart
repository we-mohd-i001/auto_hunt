import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_config.dart';
import 'firebase_options.dart';
import 'vaahextendflutter/base/base_controller.dart';
import 'vaahextendflutter/helpers/constants.dart';
import 'vaahextendflutter/helpers/enums.dart';
import 'vaahextendflutter/services/api_self_signed.dart';
import 'vaahextendflutter/services/storage/network/storage.dart';
import 'vaahextendflutter/widgets/atoms/buttons.dart';
import 'views/data_table_view.dart';
import 'views/test_app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Directory appDocDirectory = await getApplicationDocumentsDirectory();
  // Future<void> initHive() async {
  //   Directory dir = appDocDirectory;
  //   await Directory('${dir.path}/dir').create(recursive: true).then((Directory directory) async {
  //     Hive.init(directory.path);
  //   });
  // }

  // await initHive();
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
  // final Storage storage = Storage.createLocal(name: 'UserData');
  // await storage.init();

  // runApp(MaterialApp(
  //   routes: {
  //     '/': (context) => const MyTestApp(),
  //   },
  // ));

  await baseController.init(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    app: const AppConfig(),
    errorApp: const ErrorAppConfig(),
  ); // Pass main app as argument in init method
}

class MyTestApp extends StatefulWidget {
  static const String routePath = '/test';
  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const MyTestApp(),
    );
  }

  const MyTestApp({super.key});

  @override
  State<MyTestApp> createState() => _MyTestAppState();
}

class _MyTestAppState extends State<MyTestApp> {
  final _controller = Get.put(TestAppController());

  void create() async {
    Get.to(const CreateEntryView(
      operation: Operation.create,
    ));

    // smartPrint('Creating entry...');
    // await NetworkStorage.create(
    //     collectionName: 'users-collection',
    //     key: 'dave',
    //     value: CustomUser(name: 'Dave', age: '23', email: 'xyz@email.com').toJson());
    // smartPrint('Entry created.');
  }

  void createMany() async {
    Get.to(const CreateEntryView(
      operation: Operation.create,
      isMany: true,
    ));
    // smartPrint('Creating multiple entries...');
    // await NetworkStorage.createMany(
    //   collectionName: 'users-collection',
    //   values: {
    //     'john': CustomUser(name: 'John', age: '23', email: 'xyz@email.com').toJson(),
    //     'sina': CustomUser(name: 'Sina', age: '23', email: 'xyz@email.com').toJson(),
    //     'sean': CustomUser(name: 'Sean', age: '23', email: 'xyz@email.com').toJson(),
    //     'jack': CustomUser(name: 'Jack', age: '23', email: 'xyz@email.com').toJson(),
    //     'lisa': CustomUser(name: 'Lisa', age: '23', email: 'xyz@email.com').toJson(),
    //   },
    // );
    // _controller.hydrateList();
    // smartPrint('Multiple entries created.');
  }

  void read() async {
    Get.to(const CreateEntryView(
      operation: Operation.read,
    ));
    // final data = await NetworkStorage.read(
    //   collectionName: 'users-collection',
    //   key: 'dave',
    // );

    //smartPrint(data);
  }

  void readMany() async {
    Get.to(const CreateEntryView(
      operation: Operation.read,
      isMany: true,
    ));
    // smartPrint(
    //   await NetworkStorage.readMany(
    //     collectionName: 'users-collection',
    //     keys: ['dave', 'john', 'sina', 'sean'],
    //   ),
    // );
  }

  void readAll() async {
    smartPrint(await NetworkStorage.readAll(collectionName: 'users-collection'));
  }

  void update() async {
    Get.to(const CreateEntryView(
      operation: Operation.update,
    ));
    // smartPrint('Updating entry...');
    // await NetworkStorage.update(
    //   collectionName: 'users-collection',
    //   key: 'sean',
    //   value: CustomUser(name: 'Sean', age: '32', email: 'xyz@email.com').toJson(),
    // );
    // smartPrint('Entry updated.');
    // Get.find<TestAppController>().hydrateList();
  }

  void updateMany() async {
    Get.to(const CreateEntryView(
      operation: Operation.update,
      isMany: true,
    ));
    // smartPrint('Updating multiple entries...');
    // await NetworkStorage.updateMany(
    //   collectionName: 'users-collection',
    //   values: {
    //     'jack': CustomUser(name: 'Jack', age: '23', email: 'xyz@email.com').toJson(),
    //     'lisa': CustomUser(name: 'Lisa', age: '23', email: 'xyz@email.com').toJson(),
    //   },
    // );
    // smartPrint('Updated multiple entries.');
  }

  void createOrUpdate() async {
    smartPrint('Creating or updating entry...');
    NetworkStorage.createOrUpdate(
      collectionName: 'users-collection',
      key: 'lisa',
      value: {},
    );
    smartPrint('Created Or updated the entry.');
    Get.find<TestAppController>().hydrateList();
  }

  void createOrUpdateMany() async {
    smartPrint('Creating or updating multiple entries...');
    await NetworkStorage.createOrUpdateMany(
      collectionName: 'users-collection',
      values: {},
    );
    smartPrint('Created Or updated multiple entries.');
    Get.find<TestAppController>().hydrateList();
  }

  void delete() async {
    Get.to(const CreateEntryView(
      operation: Operation.delete,
    ));
    // smartPrint('Deleting entry...');
    // await NetworkStorage.delete(collectionName: 'users-collection', key: 'sean');
    // smartPrint('Entry Deleted.');
  }

  void deleteMany() async {
    Get.to(const CreateEntryView(
      operation: Operation.delete,
      isMany: true,
    ));
    // smartPrint('Deleting multiple entries...');
    // await NetworkStorage.deleteMany(
    //   collectionName: 'users-collection',
    //   keys: ['dave', 'sean', 'sina'],
    // );
    // smartPrint('Multiple entries deleted.');
  }

  void deleteAll() async {
    smartPrint('Deleting All entries...');
    await NetworkStorage.deleteAll(collectionName: 'users-collection');
    smartPrint('All entries deleted.');
    _controller.hydrateList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.hydrateList();
        },
        child: const Icon(Icons.refresh),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonElevated(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        create();
                      },
                      text: 'Create',
                    ),
                    ButtonElevated(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        createMany();
                      },
                      text: 'CreateMany',
                    ),
                  ],
                ),
                verticalMargin8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonElevated(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        read();
                      },
                      text: 'Read',
                    ),
                    ButtonElevated(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        readMany();
                      },
                      text: 'ReadMany',
                    ),
                    ButtonElevated(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        readAll();
                      },
                      text: 'ReadAll',
                    ),
                  ],
                ),
                verticalMargin8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonElevated(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        update();
                      },
                      text: 'Update',
                    ),
                    ButtonElevated(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        updateMany();
                      },
                      text: 'UpdateMany',
                    ),
                  ],
                ),
                verticalMargin8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonElevated(
                      backgroundColor: Colors.lime,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        createOrUpdate();
                      },
                      text: 'CreateOrUpdate',
                    ),
                    ButtonElevated(
                      backgroundColor: Colors.lime,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        createOrUpdateMany();
                      },
                      text: 'CreateOrUpdateMany',
                    ),
                  ],
                ),
                verticalMargin8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonElevated(
                      buttonType: ButtonType.danger,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        delete();
                      },
                      text: 'Delete',
                    ),
                    ButtonElevated(
                      buttonType: ButtonType.danger,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        deleteMany();
                      },
                      text: 'DeleteMany',
                    ),
                    ButtonElevated(
                      buttonType: ButtonType.danger,
                      foregroundColor: Colors.white,
                      onPressed: () async {
                        deleteAll();
                      },
                      text: 'Delete All',
                    ),
                  ],
                ),
                const DataTableView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void smartPrint(Object? s) {
  print('---> $s');
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

enum Operation { create, read, update, delete }
