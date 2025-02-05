import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'navigations_part.dart';

class NavigationRoute extends NavigationDestination {
  final String route;

  const NavigationRoute({
    required this.route,
    required super.label,
    super.enabled,
    required super.icon,
    super.key,
    super.selectedIcon,
    super.tooltip,
  });
}

enum Status { empty, loaded }

class NavigationState extends Equatable {
  final Map<String, NavigationRoute> navigations;
  final NavigationRoute? current;
  final Status status;
  const NavigationState({
    this.navigations = const {},
    this.current,
    this.status = Status.empty,
  });

  @override
  List<Object?> get props => [status, current];

  NavigationState copyWith({
    NavigationRoute? current,
  }) {
    return NavigationState(
      navigations: navigations,
      status: Status.loaded,
      current: current ?? this.current,
    );
  }
}

class BottomNavigatorBloc extends Cubit<NavigationState> {
  BottomNavigatorBloc() : super(const NavigationState());

  void loadNavigationRoutes(Map<String, NavigationRoute> navigations) {
    if (navigations.length < 2) {
      return;
    }
    emit(NavigationState(
        navigations: navigations,
        current: navigations.values.first,
        status: Status.loaded));
  }

  void navigateTo(NavigationRoute navigation) {
    if (state.status == Status.empty) return;
    emit(state.copyWith(current: navigation));
  }

  void _navigate(String? route, String? label) {
    if (![route, label].every((e) => (e != null && e.isNotEmpty))) return;
    Modular.to.navigate(route!, arguments: label!);
  }

  @override
  void onChange(Change<NavigationState> change) {
    super.onChange(change);
    _navigate(change.nextState.current?.route, change.nextState.current?.label);
  }
}
