import 'package:flutter/material.dart';
import 'package:notes/core/theme/theme_data.dart';
import 'package:notes/core/theme/theme_provider.dart';
import 'package:notes/core/widgets/app_icon.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color _color = Theme.of(context).primaryColor;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: _color,
          ),
          child: const CustomPaint(
            painter: MyAppIcon(
              s: 100,
            ),
          ),
        ),
        Consumer<ThemeChanger>(builder: (context, themeChanger, child) {
          final isDarkTheme = themeChanger.getAppTheme == AppTheme.dark;
          return SwitchListTile(
            title: const Text('Dark Theme'),
            value: isDarkTheme,
            onChanged: (_) => _changeTheme(context, isDarkTheme),
          );
        }),
      ],
    );
  }

  void _changeTheme(BuildContext context, bool isDarkTheme) {
    Provider.of<ThemeChanger>(context, listen: false)
        .changeAppTheme(isDarkTheme: isDarkTheme);
  }
}
