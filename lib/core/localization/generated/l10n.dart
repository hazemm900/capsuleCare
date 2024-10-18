// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To CapsuleCare `
  String get welcomeMessage {
    return Intl.message(
      'Welcome To CapsuleCare ',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `CapsuleCare `
  String get appBarTitle {
    return Intl.message(
      'CapsuleCare ',
      name: 'appBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up `
  String get signUp {
    return Intl.message(
      'Sign Up ',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Log In `
  String get logIn {
    return Intl.message(
      'Log In ',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Log Out `
  String get logOut {
    return Intl.message(
      'Log Out ',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Name `
  String get Name {
    return Intl.message(
      'Name ',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name `
  String get enterName {
    return Intl.message(
      'Enter Your Name ',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Phone `
  String get phone {
    return Intl.message(
      'Phone ',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Phone `
  String get enterPhone {
    return Intl.message(
      'Enter Your Phone ',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Gender `
  String get gender {
    return Intl.message(
      'Gender ',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `age `
  String get age {
    return Intl.message(
      'age ',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Verify Your Phone Number `
  String get verificationMessage {
    return Intl.message(
      'Verify Your Phone Number ',
      name: 'verificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Authentication Code `
  String get authenticationMessage {
    return Intl.message(
      'Please Enter Your Authentication Code ',
      name: 'authenticationMessage',
      desc: '',
      args: [],
    );
  }

  /// `User Name `
  String get userName {
    return Intl.message(
      'User Name ',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation!! `
  String get congratulation {
    return Intl.message(
      'Congratulation!! ',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone Have Been Verified Successfully `
  String get congratulationMessage {
    return Intl.message(
      'Your Phone Have Been Verified Successfully ',
      name: 'congratulationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Next `
  String get nextButton {
    return Intl.message(
      'Next ',
      name: 'nextButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue `
  String get continueButton {
    return Intl.message(
      'Continue ',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `No Medicine Entered Yet `
  String get noMedicineEntered {
    return Intl.message(
      'No Medicine Entered Yet ',
      name: 'noMedicineEntered',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name `
  String get medicineName {
    return Intl.message(
      'Medicine Name ',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Time `
  String get time {
    return Intl.message(
      'Time ',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Total Number Of Capsules `
  String get totalNumberOfCapsules {
    return Intl.message(
      'Total Number Of Capsules ',
      name: 'totalNumberOfCapsules',
      desc: '',
      args: [],
    );
  }

  /// `Remainder Of Capsules `
  String get remainderOfCapsules {
    return Intl.message(
      'Remainder Of Capsules ',
      name: 'remainderOfCapsules',
      desc: '',
      args: [],
    );
  }

  /// `How Many Times To Pick Capsules `
  String get howManyTimesToPick {
    return Intl.message(
      'How Many Times To Pick Capsules ',
      name: 'howManyTimesToPick',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Details `
  String get medicineDetails {
    return Intl.message(
      'Medicine Details ',
      name: 'medicineDetails',
      desc: '',
      args: [],
    );
  }

  /// `Schedule `
  String get schedule {
    return Intl.message(
      'Schedule ',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Capsule Calculator `
  String get capsuleCalculator {
    return Intl.message(
      'Capsule Calculator ',
      name: 'capsuleCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Total Capsules `
  String get total {
    return Intl.message(
      'Total Capsules ',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Picking Time `
  String get pickingTime {
    return Intl.message(
      'Picking Time ',
      name: 'pickingTime',
      desc: '',
      args: [],
    );
  }

  /// `Set Alarm `
  String get setAlarm {
    return Intl.message(
      'Set Alarm ',
      name: 'setAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Settings `
  String get settings {
    return Intl.message(
      'Settings ',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode `
  String get darkMode {
    return Intl.message(
      'Dark Mode ',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Language `
  String get language {
    return Intl.message(
      'Language ',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us `
  String get rating {
    return Intl.message(
      'Rate Us ',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Add New Medicine `
  String get addNewMedicine {
    return Intl.message(
      'Add New Medicine ',
      name: 'addNewMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Search `
  String get search {
    return Intl.message(
      'Search ',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Capsules Alarm `
  String get capsulesAlarm {
    return Intl.message(
      'Capsules Alarm ',
      name: 'capsulesAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Edit Medicine `
  String get editMedicine {
    return Intl.message(
      'Edit Medicine ',
      name: 'editMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Delete Medicine `
  String get deleteMedicine {
    return Intl.message(
      'Delete Medicine ',
      name: 'deleteMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Male `
  String get male {
    return Intl.message(
      'Male ',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female `
  String get female {
    return Intl.message(
      'Female ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Gender`
  String get genderSelection {
    return Intl.message(
      'Choose Your Gender',
      name: 'genderSelection',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `..........Don't Have An Acoount?..........`
  String get doNotHaveAccount {
    return Intl.message(
      '..........Don\'t Have An Acoount?..........',
      name: 'doNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Authentication Code`
  String get enterAuthCode {
    return Intl.message(
      'Please Enter Your Authentication Code',
      name: 'enterAuthCode',
      desc: '',
      args: [],
    );
  }

  /// `Home Page `
  String get homePageButton {
    return Intl.message(
      'Home Page ',
      name: 'homePageButton',
      desc: '',
      args: [],
    );
  }

  /// `Welcome `
  String get welcome {
    return Intl.message(
      'Welcome ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Profile Page`
  String get profile {
    return Intl.message(
      'Profile Page',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Enter Medicine Name `
  String get enterMedicineName {
    return Intl.message(
      'Enter Medicine Name ',
      name: 'enterMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Capsule Number `
  String get enterCapsuleNum {
    return Intl.message(
      'Enter Capsule Number ',
      name: 'enterCapsuleNum',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Time `
  String get alarmTime {
    return Intl.message(
      'Alarm Time ',
      name: 'alarmTime',
      desc: '',
      args: [],
    );
  }

  /// `Is Recurring `
  String get isRecurring {
    return Intl.message(
      'Is Recurring ',
      name: 'isRecurring',
      desc: '',
      args: [],
    );
  }

  /// `Add New Alarm ? `
  String get addNewAlarm {
    return Intl.message(
      'Add New Alarm ? ',
      name: 'addNewAlarm',
      desc: '',
      args: [],
    );
  }

  /// `Delete Medicine Failed `
  String get deleteMedicineFailed {
    return Intl.message(
      'Delete Medicine Failed ',
      name: 'deleteMedicineFailed',
      desc: '',
      args: [],
    );
  }

  /// `No Alarm Set Yet`
  String get noAlarmsSet {
    return Intl.message(
      'No Alarm Set Yet',
      name: 'noAlarmsSet',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Deleted`
  String get alarmDeleted {
    return Intl.message(
      'Alarm Deleted',
      name: 'alarmDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Delete Alarm Failed`
  String get deleteAlarmFailed {
    return Intl.message(
      'Delete Alarm Failed',
      name: 'deleteAlarmFailed',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Updated`
  String get alarmUpdated {
    return Intl.message(
      'Alarm Updated',
      name: 'alarmUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Alarm Added`
  String get alarmAdded {
    return Intl.message(
      'Alarm Added',
      name: 'alarmAdded',
      desc: '',
      args: [],
    );
  }

  /// `Update Alarm Failed`
  String get updateAlarmFailed {
    return Intl.message(
      'Update Alarm Failed',
      name: 'updateAlarmFailed',
      desc: '',
      args: [],
    );
  }

  /// `Add Alarm Failed`
  String get addAlarmFailed {
    return Intl.message(
      'Add Alarm Failed',
      name: 'addAlarmFailed',
      desc: '',
      args: [],
    );
  }

  /// `Fill All Fields`
  String get fillAllFields {
    return Intl.message(
      'Fill All Fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Ensure Valid Numbers`
  String get ensureValidNumbers {
    return Intl.message(
      'Ensure Valid Numbers',
      name: 'ensureValidNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Reminder`
  String get medicineReminder {
    return Intl.message(
      'Medicine Reminder',
      name: 'medicineReminder',
      desc: '',
      args: [],
    );
  }

  /// `Time To Take Medicine`
  String get timeToTakeMedicine {
    return Intl.message(
      'Time To Take Medicine',
      name: 'timeToTakeMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Alarm `
  String get repeatAlarm {
    return Intl.message(
      'Repeat Alarm ',
      name: 'repeatAlarm',
      desc: '',
      args: [],
    );
  }

  /// `English `
  String get english {
    return Intl.message(
      'English ',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic `
  String get arabic {
    return Intl.message(
      'Arabic ',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Take Medicine Now `
  String get takeMedicineNow {
    return Intl.message(
      'Take Medicine Now ',
      name: 'takeMedicineNow',
      desc: '',
      args: [],
    );
  }

  /// `Some Thing Went Wrong `
  String get somethingWentWrong {
    return Intl.message(
      'Some Thing Went Wrong ',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `update Failed `
  String get updateFailed {
    return Intl.message(
      'update Failed ',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Update Success `
  String get updateSuccess {
    return Intl.message(
      'Update Success ',
      name: 'updateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `All Fields Required`
  String get allFieldsRequired {
    return Intl.message(
      'All Fields Required',
      name: 'allFieldsRequired',
      desc: '',
      args: [],
    );
  }

  /// `No capsules left! `
  String get noCapsulesLeft {
    return Intl.message(
      'No capsules left! ',
      name: 'noCapsulesLeft',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeNavigation {
    return Intl.message(
      'Home',
      name: 'homeNavigation',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileNavigation {
    return Intl.message(
      'Profile',
      name: 'profileNavigation',
      desc: '',
      args: [],
    );
  }

  /// `archive`
  String get archiveNavigation {
    return Intl.message(
      'archive',
      name: 'archiveNavigation',
      desc: '',
      args: [],
    );
  }

  /// `Medicines Archive`
  String get medicinesArchive {
    return Intl.message(
      'Medicines Archive',
      name: 'medicinesArchive',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationNavigation {
    return Intl.message(
      'Notifications',
      name: 'notificationNavigation',
      desc: '',
      args: [],
    );
  }

  /// `Take Now`
  String get takeNow {
    return Intl.message(
      'Take Now',
      name: 'takeNow',
      desc: '',
      args: [],
    );
  }

  /// `Snooze`
  String get snooze {
    return Intl.message(
      'Snooze',
      name: 'snooze',
      desc: '',
      args: [],
    );
  }

  /// `Take Later`
  String get takeLater {
    return Intl.message(
      'Take Later',
      name: 'takeLater',
      desc: '',
      args: [],
    );
  }

  /// `Alarm At `
  String get alarmAt {
    return Intl.message(
      'Alarm At ',
      name: 'alarmAt',
      desc: '',
      args: [],
    );
  }

  /// `No Medicines Have Finished. `
  String get noMedicinesHaveFinished {
    return Intl.message(
      'No Medicines Have Finished. ',
      name: 'noMedicinesHaveFinished',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Some Medicines Have Finished.`
  String get someMedicinesHaveFinished {
    return Intl.message(
      'Some Medicines Have Finished.',
      name: 'someMedicinesHaveFinished',
      desc: '',
      args: [],
    );
  }

  /// `Renew Medicine`
  String get renewMedicine {
    return Intl.message(
      'Renew Medicine',
      name: 'renewMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Low Capsule Notifications`
  String get lowCapsuleNotifications {
    return Intl.message(
      'Low Capsule Notifications',
      name: 'lowCapsuleNotifications',
      desc: '',
      args: [],
    );
  }

  /// `All Medicines Have Enough Capsules.`
  String get allMedicinesHaveEnoughCapsules {
    return Intl.message(
      'All Medicines Have Enough Capsules.',
      name: 'allMedicinesHaveEnoughCapsules',
      desc: '',
      args: [],
    );
  }

  /// `Capsules Remaining:`
  String get capsulesRemaining {
    return Intl.message(
      'Capsules Remaining:',
      name: 'capsulesRemaining',
      desc: '',
      args: [],
    );
  }

  /// `No Medicine Added Yet.`
  String get noMedicinesAdded {
    return Intl.message(
      'No Medicine Added Yet.',
      name: 'noMedicinesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Deleted Successfully`
  String get medicineDeletedSuccessfully {
    return Intl.message(
      'Medicine Deleted Successfully',
      name: 'medicineDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Added Successfully`
  String get medicineAddedSuccessfully {
    return Intl.message(
      'Medicine Added Successfully',
      name: 'medicineAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Add Failed`
  String get medicineAddFailed {
    return Intl.message(
      'Medicine Add Failed',
      name: 'medicineAddFailed',
      desc: '',
      args: [],
    );
  }

  /// `Operation Failed`
  String get operationFailed {
    return Intl.message(
      'Operation Failed',
      name: 'operationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Search For Medicine`
  String get searchForMedicine {
    return Intl.message(
      'Search For Medicine',
      name: 'searchForMedicine',
      desc: '',
      args: [],
    );
  }

  /// `No Medicine Found !!`
  String get noMedicineFound {
    return Intl.message(
      'No Medicine Found !!',
      name: 'noMedicineFound',
      desc: '',
      args: [],
    );
  }

  /// `What Medicine Are You Searching For ?`
  String get whatMedicineAreYouSearchingFor {
    return Intl.message(
      'What Medicine Are You Searching For ?',
      name: 'whatMedicineAreYouSearchingFor',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
