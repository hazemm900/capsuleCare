import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/generated/l10n.dart';
import '../../presentation/screens/navigationScreens/historyScreen.dart';
import '../../presentation/screens/navigationScreens/homeScreen.dart';
import '../../presentation/screens/navigationScreens/notificationsScreen.dart';
import 'navigation_bar_state.dart';


class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarInitial());


  static NavigationBarCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> body = const [
    HomeScreen(),
    NotificationsScreen(),
    HistoryScreen(),
  ];


  void changeBottomNav(int newIndex){
    currentIndex = newIndex;
    emit(ChangeBottomNavSuccessState());

  }

  String getAppBarTitle(context){
   return currentIndex == 0
        ? S.of(context).appBarTitle
        : currentIndex == 1
        ? S.of(context).lowCapsuleNotifications
        : S.of(context).archiveNavigation ;
  }
}
