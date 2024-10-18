
import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:capsule_care/core/localization/generated/l10n.dart';
import 'package:capsule_care/localProvider.dart';
import 'package:capsule_care/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // State variables to store switch values
  bool _isDarkMode = false;
  String _selectedLanguage = 'en'; // Default language

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load saved preferences (dark mode and language)
  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _selectedLanguage = prefs.getString('languageCode') ?? 'en';
    });
  }

  // Save preferences for dark mode and language
  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('languageCode', _selectedLanguage);
  }

  Widget buildUserNameDrawer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.settings),
          SizedBox(width: 8.w),
          Text(S.of(context).settings)
        ],
      ),
    );
  }

  Widget buildDarkModeDrawer() {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark;
    return Container(
      child: ListTile(
          leading: Icon(Icons.dark_mode_outlined),
          title: Text(
            S.of(context).darkMode,
            style: TextStyle(fontSize: 18.sp),
          ),
          trailing: Switch(
            value: isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(value);
            },
          )),
    );
  }

  Widget buildLanguageButtonDrawer() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.language),
        title: Text(
          S.of(context).language,
          style: TextStyle(fontSize: 18.sp),
        ),
        trailing: DropdownButton<String>(
          value: _selectedLanguage,
          items: [
            DropdownMenuItem(
              child: Text(S.of(context).english),
              value: 'en',
            ),
            DropdownMenuItem(
              child: Text(S.of(context).arabic),
              value: 'ar',
            ),
          ],
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
              Provider.of<LocaleProvider>(context, listen: false)
                  .setLocale(Locale(_selectedLanguage));
              _savePreferences(); // Save language preference
            });
          },
        ),
      ),
    );
  }

  Widget buildRatingButtonDrawer() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.rate_review),
        title: Text(
          S.of(context).rating,
          style: TextStyle(fontSize: 18.sp),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.star_half,
            color: Colors.yellow.shade700,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget buildLogOutButtonDrawer() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.logout_outlined),
        title: Text(
          S.of(context).logOut,
          style: TextStyle(fontSize: 18.sp),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.logout_outlined,
            color: MyColors.myOrange,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget buildSpaceInHeight() {
    return SizedBox(
      height: 16.h,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildUserNameDrawer(),
              buildSpaceInHeight(),
              buildDarkModeDrawer(),
              buildSpaceInHeight(),
              buildLanguageButtonDrawer(),
              buildSpaceInHeight(),
              buildRatingButtonDrawer(),
              buildSpaceInHeight(),
              buildLogOutButtonDrawer(),
            ],
          ),
        ),
      ),
    );
  }
}
