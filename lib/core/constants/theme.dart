import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;
  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF000000),
      surfaceTint: Color(0xFFF2F2F2),
      onPrimary:
          Colors
              .white, // Text color on primary (usually white on darker colors)
      primaryContainer: Colors.white, // Lightened primary container color
      onPrimaryContainer: Color(0xFF000000),
      // color on primary container
      secondary: Color(0xFF5760D3), // Secondary color
      onSecondary: Colors.blueGrey.shade400, // Text color on secondary
      secondaryContainer: Color(0xFFF3F4F6), // Secondary container color
      onSecondaryContainer:
          Colors.blueGrey.shade100, // Text color on secondary container
      tertiary: Color(0xFF), // Tertiary color
      onTertiary: Color(0xff), // Text color on tertiary
      tertiaryContainer: Color(0xff), // Lightened tertiary container color
      onTertiaryContainer: Color(0xff), // Text color on tertiary container
      error: Color(0xFFB00020), // Error color
      onError: Colors.white, // Text color on error
      errorContainer: Color(0xFFFFDAD6), // Error container color
      onErrorContainer: Color(0xFFB00020), // Text color on error container
      surface: Colors.grey[50]!, // Surface color (light theme)
      onSurface: Colors.black, // Text color on surface
      onSurfaceVariant: Color(0xFF), // On surface variant
      outline: Color(0xFF), // Outline color
      outlineVariant: Color(0xFF), // Outline variant
      shadow: Color(0xFF), // Shadow color
      scrim: Color(0xFF), // Scrim color
      inverseSurface: Color(0xFF), // Inverse surface color
      inversePrimary: Color(0xFF), // Inverse primary color
      primaryFixed: Color(0xFF), // Fixed primary color
      onPrimaryFixed: Colors.black, // Text color on fixed primary
      primaryFixedDim: Color(0xFF), // Dimmed primary color
      onPrimaryFixedVariant: Color(0xFF), // Fixed primary variant color
      secondaryFixed: Color(0xFF), // Fixed secondary color
      onSecondaryFixed: Colors.white, // Text color on fixed secondary
      secondaryFixedDim: Color(0xFF), // Dimmed fixed secondary color
      onSecondaryFixedVariant: Color(0xFF), // Fixed secondary variant color
      tertiaryFixed: Color(0xFF), // Fixed tertiary color
      onTertiaryFixed: Colors.black, // Text color on fixed tertiary
      tertiaryFixedDim: Color(0xFF), // Dimmed fixed tertiary color
      onTertiaryFixedVariant: Color(0xFF), // Fixed tertiary variant color
      surfaceDim: Color(0xFF), // Dimmed surface color
      surfaceBright: Color(0xFF), // Bright surface color
      surfaceContainerLowest: Color(0xFF), // Lowest container surface
      surfaceContainerLow: Color(0xFF), // Low container surface
      surfaceContainer: Color(0xFF), // Medium container surface
      surfaceContainerHigh: Color(0xFF), // High container surface
      surfaceContainerHighest: Color(0xFF), // Highest container surface
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF348B5F), // Primary color for dark theme
      surfaceTint: Color(0xff3572EF), // Surface tint for dark theme
      onPrimary: Color(0xFFB3B3B3), // Text color on primary
      primaryContainer: Color(
        0xFF1f1f1f,
      ), // Lightened primary container color for dark theme
      // primaryContainer:
      // Color(0xFF4D4D50),
      onPrimaryContainer: Colors.white, // Text color on primary container
      secondary: Color(0xFFFFFFFF), // Secondary color
      onSecondary: Colors.white, // Text color on secondary
      secondaryContainer: Color(0xFF4D4D50), // Secondary container color
      onSecondaryContainer: Colors.white, // Text color on secondary container
      tertiary: Color(0xFF838282), // Tertiary color
      onTertiary: Colors.white, // Text color on tertiary
      tertiaryContainer: Color(
        0xFF1f1f1f,
      ), // Lightened tertiary container color
      onTertiaryContainer: Colors.grey[600], // Text color on tertiary container
      error: Color(0xFFB00020), // Error color
      onError: Colors.white, // Text color on error
      errorContainer: Color(0xFFFFDAD6), // Error container color
      onErrorContainer: Color(0xFFB00020), // Text color on error container
      surface: Color(0xff121212), // Dark theme scaffold background color
      // surface: Color(0xFF1C1A1A),
      onSurface: Colors.white, // Text color on surface
      onSurfaceVariant: Color(0xFFB0B0B0), // On surface variant
      outline: Color(0xFF6C6C6C), // Outline color
      outlineVariant: Color(0xFF9E9E9E), // Outline variant
      shadow: Color(0xFF000000), // Shadow color
      scrim: Color(0xFF000000), // Scrim color
      inverseSurface: Color(0xFF2C2C2C), // Inverse surface color
      inversePrimary: Color(0xff3572EF), // Inverse primary color
      primaryFixed: Color(0xff3572EF), // Fixed primary color
      onPrimaryFixed: Colors.black, // Text color on fixed primary
      primaryFixedDim: Colors.blue.withOpacity(0.8), // Dimmed primary color
      onPrimaryFixedVariant: Color(0xFF6C63FF), // Fixed primary variant color
      secondaryFixed: Color(0xFF4D4D50), // Fixed secondary color
      onSecondaryFixed: Colors.white, // Text color on fixed secondary
      secondaryFixedDim: Color(0xFF6C6C6C), // Dimmed fixed secondary color
      onSecondaryFixedVariant: Color(
        0xFF9E9E9E,
      ), // Fixed secondary variant color
      tertiaryFixed: Color(0xFFB3B3B3), // Fixed tertiary color
      onTertiaryFixed: Colors.black, // Text color on fixed tertiary
      tertiaryFixedDim: Color(0xFF838282), // Dimmed fixed tertiary color
      onTertiaryFixedVariant: Color(0xFF9E9E9E), // Fixed tertiary variant color
      surfaceDim: Color(0xFF2C2C2C), // Dimmed surface color
      surfaceBright: Color(0xFF3C3C3C), // Bright surface color for dark theme
      surfaceContainerLowest:
          Colors.black12, // Lowest container surface in dark theme
      surfaceContainerLow: Colors.black, // Low container surface in dark theme
      surfaceContainer: Color(
        0xFF5C5C5C,
      ), // Medium container surface in dark theme
      surfaceContainerHigh: Color(
        0xFF6C6C6C,
      ), // High container surface in dark theme
      surfaceContainerHighest: Color(
        0xFF7C7C7C,
      ), // Highest container surface in dark theme
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
