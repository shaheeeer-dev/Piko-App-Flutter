# Piko native branding

Source: existing assets/images/piko_logo.svg, preserved byte-for-byte.
Requested design: https://www.figma.com/design/cDeUZ9Sf9xMkH8ZlEPLdSJ/ (SVG clip IDs reference node 9:3287). The existing SVG was visually matched to node 9:3287 in the Figma Brand & palette section. Fresh export was blocked: Figma MCP Starter quota was exhausted and browser export required sign-in.

piko_logo.png: 1024px raster of the original rounded-square artwork.
piko_mark.svg: original lime vector paths, with forest tile removed and bounds centered.
app_icon.png: opaque 1024px forest launcher icon; platform supplies its corner mask.
app_icon_foreground.png: transparent 1024px padded adaptive foreground; inset is already included.
splash_logo.png: transparent 768px canvas for pre-12 Android and iOS.
splash_logo_android12.png: transparent 1152px canvas with mark inside the 768px circular safe region.

All files live in assets/images, already declared in pubspec.yaml. Existing Inter regular/bold declarations and C01 BrandScreen are preserved.

Regenerate native resources after updating PNGs:

    flutter pub get
    dart run flutter_launcher_icons
    dart run flutter_native_splash:create

Cold-start from the launcher to inspect the native splash. Hot reload does not show it. Android 12+ controls the centered native splash layout; C01's full layout appears on Flutter's first frame.

After regeneration, keep NormalTheme windowBackground at #173E35 in all Android values*/styles.xml files. flutter_launcher_icons 0.14.4 also incorrectly rewrites ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS to AppIcon; restore YES if this occurs.
