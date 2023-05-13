import 'package:arfriendv2/utils/app_responsive.dart';
import 'package:arfriendv2/utils/app_text.dart';
import 'package:arfriendv2/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/login/login_bloc.dart';
import '../../utils/validators.dart';

class WebLoginPage extends StatefulWidget {
  const WebLoginPage({super.key});

  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    _loginBloc.add(LoginInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<LoginBloc>(
      create: (context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
                width: AppResponsive.isDesktop(context)
                    ? size.width / 4
                    : AppResponsive.isTablet(context)
                        ? size.width / 2
                        : size.width / 1.5,
                behavior: SnackBarBehavior.floating,
                content: AppText.labelW600(
                  state.errorMessage,
                  14,
                  Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }

          if (state is LoginSuccessState) {
            context.goNamed(RouteName.home);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height,
                child: Image.asset(
                  "assets/images/bg.webp",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.webp",
                      width: 300,
                    ),
                    SizedBox(
                      width: AppResponsive.isDesktop(context)
                          ? size.width / 4
                          : AppResponsive.isTablet(context)
                              ? size.width / 2
                              : size.width / 1.5,
                      child: TextFormField(
                        controller: _loginBloc.tcEmail,
                        validator: (val) => Validators.checkFieldPass(val!),
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: GoogleFonts.poppins(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                          hintText: "johndoe@gmail.com",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: AppResponsive.isDesktop(context)
                          ? size.width / 4
                          : AppResponsive.isTablet(context)
                              ? size.width / 2
                              : size.width / 1.5,
                      child: TextFormField(
                        onEditingComplete: () =>
                            _loginBloc.add(LoginOnPressEvent()),
                        controller: _loginBloc.tcPassword,
                        obscureText: true,
                        validator: (val) => Validators.checkFieldPass(val!),
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: GoogleFonts.poppins(),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                          hintText: "******",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 25),
                      width: AppResponsive.isDesktop(context)
                          ? size.width / 4
                          : AppResponsive.isTablet(context)
                              ? size.width / 2
                              : size.width / 1.5,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey.shade300,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                          AppText.labelW500(
                            "we are friend",
                            12,
                            const Color(0xFF004B7B).withOpacity(0.6),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Colors.grey.shade300,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const SpinKitThreeInOut(
                            color: Color(0xff004B7B),
                            size: 25.0,
                          );
                        }
                        return SizedBox(
                          width: AppResponsive.isDesktop(context)
                              ? size.width / 4
                              : AppResponsive.isTablet(context)
                                  ? size.width / 2
                                  : size.width / 1.5,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004B7B),
                            ),
                            onPressed: () =>
                                _loginBloc.add(LoginOnPressEvent()),
                            child: AppText.labelBold(
                              "MASUK",
                              14,
                              Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
