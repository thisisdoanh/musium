import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musinum/src/util/app_color.dart';

class AppContainer extends GetView {
  final PreferredSizeWidget? appBar;
  final Function(bool)? onPopInvoked;
  final bool? canPop;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Widget? coverScreenWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;

  const AppContainer(
      {this.appBar,
      this.onPopInvoked,
      this.bottomNavigationBar,
      this.child,
      this.coverScreenWidget,
      this.resizeToAvoidBottomInset = false,
      this.floatingActionButton,
      this.canPop,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop ?? false,
      onPopInvoked: onPopInvoked,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              appBar: appBar,
              body: Container(
                decoration: const BoxDecoration(
                  color: AppColor.backgroundColor,
                ),
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    Expanded(
                      child: child ?? const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
