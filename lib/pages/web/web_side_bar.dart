import 'package:arfriendv2/utils/app_responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_constanta.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({
    super.key,
    required this.route,
  });

  final String route;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return Drawer(
      elevation: 0,
      child: Material(
        color: const Color(0xFFDAF0FF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            children: List.generate(
              listSidebar.length,
              (index) => SizedBox(
                width: double.infinity,
                child: AnimatedContainer(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  duration: const Duration(
                    seconds: 1,
                  ),
                  decoration: BoxDecoration(
                    color: route.contains(listSidebar[index].route)
                        ? const Color(0xff004B7B)
                        : const Color(0xFFDAF0FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 50.0,
                  child: InkWell(
                    onHover: (val) {},
                    overlayColor:
                        MaterialStateProperty.all(Colors.grey.shade200),
                    onTap: () {
                      router.goNamed(listSidebar[index].route);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          listSidebar[index].image,
                          width: route.contains(listSidebar[index].route)
                              ? 18
                              : 15,
                          color: route.contains(listSidebar[index].route)
                              ? Colors.white
                              : Colors.black54,
                        ),
                        if (!AppResponsive.isTablet(context) &&
                            !AppResponsive.isMobileWeb(context))
                          const SizedBox(
                            width: 15,
                          ),
                        if (!AppResponsive.isTablet(context) &&
                            !AppResponsive.isMobileWeb(context))
                          Text(
                            listSidebar[index].title,
                            style: GoogleFonts.poppins(
                              fontSize: route.contains(listSidebar[index].route)
                                  ? 14.5
                                  : 13.5,
                              color: route.contains(listSidebar[index].route)
                                  ? Colors.white
                                  : Colors.black54,
                              letterSpacing: 1.2,
                              fontWeight:
                                  route.contains(listSidebar[index].route)
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
