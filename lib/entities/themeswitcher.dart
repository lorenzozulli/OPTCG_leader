import 'package:flutter/material.dart';
import 'package:optcgcounter_flutter/utils/themes/black_theme.dart';
import 'package:optcgcounter_flutter/utils/themes/blue_theme.dart';
import 'package:optcgcounter_flutter/utils/themes/green_theme.dart';
import 'package:optcgcounter_flutter/utils/themes/purple_theme.dart';
import 'package:optcgcounter_flutter/utils/themes/red_theme.dart';
import 'package:optcgcounter_flutter/utils/themes/yellow_theme.dart';

class ThemeSwitcher {
  final String color;

  const ThemeSwitcher({
    required this.color
  });

  ThemeData themeSwitcher(bool light, String color){
    if(light){
      Map<String, ThemeData> themeMap = {
        'red': RedTheme.light,
        'green': GreenTheme.light,
        'blue': BlueTheme.light,
        'purple': PurpleTheme.light,
        'black': BlackTheme.light,
        'yellow': YellowTheme.light
      };
      return themeMap[color]!;
    } else {
      Map<String, ThemeData> themeMap = {
        'red': RedTheme.dark,
        'green': GreenTheme.dark,
        'blue': BlueTheme.dark,
        'purple': PurpleTheme.dark,
        'black': BlackTheme.dark,
        'yellow': YellowTheme.dark
      };
      return themeMap[color]!;
    }
  }
}