import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/cors/widgets/failure_message_widget.dart';
import 'package:cleane_architecture/cors/widgets/loading_widget.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/presentation/pages/book_details.dart';
import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchDelegateImpl extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultSearch(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var booksProvider = Provider.of<BooksProvider>(context);
    //get books by query
    booksProvider.eitherFailureOrBooksBySearch(query);

    return _buildResultSearch(context);
  }

  //search result
  Widget _buildResultSearch(BuildContext context) {
    List<BookEntity>? _books =
        Provider.of<BooksProvider>(context).booksBySearch;
    Failure? _failure = Provider.of<BooksProvider>(context).failure;
    if (_books != null) {
      return _buildListView(_books);
    } else if (_failure != null) {
      return Center(
        child: FailureMessageWiget(message: _failure.getMessage),
      );
    } else {
      return const Center(child: LoadingWidget());
    }
  }

  //ListView Books
  ListView _buildListView(List<BookEntity> _books) {
    return ListView.builder(
      itemCount: _books.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading:
              ImageWidget(url: _books[index].imageUrl, width: 40, height: 50),
          title: Text("${_books[index].title}"),
          subtitle: Text("${_books[index].pageCount} pages"),
          trailing: Text(_books[index].publishedDate ?? "-- --"),
          onTap: () {
            Provider.of<BooksProvider>(context, listen: false)
                .eitherFailureOrBook(_books[index].id);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookDetails(),
                ));
          },
        );
      },
    );
  }
}
