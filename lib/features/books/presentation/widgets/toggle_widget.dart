import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  final List<bool> _isSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      color: Colors.white,
      child: ToggleButtons(
        children: [
          _buildToggle("Sports"),
          _buildToggle("Science"),
          _buildToggle("History"),
          _buildToggle("Cooking"),
        ],
        renderBorder: false,
        fillColor: Colors.transparent,
        selectedColor: const Color.fromARGB(250, 0, 199, 64),
        onPressed: (index) {
          getBooksBySubject(index);
          setState(() {
            for (var i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = (i == index);
            }
          });
        },
        isSelected: _isSelected,
      ),
    );
  }

  Container _buildToggle(String subject) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        subject,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  void getBooksBySubject(int index) {
    var booksProbider = Provider.of<BooksProvider>(context, listen: false);

    switch (index) {
      case 0:
        booksProbider.eitherFailureOrBooks("sports");
        break;
      case 1:
        booksProbider.eitherFailureOrBooks("Science");
        break;
      case 2:
        booksProbider.eitherFailureOrBooks("History");
        break;
      case 3:
        booksProbider.eitherFailureOrBooks("cooking");
        break;
    }
  }
}
