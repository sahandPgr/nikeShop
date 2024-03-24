import 'package:flutter/material.dart';
import 'package:nike_shop/data/auth.dart';
import 'package:nike_shop/data/repo/auth_repository.dart';
import 'package:nike_shop/ui/auth/auth_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سبد خرید'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<AuthEntity?>(
        valueListenable: AuthRepository.authValueNotifier,
        builder: (context, authstate, child) {
          bool isAuthenticated = authstate != null &&
              authstate.accessToken.isNotEmpty &&
              authstate.refreshToken.isNotEmpty;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? 'خوش آمدید'
                    : 'لطفا وارد حساب کاربری شوید'),
                isAuthenticated
                    ? Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                authRepository.signOut();
                              },
                              child: const Text('خروج')),
                          ElevatedButton(
                              onPressed: () {
                                authRepository
                                    .refreshToken(authstate.refreshToken);
                              },
                              child: const Text('Refresh Token')),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        child: const Text('ورود')),
              ],
            ),
          );
        },
      ),
    );
  }
}
