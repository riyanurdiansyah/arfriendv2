import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_bloc.dart';
import '../../utils/app_responsive.dart';
import '../../utils/app_text.dart';
import 'web_side_bar.dart';

class WebUserPage extends StatefulWidget {
  const WebUserPage({
    super.key,
    required this.route,
  });

  final String route;

  @override
  State<WebUserPage> createState() => _WebUserPageState();
}

class _WebUserPageState extends State<WebUserPage> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    _userBloc.add(UserInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userBloc,
      child: Scaffold(
        endDrawer: AppResponsive.isMobile(context)
            ? SideNavbar(route: widget.route)
            : null,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color(0xff004B7B),
          ),
          backgroundColor: const Color(0xFFDAF0FF),
          title: Row(
            children: [
              AppText.labelW600(
                "Kelola User",
                18,
                Colors.black,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
