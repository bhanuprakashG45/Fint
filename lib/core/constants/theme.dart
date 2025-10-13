import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;
  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF000000),
      surfaceTint: Color(0xFFF2F2F2),
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFF5760D3), // Secondary color
      onSecondary: Colors.blueGrey.shade400, // Text color on secondary
      secondaryContainer: Color(0xFFF3F4F6), // Secondary container color
      onSecondaryContainer:
          Colors.blueGrey.shade100, // Text color on secondary container
      tertiary: Color(0xFF000033), // Tertiary color
      // onTertiary: Color(0xff), // Text color on tertiary
      // tertiaryContainer: Color(0xff), // Lightened tertiary container color
      // onTertiaryContainer: Color(0xff), // Text color on tertiary container
      error: Color(0xFFB00020), // Error color
      onError: Colors.white, // Text color on error
      errorContainer: Color(0xFFFFDAD6), // Error container color
      onErrorContainer: Color(0xFFB00020), // Text color on error container
      surface: Colors.grey[50]!, // Surface color (light theme)
      onSurface: Colors.black, // Text color on surface
      // onSurfaceVariant: Color(0xFF), // On surface variant
      // outline: Color(0xFF), // Outline color
      // outlineVariant: Color(0xFF), // Outline variant
      // shadow: Color(0xFF), // Shadow color
      // scrim: Color(0xFF), // Scrim color
      // inverseSurface: Color(0xFF), // Inverse surface color
      // inversePrimary: Color(0xFF), // Inverse primary color
      // primaryFixed: Color(0xFF), // Fixed primary color
      // onPrimaryFixed: Colors.black, // Text color on fixed primary
      // primaryFixedDim: Color(0xFF), // Dimmed primary color
      // onPrimaryFixedVariant: Color(0xFF), // Fixed primary variant color
      // secondaryFixed: Color(0xFF), // Fixed secondary color
      // onSecondaryFixed: Colors.white, // Text color on fixed secondary
      // secondaryFixedDim: Color(0xFF), // Dimmed fixed secondary color
      // onSecondaryFixedVariant: Color(0xFF), // Fixed secondary variant color
      // tertiaryFixed: Color(0xFF), // Fixed tertiary color
      // onTertiaryFixed: Colors.black, // Text color on fixed tertiary
      // tertiaryFixedDim: Color(0xFF), // Dimmed fixed tertiary color
      // onTertiaryFixedVariant: Color(0xFF), // Fixed tertiary variant color
      // surfaceDim: Color(0xFF), // Dimmed surface color
      // surfaceBright: Color(0xFF), // Bright surface color
      // surfaceContainerLowest: Color(0xFF), // Lowest container surface
      // surfaceContainerLow: Color(0xFF), // Low container surface
      // surfaceContainer: Color(0xFF), // Medium container surface
      // surfaceContainerHigh: Color(0xFF), // High container surface
      // surfaceContainerHighest: Color(0xFF), // Highest container surface
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF000000),
      surfaceTint: Color(0xFFF2F2F2),
      onPrimary: Colors.white,
      primaryContainer: Colors.white,
      onPrimaryContainer: Color(0xFF000000),
      secondary: Color(0xFF5760D3), // Secondary color
      onSecondary: Colors.blueGrey.shade400, // Text color on secondary
      secondaryContainer: Color(0xFFF3F4F6), // Secondary container color
      onSecondaryContainer:
          Colors.blueGrey.shade100, // Text color on secondary container
      tertiary: Color(0xFF000033), // Tertiary color
      // onTertiary: Color(0xff), // Text color on tertiary
      // tertiaryContainer: Color(0xff), // Lightened tertiary container color
      // onTertiaryContainer: Color(0xff), // Text color on tertiary container
      error: Color(0xFFB00020), // Error color
      onError: Colors.white, // Text color on error
      errorContainer: Color(0xFFFFDAD6), // Error container color
      onErrorContainer: Color(0xFFB00020), // Text color on error container
      surface: Colors.grey[50]!, // Surface color (light theme)
      onSurface: Colors.black, // Text color on surface
      // onSurfaceVariant: Color(0xFF), // On surface variant
      // outline: Color(0xFF), // Outline color
      // outlineVariant: Color(0xFF), // Outline variant
      // shadow: Color(0xFF), // Shadow color
      // scrim: Color(0xFF), // Scrim color
      // inverseSurface: Color(0xFF), // Inverse surface color
      // inversePrimary: Color(0xFF), // Inverse primary color
      // primaryFixed: Color(0xFF), // Fixed primary color
      // onPrimaryFixed: Colors.black, // Text color on fixed primary
      // primaryFixedDim: Color(0xFF), // Dimmed primary color
      // onPrimaryFixedVariant: Color(0xFF), // Fixed primary variant color
      // secondaryFixed: Color(0xFF), // Fixed secondary color
      // onSecondaryFixed: Colors.white, // Text color on fixed secondary
      // secondaryFixedDim: Color(0xFF), // Dimmed fixed secondary color
      // onSecondaryFixedVariant: Color(0xFF), // Fixed secondary variant color
      // tertiaryFixed: Color(0xFF), // Fixed tertiary color
      // onTertiaryFixed: Colors.black, // Text color on fixed tertiary
      // tertiaryFixedDim: Color(0xFF), // Dimmed fixed tertiary color
      // onTertiaryFixedVariant: Color(0xFF), // Fixed tertiary variant color
      // surfaceDim: Color(0xFF), // Dimmed surface color
      // surfaceBright: Color(0xFF), // Bright surface color
      // surfaceContainerLowest: Color(0xFF), // Lowest container surface
      // surfaceContainerLow: Color(0xFF), // Low container surface
      // surfaceContainer: Color(0xFF), // Medium container surface
      // surfaceContainerHigh: Color(0xFF), // High container surface
      // surfaceContainerHighest: Color(0xFF), // Highest container surfacentainer surface in dark theme
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
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
