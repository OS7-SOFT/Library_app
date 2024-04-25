
import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/cors/widgets/failure_message_widget.dart';
import 'package:cleane_architecture/cors/widgets/loading_widget.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/book_list_widget.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/search_field_widget.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/toggle_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<BooksProvider>(context, listen: false).eitherFailureOrBooks('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _booksProvider = Provider.of<BooksProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color.fromARGB(255, 235, 237, 238),
        width: double.infinity,
        child: Column(
          children: [_buildBarContent(), _buildBodyContent(_booksProvider)],
        ),
      ),
    );
  }

  //Bar Content
  Container _buildBarContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 27),
      decoration: const BoxDecoration(
          color: Color.fromARGB(250, 17, 210, 174),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 5, color: Colors.grey, offset: Offset(0, 2))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          //Title
          const Text(
            "Library App",
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const Text("123 Books available",
              style: TextStyle(
                color: Colors.white,
              )),
          //Search Field
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SearchFieldWidget(),
          ),
          //Toggle buttons
          ToggleWidget()
        ],
      ),
    );
  }

  //Body contents
  Widget _buildBodyContent(BooksProvider _booksProvider) {
    List<BookEntity>? _books = _booksProvider.books;
    Failure? failure = _booksProvider.failure;

    if (_books != null) {
      return BookListWidget(books: _books);
    } else if (failure != null) {
      return Column(
        children: [
          FailureMessageWiget(message: failure.getMessage),
          TextButton(
            onPressed: () {
              _booksProvider.eitherFailureOrBooks("");
            },
            child: const Text("Try again"))
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 250),
        child: LoadingWidget(),
      );
    }
  }
}
