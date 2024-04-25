
import 'package:cleane_architecture/features/books/presentation/widgets/search_delegate_widget.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              blurRadius: 9,
              color: Color.fromARGB(34, 0, 0, 0),
              offset: Offset(0, 5))
        ]),
        child: _buildTextFormField(context));
  }

  TextFormField _buildTextFormField(BuildContext context) {
    return TextFormField(
        onFieldSubmitted: (val) {
          showSearch(
              context: context,
              delegate: SearchDelegateImpl(),
              query: val.trim());
        },
        decoration: InputDecoration(
          
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: "Search Book",
            hintStyle: TextStyle(fontSize: 17, color: Colors.grey[500]),
            prefixIcon: const Icon(Icons.search)));
  }
}
