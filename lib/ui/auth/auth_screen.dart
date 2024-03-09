import 'package:flutter/material.dart';
import 'package:nike_shop/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Theme(
      data: themeData.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width - 18, 52)))),
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: themeData.colorScheme.primary,
                  width: 1,
                  style: BorderStyle.solid),
            ),
            labelStyle: TextStyle(color: themeData.colorScheme.onSecondary),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: themeData.colorScheme.onSecondary.withOpacity(0.5),
                  width: 1,
                  style: BorderStyle.solid),
            )),
      ),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/nike_logo.png',
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Text(
                  'خوش آمدید',
                  style: themeData.textTheme.headlineMedium!.apply(
                      color: themeData.colorScheme.onSecondary,
                      fontWeightDelta: 2),
                ),
                Text(
                  isLogin
                      ? 'اطلاعات حساب خود را وارد کنید'
                      : 'ایمیل و رمز عبور خود را تعیین کنید',
                  style: themeData.textTheme.bodyMedium!.apply(
                      color: themeData.colorScheme.onSecondary,
                      fontSizeFactor: 1.1),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  style: TextStyle(color: themeData.colorScheme.onSecondary),
                  decoration: const InputDecoration(label: Text('ایمیل')),
                ),
                const SizedBox(
                  height: 12,
                ),
                _PasswordField(themeData: themeData),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(isLogin ? 'ورود' : 'ثبت نام',
                        style: themeData.textTheme.labelLarge!
                            .apply(fontSizeFactor: 1.2))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                        style: themeData.textTheme.bodyMedium!
                            .apply(color: themeData.colorScheme.onSecondary)),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin ? 'ثبت نام' : 'ورود',
                          style: themeData.textTheme.labelMedium!
                              .apply(color: themeData.colorScheme.primary),
                        ))
                  ],
                ),
                if (isLogin)
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: Text('فراموشی رمز عبور',
                          style: themeData.textTheme.bodyMedium!.apply(
                              color: themeData.colorScheme.onSecondary))),
              ]),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: widget.themeData.colorScheme.onSecondary),
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
          label: const Text('پسورد'),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.themeData.colorScheme.onSecondary,
            ),
          )),
    );
  }
}
