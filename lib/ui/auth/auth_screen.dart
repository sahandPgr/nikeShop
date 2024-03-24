import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/data/repo/auth_repository.dart';
import 'package:nike_shop/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(); //tes2121t@gmail.com
  final TextEditingController passwordController =
      TextEditingController(); //123456
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
      child: BlocProvider<AuthBloc>(
        create: (context) {
          final bloc = AuthBloc(authRepository);
          bloc.stream.forEach((state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
          });
          bloc.add(AuthStarted());
          return bloc;
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: themeData.colorScheme.secondary,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is! AuthSuccess;
                },
                builder: (context, state) {
                  final blocProvider = BlocProvider.of<AuthBloc>(context);

                  return Column(
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
                          state.isLogin
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
                          controller: usernameController,
                          style: TextStyle(
                              color: themeData.colorScheme.onSecondary),
                          decoration:
                              const InputDecoration(label: Text('ایمیل')),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        _PasswordField(
                          obscureText: state.obscureText,
                          themeData: themeData,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              blocProvider.add(AuthButtonClicked(
                                  usernameController.text,
                                  passwordController.text));
                            },
                            child: state is AuthLoading
                                ? const CircularProgressIndicator()
                                : Text(state.isLogin ? 'ورود' : 'ثبت نام',
                                    style: themeData.textTheme.labelLarge!
                                        .apply(fontSizeFactor: 1.2))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                state.isLogin
                                    ? 'حساب کاربری ندارید؟'
                                    : 'حساب کاربری دارید؟',
                                style: themeData.textTheme.bodyMedium!.apply(
                                    color: themeData.colorScheme.onSecondary)),
                            TextButton(
                                onPressed: () {
                                  blocProvider.add(AuthModeChangeIsClicked());
                                },
                                child: Text(
                                  state.isLogin ? 'ثبت نام' : 'ورود',
                                  style: themeData.textTheme.labelMedium!.apply(
                                      color: themeData.colorScheme.primary),
                                ))
                          ],
                        ),
                        if (state.isLogin)
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Text('فراموشی رمز عبور',
                                  style: themeData.textTheme.bodyMedium!.apply(
                                      color:
                                          themeData.colorScheme.onSecondary))),
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.themeData,
    required this.controller,
    required this.obscureText,
  });
  final bool obscureText;
  final ThemeData themeData;
  final TextEditingController controller;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  @override
  Widget build(BuildContext context) {
    final blocProvider = BlocProvider.of<AuthBloc>(context);
    return TextField(
      controller: widget.controller,
      style: TextStyle(color: widget.themeData.colorScheme.onSecondary),
      keyboardType: TextInputType.visiblePassword,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          label: const Text('پسورد'),
          suffixIcon: IconButton(
            onPressed: () {
              blocProvider.add(AuthPasswordHideClicked());
            },
            icon: Icon(
              widget.obscureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.themeData.colorScheme.onSecondary,
            ),
          )),
    );
  }
}
