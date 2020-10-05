import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';

class SearchBar extends StatelessWidget {
  final MovieProvider movieProvider;
  final TextEditingController searchController;
  SearchBar(this.movieProvider, this.searchController);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Colors.blue.withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: searchController,
              onSubmitted: (text) {
                movieProvider.search(searchController.text);
              },
              decoration: InputDecoration(
                hintText: "Pesquisar...",
                hintStyle: TextStyle(
                  color: Colors.blue,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 1,
            onPressed: () {
              searchController.text = '';
            },
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.withOpacity(0.8),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            splashRadius: 1,
            onPressed: () {
              movieProvider.search(searchController.text);
            },
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
