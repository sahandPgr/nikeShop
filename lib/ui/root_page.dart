import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/ui/home/home.dart';

const int homeScreen = 0;
const int cartScreen = 1;
const int profileScreen = 2;

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int selectedIndexValue = homeScreen;
  final List<int> _history = [];

   final GlobalKey<NavigatorState> _homeKey = GlobalKey();
   final GlobalKey<NavigatorState> _cartKey = GlobalKey();
   final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeScreen: _homeKey,
    cartScreen: _cartKey,
    profileScreen: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState selectedScreenIndexState =
        map[selectedIndexValue]!.currentState!;
    if (selectedScreenIndexState.canPop()) {
      selectedScreenIndexState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedIndexValue = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: sort_child_properties_last
      child: Scaffold(
        body: IndexedStack(index: selectedIndexValue, children: [
          _navigator(_homeKey, homeScreen, const HomePage()),
          _navigator(
            _cartKey,
            cartScreen,
            const Center(
              child: Text('Cart'),
            ),
          ),
          _navigator(
              _profileKey,
              profileScreen,
              const Center(
                child: Text('Profile'),
              ))
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
          ],
          currentIndex: selectedIndexValue,
          onTap: (value) {
            setState(() {
              _history.remove(selectedIndexValue);
              _history.add(selectedIndexValue);
              selectedIndexValue = value;
            });
          },
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget screen) {
    return !(key.currentState == null && selectedIndexValue != index)
        ? Navigator(
          key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedIndexValue != index, child: screen)),
          )
        : Container();
  }
}
