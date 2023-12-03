import 'package:flutter/material.dart';
import 'package:unilunch/logic/Restaurante.dart';
import 'package:unilunch/presentation/restaurants/widgets/ratings_page_widget.dart';
import 'package:unilunch/presentation/restaurants/widgets/reservations_page_widget.dart';
import 'package:unilunch/presentation/restaurants/widgets/restaurants_page_widget.dart';
import 'package:unilunch/presentation/restaurants/widgets/settings_page_widget.dart';

class NavbarRestaurantPage extends StatefulWidget {
  final Restaurante restaurante;

  const NavbarRestaurantPage({super.key, required this.restaurante});

  @override
  _NavbarRestaurantPageState createState() => _NavbarRestaurantPageState();
}

class _NavbarRestaurantPageState extends State<NavbarRestaurantPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            body: getSelectedWidget(
                index: index, restaurante: widget.restaurante),
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                  indicatorColor: const Color.fromARGB(255, 198, 232, 218),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  labelTextStyle: MaterialStateProperty.all(const TextStyle(
                    color: Color.fromARGB(255, 6, 66, 68),
                  )),
                  iconTheme: MaterialStateProperty.all(const IconThemeData(
                      color: Color.fromARGB(255, 6, 66, 68)))),
              child: NavigationBar(
                height: 70,
                selectedIndex: index,
                onDestinationSelected: (index) =>
                    setState(() => this.index = index),
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.fastfood_rounded),
                      label: 'Menú del Día'),
                  NavigationDestination(
                      icon: Icon(Icons.menu_book_rounded),
                      label: 'Reservas'),
                  NavigationDestination(
                      icon: Icon(Icons.star_rounded),
                      label: 'Calificaciones'),
                  NavigationDestination(
                      icon: Icon(Icons.settings_rounded),
                      label: 'Opciones'),
                ],
              ),
            )),
      );

  Widget getSelectedWidget(
      {required int index, required Restaurante restaurante}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = RestaurantsPageWidget(restaurante: restaurante);
        break;
      case 1:
        widget = RestaurantReservationsPageWidget(restaurante: restaurante);
        break;
      case 2:
        widget = RestaurantRatingsPageWidget(restaurante: restaurante);
        break;
      case 3:
        widget = RestaurantSettingsPageWidget(restaurante: restaurante);
      default:
        widget = RestaurantsPageWidget(restaurante: restaurante);
        break;
    }
    return widget;
  }
}
