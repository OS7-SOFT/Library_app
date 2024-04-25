import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailureMessageWiget extends StatelessWidget {
  final String message;

  const FailureMessageWiget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 250),
      child: Column(
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Check connection internet and try again",
              style: TextStyle(fontSize: 15),
            ),
          ),
         
        ],
      ),
    );
  }
}
