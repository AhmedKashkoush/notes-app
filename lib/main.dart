import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/Constants/app_colors.dart';
import 'package:notes_app/Logic/ViewModels/notes_view_model.dart';
import 'package:notes_app/Themes/themes.dart';
import 'package:notes_app/UI/Screens/home_screen.dart';
import 'package:notes_app/Utils/Helpers/db_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.db;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor:
            isDark ? AppColors.appBgDarkColor : AppColors.appBgColor);
    SystemChrome.setSystemUIOverlayStyle(style);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => NotesViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Notes App',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: AppThemes.themeMode,
        home: const HomeScreen(),
      ),
    );
  }
}
