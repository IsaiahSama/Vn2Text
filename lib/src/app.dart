import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:voice_note_to_text/src/transcribe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_detector/platform_detector.dart' show isAndroidApp;
import './providers.dart';
import './home.dart';

final _router = GoRouter(
  initialLocation: '/transcribe',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
      routes: [
        GoRoute(
          path: '/transcribe',
          builder: (context, state) => const TranscriptionPage(),
        ),
      ],
    ),
  ],
);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    if (isAndroidApp()){
      setupInitState();
    }
  }

  void setupInitState() {
    _intentDataStreamSubscription =
        FlutterSharingIntent.instance.getMediaStream().listen(
      (List<SharedFile> value) {
        setState(
          () {
            ref.read(sharedFileProvider.notifier).state = value;
          },
        );
      },
    );

    FlutterSharingIntent.instance.getInitialSharing().then(
      (List<SharedFile> value) {
        setState(() {
          ref.read(sharedFileProvider.notifier).state = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }
}
