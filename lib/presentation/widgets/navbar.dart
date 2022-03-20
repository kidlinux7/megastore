import 'package:flutter/material.dart';
import 'package:megastore/presentation/screens/cart_page.dart';
import 'package:megastore/presentation/screens/explore.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

int _selectPage = 0;
final _pageOptions = [
  Explore(),
  CartPage(),
];

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectPage,
        children: _pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectPage,
        onTap: (int index) {
          setState(() {
            _selectPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: '',
          ),
        ],
      ),
    );
  }
}

// class _NavbarState extends State<Navbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pageOptions[_selectPage],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         currentIndex: _selectPage,
//         onTap: (int index) {
//           setState(() {
//             _selectPage = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.shopping_bag),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
