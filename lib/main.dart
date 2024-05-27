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
  BaseController baseController = Get.put(BaseController());
  HttpOverrides.global = SelfSignedHttps();

  await baseController.init(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    app: const AppConfig(),
    errorApp: const ErrorAppConfig(),
  ); // Pass main app as argument in init method
}

class MyTestApp extends StatefulWidget {
  const MyTestApp({super.key});

  @override
  State<MyTestApp> createState() => _MyTestAppState();
}

class _MyTestAppState extends State<MyTestApp> {
  final Storage storage = Storage.createEncryptedLocal(name: 'local');

  late CustomUser user1;
  late CustomUser user2;
  CustomUser emptyUser = CustomUser(name: 'null', age: 'null');

  create() async {
    await storage.create(key: 'key34', value: '34');
    smartPrint('Saving entry.');
  }

  createAll() async {
    await storage.createAll(values: {
      'key2': 'Value2',
      'key3': 'Value3',
      'key4': 'Value4',
      'key5': 'Value5',
    });
    smartPrint('Saving multiple entries.');
  }

  read() async {
    smartPrint(await storage.read(key: 'key34'));
  }

  readAll() async {
    smartPrint(await storage.readAll());
  }

  delete() async {
    await storage.delete(key: 'key34');
    smartPrint('Deleting entry.');
  }

  deleteAll() async {
    await storage.deleteAll();
    smartPrint('Deleting multiple entries.');
  }

  @override
  void initState() {
    storage.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                create();
              },
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed: () async {
                createAll();
              },
              child: const Text('CreateAll'),
            ),
            ElevatedButton(
                onPressed: () async {
                  read();
                },
                child: const Text('Read')),
            ElevatedButton(
              onPressed: () async {
                readAll();
              },
              child: const Text('ReadAll'),
            ),
            ElevatedButton(
              onPressed: () async {
                delete();
              },
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () async {
                deleteAll();
              },
              child: const Text('Delete All'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomUser {
  String name;
  String age;
  CustomUser({
    required this.name,
    required this.age,
  });

  CustomUser copyWith({
    String? name,
    String? age,
  }) {
    return CustomUser(
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

  factory CustomUser.fromMap(Map<dynamic, dynamic> map) {
    return CustomUser(
      name: map['name'].toString(),
      age: map['age'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source) =>
      CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
