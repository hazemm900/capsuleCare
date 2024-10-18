
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_layer/navigation/navigation_bar_cubit.dart';
import '../../../business_layer/navigation/navigation_bar_state.dart';
import '../../../core/base_widget/custom_appbar.dart';
import '../../widgets/myDrawer.dart';

class TestNavigationBottom extends StatelessWidget {
  const TestNavigationBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBarCubit, NavigationBarState>(
      builder: (context, state) {
        var cubit = NavigationBarCubit.get(context);
        return Scaffold(
          appBar: CutsomAppBar(
            title: cubit.getAppBarTitle(context)
          ),
          drawer: MyDrawer(),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: S.of(context).homeNavigation),
                // BottomNavigationBarItem(icon: Icon(Icons.person), label: S.of(context).profileNavigation),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_active),
                    label: S.of(context).notificationNavigation),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: S.of(context).archiveNavigation),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (int newIndex) {
                cubit.changeBottomNav(newIndex);
              }),
          body: cubit.body[cubit.currentIndex],
        );
      },
    );
  }
}
