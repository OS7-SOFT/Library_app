import 'package:cleane_architecture/features/books/presentation/pages/home_page.dart';
import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => BooksProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Library App",
          home: const Home(),
          theme: ThemeData(fontFamily: "OpenSans")),
    );
  }
}
