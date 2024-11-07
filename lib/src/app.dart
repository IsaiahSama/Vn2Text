import 'package:flutter/material.dart';
import 'package:voice_note_to_text/src/transcribe.dart';
import 'package:go_router/go_router.dart';
import './home.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: '/transcribe',
      builder: (context, state) => const TranscriptionPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
