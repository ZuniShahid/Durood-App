import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff0c6b59),
      surfaceTint: Color(0xff0c6b59),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa1f2db),
      onPrimaryContainer: Color(0xff002019),
      secondary: Color(0xff735c0c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe08a),
      onSecondaryContainer: Color(0xff241a00),
      tertiary: Color(0xff426277),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc6e7ff),
      onTertiaryContainer: Color(0xff001e2d),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fbf7),
      onBackground: Color(0xff171d1b),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff171d1b),
      surfaceVariant: Color(0xffdbe5e0),
      onSurfaceVariant: Color(0xff3f4945),
      outline: Color(0xff6f7975),
      outlineVariant: Color(0xffbfc9c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xff86d6bf),
      primaryFixed: Color(0xffa1f2db),
      onPrimaryFixed: Color(0xff002019),
      primaryFixedDim: Color(0xff86d6bf),
      onPrimaryFixedVariant: Color(0xff005142),
      secondaryFixed: Color(0xffffe08a),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574400),
      tertiaryFixed: Color(0xffc6e7ff),
      onTertiaryFixed: Color(0xff001e2d),
      tertiaryFixedDim: Color(0xffa9cbe3),
      onTertiaryFixedVariant: Color(0xff294a5e),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004c3e),
      surfaceTint: Color(0xff0c6b59),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2f826e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff534100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8b7223),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff25465a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff58798e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf7),
      onBackground: Color(0xff171d1b),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff171d1b),
      surfaceVariant: Color(0xffdbe5e0),
      onSurfaceVariant: Color(0xff3b4541),
      outline: Color(0xff57615d),
      outlineVariant: Color(0xff737d79),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffecf2ee),
      inversePrimary: Color(0xff86d6bf),
      primaryFixed: Color(0xff2f826e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff066856),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8b7223),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff705909),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff58798e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f6075),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff002820),
      surfaceTint: Color(0xff0c6b59),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004c3e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2c2100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff534100),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002537),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff25465a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf7),
      onBackground: Color(0xff171d1b),
      surface: Color(0xfff5fbf7),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe5e0),
      onSurfaceVariant: Color(0xff1d2623),
      outline: Color(0xff3b4541),
      outlineVariant: Color(0xff3b4541),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b322f),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffabfce4),
      primaryFixed: Color(0xff004c3e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003429),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff534100),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff382b00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff25465a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0a3043),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbd8),
      surfaceBright: Color(0xfff5fbf7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f1),
      surfaceContainer: Color(0xffe9efeb),
      surfaceContainerHigh: Color(0xffe3eae6),
      surfaceContainerHighest: Color(0xffdee4e0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff86d6bf),
      surfaceTint: Color(0xff86d6bf),
      onPrimary: Color(0xff00382d),
      primaryContainer: Color(0xff005142),
      onPrimaryContainer: Color(0xffa1f2db),
      secondary: Color(0xffe2c46d),
      onSecondary: Color(0xff3d2f00),
      secondaryContainer: Color(0xff574400),
      onSecondaryContainer: Color(0xffffe08a),
      tertiary: Color(0xffa9cbe3),
      onTertiary: Color(0xff0f3447),
      tertiaryContainer: Color(0xff294a5e),
      onTertiaryContainer: Color(0xffc6e7ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0e1513),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffdee4e0),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xffbfc9c4),
      outline: Color(0xff89938f),
      outlineVariant: Color(0xff3f4945),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff2b322f),
      inversePrimary: Color(0xff0c6b59),
      primaryFixed: Color(0xffa1f2db),
      onPrimaryFixed: Color(0xff002019),
      primaryFixedDim: Color(0xff86d6bf),
      onPrimaryFixedVariant: Color(0xff005142),
      secondaryFixed: Color(0xffffe08a),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574400),
      tertiaryFixed: Color(0xffc6e7ff),
      onTertiaryFixed: Color(0xff001e2d),
      tertiaryFixedDim: Color(0xffa9cbe3),
      onTertiaryFixedVariant: Color(0xff294a5e),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8adac3),
      surfaceTint: Color(0xff86d6bf),
      onPrimary: Color(0xff001b14),
      primaryContainer: Color(0xff4f9f8a),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe7c870),
      onSecondary: Color(0xff1d1500),
      secondaryContainer: Color(0xffa98e3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffaecfe7),
      onTertiary: Color(0xff001926),
      tertiaryContainer: Color(0xff7495ab),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1513),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0e1513),
      onSurface: Color(0xfff6fcf8),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xffc3cdc8),
      outline: Color(0xff9ba5a1),
      outlineVariant: Color(0xff7b8581),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff252b29),
      inversePrimary: Color(0xff005243),
      primaryFixed: Color(0xffa1f2db),
      onPrimaryFixed: Color(0xff00150f),
      primaryFixedDim: Color(0xff86d6bf),
      onPrimaryFixedVariant: Color(0xff003e32),
      secondaryFixed: Color(0xffffe08a),
      onSecondaryFixed: Color(0xff171000),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff443400),
      tertiaryFixed: Color(0xffc6e7ff),
      onTertiaryFixed: Color(0xff00131e),
      tertiaryFixedDim: Color(0xffa9cbe3),
      onTertiaryFixedVariant: Color(0xff173a4d),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffecfff7),
      surfaceTint: Color(0xff86d6bf),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8adac3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe7c870),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff8fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffaecfe7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0e1513),
      onBackground: Color(0xffdee4e0),
      surface: Color(0xff0e1513),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff3f4945),
      onSurfaceVariant: Color(0xfff3fdf8),
      outline: Color(0xffc3cdc8),
      outlineVariant: Color(0xffc3cdc8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003127),
      primaryFixed: Color(0xffa6f7df),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8adac3),
      onPrimaryFixedVariant: Color(0xff001b14),
      secondaryFixed: Color(0xffffe59f),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe7c870),
      onSecondaryFixedVariant: Color(0xff1d1500),
      tertiaryFixed: Color(0xffcfeaff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffaecfe7),
      onTertiaryFixedVariant: Color(0xff001926),
      surfaceDim: Color(0xff0e1513),
      surfaceBright: Color(0xff343b38),
      surfaceContainerLowest: Color(0xff090f0d),
      surfaceContainerLow: Color(0xff171d1b),
      surfaceContainer: Color(0xff1b211f),
      surfaceContainerHigh: Color(0xff252b29),
      surfaceContainerHighest: Color(0xff303634),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
