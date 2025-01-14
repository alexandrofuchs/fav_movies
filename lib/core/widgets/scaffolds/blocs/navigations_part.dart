part of 'bottom_navigator_bloc.dart';

mixin NavigationRoutes {
  Map<String, NavigationRoute> getUserNavigations() => {
        'home': const NavigationRoute(
          route: '/home/',
          label: 'Início',
          icon: Icon(
            Icons.home,
            color: AppColors.secundaryColor,
            size: 35,
          ),
        ),
        'favorites': const NavigationRoute(
          route: '/favorites/',
          icon: Icon(
            Icons.favorite,
            color: AppColors.secundaryColor,
            size: 35,
          ),
          label: 'Favoritos',
        ),
        'watchlist': const NavigationRoute(
          route: '/watchlist/',
          icon: Icon(
            Icons.tv,
            color: AppColors.secundaryColor,
            size: 35,
          ),
          label: 'Assistidos',
        ),
        'search': const NavigationRoute(
          route: '/search/',
          icon: Icon(
            Icons.search,
            color: AppColors.secundaryColor,
            size: 35,
          ),
          label: 'Pesquisar',
        ),
      };
}
