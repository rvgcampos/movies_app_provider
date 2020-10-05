import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies_app/models/Movie.dart';
import 'package:movies_app/screens/movies/widgets/grid_tile.dart';

void main() {
  testWidgets(
    'Verifica mudança no ícone de favoritos quando clicado',
    (WidgetTester tester) async {
      Movie movie = Movie();
      if (movie.isFavorite == false) {
        await tester.pumpWidget(MovieGridTile());

        final Finder iconFinder = find.byType(IconButton);
        expect(iconFinder, findsOneWidget);

        final Icon icon = tester.widget(iconFinder);

        expect(icon.icon, Icons.favorite_border);

        await tester.tap(iconFinder);

        await tester.pumpAndSettle();

        final Icon iconAfter = tester.widget(iconFinder);

        expect(iconAfter.icon, FlareActor);
      }
    },
  );
}
