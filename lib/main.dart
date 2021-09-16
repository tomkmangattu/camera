import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/core/theme/theme_data.dart';
import 'package:notes/core/theme/theme_provider.dart';
import 'package:notes/home/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final AppTheme appTheme = await _getTheme();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp(appTheme: appTheme));
}

class MyApp extends StatelessWidget {
  final AppTheme appTheme;
  const MyApp({
    required this.appTheme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(appTheme),
      builder: (BuildContext context, _) {
        return _buildWithTheme(context);
      },
    );
  }

  MaterialApp _buildWithTheme(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).getAppTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData[theme],
      home: const HomePage(),
    );
  }
}

Future<AppTheme> _getTheme() async {
  final box = await Hive.openBox('settings');

  final exists = box.containsKey('darkMode');
  if (!exists) {
    return _writeDarkTheme(box);
  } else {
    final isDarkMode = box.get('darkMode');
    if (isDarkMode == true) {
      return AppTheme.dark;
    } else {
      return AppTheme.light;
    }
  }
}

AppTheme _writeDarkTheme(Box box) {
  box.put('darkMode', true);
  return AppTheme.dark;
}
