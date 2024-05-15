import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/firebase_options.dart';
import 'package:uptodo/uptodo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeAppLaunch();
  await initGetIt();

  runApp(const UptodoApp());
}

initializeAppLaunch() async {
  final FirebaseApp app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instanceFor(app: app);
  FirebaseFirestore.instanceFor(app: app);
  FirebaseStorage.instanceFor(app: app);
}
