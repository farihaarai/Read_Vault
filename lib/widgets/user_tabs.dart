import 'package:booklibraryflutter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserTabs extends StatelessWidget {
  UserTabs({super.key});
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: userController.users.map((u) {
          bool isActive = userController.currentUser.value?.name == u.name;

          final tabs = Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? const Color.fromARGB(255, 97, 111, 189)
                    : Colors.white,
                foregroundColor: isActive ? Colors.white : Colors.indigo,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () => userController.selectUser(u),
              child: Text(u.name),
            ),
          );

          return isMobile ? Expanded(child: tabs) : tabs;
        }).toList(),
      ),
    );
  }
}
