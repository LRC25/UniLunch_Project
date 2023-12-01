import 'package:flutter/material.dart';
import 'package:unilunch/logic/Cliente.dart';
import 'package:unilunch/presentation/customers/widgets/customers_page_widget.dart';
import 'package:unilunch/presentation/customers/widgets/reservations_page_widget.dart';
import 'package:unilunch/presentation/customers/widgets/settings_page_widget.dart';
import 'package:unilunch/presentation/restaurants/widgets/restaurants_page_widget.dart';

class NavbarCustomerPage extends StatefulWidget {
  final Cliente cliente;

  const NavbarCustomerPage({super.key, required this.cliente});

  @override
  _NavbarCustomerPageState createState() => _NavbarCustomerPageState();
}

class _NavbarCustomerPageState extends State<NavbarCustomerPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            body: getSelectedWidget(
                index: index, cliente: widget.cliente
            ),
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
                destinations: [
                  NavigationDestination(
                      icon: Icon(Icons.fastfood_rounded),
                      label: 'Restaurantes'),
                  NavigationDestination(
                      icon: Icon(Icons.menu_book_rounded), label: 'Reservas'),
                  NavigationDestination(
                      icon: Icon(Icons.settings_rounded), label: 'Opciones'),
                ],
              ),
            )),
      );

  Widget getSelectedWidget(
      {required int index, required Cliente cliente}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = CustomersPageWidget(cliente: cliente);
        break;
      case 1:
        widget = CustomerReservationsPageWidget();
        break;
      case 2:
        widget = CustomerSettingsPageWidget();
        break;
      default:
        widget = CustomersPageWidget(cliente: cliente);
        break;
    }
    return widget;
  }
}
