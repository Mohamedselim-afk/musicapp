import 'package:flutter/material.dart';
import 'package:musicapp/module/playlist_provider.dart';
import 'package:musicapp/themes/thems_provider.dart';
import 'package:provider/provider.dart';


import 'homepage.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> ThemeProvider()),
      ChangeNotifierProvider(create: (context)=> PlaylistProvider()),
    ],
      child: const MyApp(),
    ),
   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const homepage(),
      theme: Provider.of<ThemeProvider>(context).themData,
    );
  }
}

