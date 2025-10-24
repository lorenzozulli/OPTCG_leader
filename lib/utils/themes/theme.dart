import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemes {

  static const Map<String, FlexScheme> _schemeMap = {
    'red': FlexScheme.shadRed,
    'green': FlexScheme.shadGreen,
    'blue': FlexScheme.shadBlue,
    'purple': FlexScheme.shadViolet,
    'black': FlexScheme.shadNeutral,
    'yellow': FlexScheme.shadYellow,
  };

  static const List<String> picker = [
    'red',
    'green',
    'blue',
    'purple',
    'black',
    'yellow'
  ];


  static ThemeData light({required String schemeName}) {
    final FlexScheme scheme = _schemeMap[schemeName] ?? FlexScheme.shadNeutral;

    return FlexThemeData.light(
      scheme: scheme,
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );
  }

  static ThemeData dark({required String schemeName}) {
    final FlexScheme scheme = _schemeMap[schemeName] ?? FlexScheme.shadNeutral;

    return FlexThemeData.dark(
      scheme: scheme,
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );
  }
}