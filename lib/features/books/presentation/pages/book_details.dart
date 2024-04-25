import 'package:cleane_architecture/features/books/presentation/widgets/book_info_widegt.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color.fromARGB(250, 235, 237, 238),
      body:BookInfoWidget() ,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.grey[600],
    );
  }

}


