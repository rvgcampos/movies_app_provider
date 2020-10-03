import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/utils/app_routes.dart';

class SearchAppBar extends StatelessWidget {
  final Size size;
  final MovieProvider movieProvider;
  final TextEditingController searchController;

  SearchAppBar({this.size, this.movieProvider, this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 56,
            ),
            height: size.height * 0.2 - 20,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Bem-vindo ao APP!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                        movieProvider.search(text);
                        Navigator.of(context).pushNamed(AppRoutes.SEARCH_SCREEN, arguments: text);
                        searchController.text = '';
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
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      movieProvider.search(searchController.text);
                      Navigator.of(context).pushNamed(AppRoutes.SEARCH_SCREEN, arguments: searchController.text);
                      searchController.text = '';
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
