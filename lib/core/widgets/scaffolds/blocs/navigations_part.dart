part of 'bottom_navigator_bloc.dart';

mixin NavigationRoutes {
  Map<String, NavigationRoute> getUserNavigations() => {
        'home': const NavigationRoute(
          route: '/home/',
          label: 'Início',
          icon: Icon(
            Icons.home,
          ),
        ),
        'favorites': const NavigationRoute(
          route: '/favorites/',
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favoritos',
        ),
        'watchlist': const NavigationRoute(
          route: '/watchlist/',
          icon: Icon(
            Icons.tv,
          ),
          label: 'Assistir',
        ),
        'search': const NavigationRoute(
          route: '/search/',
          icon: Icon(
            Icons.search,
          ),
          label: 'Pesquisar',
        ),
      };
}
