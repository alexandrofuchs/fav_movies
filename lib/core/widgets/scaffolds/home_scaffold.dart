import 'package:fav_movies/core/helpers/extensions/list_extension.dart';
import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/widgets/scaffolds/blocs/bottom_navigator_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeScaffold extends StatefulWidget {
  final AppBar? appBar;
  final Widget? appBarLeading;
  final bool showMessagesMenu;
  final PreferredSizeWidget? appBarBottom;
  final String? routeName;
  final bool drawerEnabled;
  final Widget body;
  final Color? backgroundColor;
  final Color navigationBarColor;
  final bool extendBodyBehindAppBar;
  final bool? canPop;
  final void Function(bool didPop, Object? result)? onPopInvokedWithResult;

  const HomeScaffold(
      {super.key,
      this.appBar,
      this.appBarBottom,
      this.appBarLeading,
      this.showMessagesMenu = false,
      this.routeName,
      this.drawerEnabled = true,
      required this.body,
      this.backgroundColor,
      this.canPop,
      this.onPopInvokedWithResult,
      this.navigationBarColor = AppColors.primaryColor,
      this.extendBodyBehindAppBar = false});

  @override
  State<StatefulWidget> createState() => HomeScaffoldState();
}

class HomeScaffoldState extends State<HomeScaffold>  {
  final bloc = Modular.get<BottomNavigatorBloc>();

  @override
  void initState() {
    navigateTo();
    super.initState();
  }

  void navigateTo() {
    final navigationRoute = bloc.state.navigations
      .values.firstWhereOrNull((e) => e.route == Modular.to.path);
    if(navigationRoute == null) return;
    Modular.get<BottomNavigatorBloc>().navigateTo(navigationRoute);
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop ?? !widget.drawerEnabled,
      onPopInvokedWithResult: widget.onPopInvokedWithResult,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
        body: widget.body,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        bottomNavigationBar: BlocBuilder<BottomNavigatorBloc, NavigationState>(
            bloc: Modular.get(),
            builder: (context, state) => switch (state.status) {
                  Status.empty => Container(
                      color: AppColors.primaryColor,
                    ),
                  Status.loaded => NavigationBar(
                      overlayColor: const WidgetStatePropertyAll(AppColors.orangeColor),
                      onDestinationSelected: (int index) {
                        Modular.get<BottomNavigatorBloc>().navigateTo(List.of(state.navigations.values)[index]);
                      },
                      selectedIndex: List.of(state.navigations.values).indexOf(state.current!),
                      destinations: List.of(state.navigations.values),
                    ),
                }),
      ),
    );
  }
}
