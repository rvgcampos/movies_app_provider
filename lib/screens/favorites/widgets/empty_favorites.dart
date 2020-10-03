import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  Size size;
  EmptyFavorites(this.size);
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Center(
                  child: Text(
                    'Muito vazio por aqui... Que tal adicionar uns filmes como favoritos?!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
  }
}