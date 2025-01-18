// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum AssetProvider {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Colors {
    internal enum Backgrounds {
      internal static let backgroundsBottomNavigation = ColorAsset(name: "Colors/Backgrounds/backgroundsBottomNavigation")
      internal static let backgroundsPrimary = ColorAsset(name: "Colors/Backgrounds/backgroundsPrimary")
      internal static let backgroundsSecondary = ColorAsset(name: "Colors/Backgrounds/backgroundsSecondary")
      internal static let backgroundsTertiary = ColorAsset(name: "Colors/Backgrounds/backgroundsTertiary")
    }
    internal enum Foregrounds {
      internal static let foregroundsOnPrimary = ColorAsset(name: "Colors/Foregrounds/foregroundsOnPrimary")
      internal static let foregroundsPrimary = ColorAsset(name: "Colors/Foregrounds/foregroundsPrimary")
      internal static let foregroundsSecondary = ColorAsset(name: "Colors/Foregrounds/foregroundsSecondary")
      internal static let foregroundsSeparator = ColorAsset(name: "Colors/Foregrounds/foregroundsSeparator")
      internal static let foregroundsTertiary = ColorAsset(name: "Colors/Foregrounds/foregroundsTertiary")
    }
    internal enum Icons {
      internal static let iconsPrimary = ColorAsset(name: "Colors/Icons/iconsPrimary")
      internal static let iconsSecondary = ColorAsset(name: "Colors/Icons/iconsSecondary")
      internal static let iconsTertiary = ColorAsset(name: "Colors/Icons/iconsTertiary")
    }
  }
  internal enum Icons {
    internal enum _16 {
      internal static let favoritesActive = ImageAsset(name: "Icons/favorites_active")
      internal static let favoritesXCircle = ImageAsset(name: "Icons/favorites_x-circle")
    }
    internal enum _24 {
      internal static let arrowLeft = ImageAsset(name: "Icons/arrow_left")
      internal static let arrowRight = ImageAsset(name: "Icons/arrow_right")
      internal static let charactersActive = ImageAsset(name: "Icons/characters_active")
      internal static let charactersInactive = ImageAsset(name: "Icons/characters_inactive")
      internal static let favoritesEnabled = ImageAsset(name: "Icons/favorites_enabled")
      internal static let favoritesSelected = ImageAsset(name: "Icons/favorites_selected")
      internal static let search = ImageAsset(name: "Icons/search")
      internal static let x = ImageAsset(name: "Icons/x")
    }
    internal enum _32 {
      internal static let favoritesEnabled = ImageAsset(name: "Icons/favorites_enabled")
      internal static let favoritesSelected = ImageAsset(name: "Icons/favorites_selected")
    }
    internal enum _42 {
      internal static let characters = ImageAsset(name: "Icons/characters")
      internal static let favorites = ImageAsset(name: "Icons/favorites")
    }
  }
  internal enum Images {
    internal static let _1RickSanchez = ImageAsset(name: "Images/1 Rick Sanchez")
    internal static let _10AlanRails = ImageAsset(name: "Images/10 Alan Rails")
    internal static let _11AlbertEinstein = ImageAsset(name: "Images/11 Albert Einstein")
    internal static let _113EricStoltzMaskMorty = ImageAsset(name: "Images/113 Eric Stoltz Mask Morty")
    internal static let _12Alexander = ImageAsset(name: "Images/12 Alexander")
    internal static let _13AlienGoogah = ImageAsset(name: "Images/13 Alien Googah")
    internal static let _14AlienMorty = ImageAsset(name: "Images/14 Alien Morty")
    internal static let _15AlienRick = ImageAsset(name: "Images/15 Alien Rick")
    internal static let _2MortySmith = ImageAsset(name: "Images/2 Morty Smith")
    internal static let _20AntsInMyEyesJohnson = ImageAsset(name: "Images/20 Ants in my Eyes Johnson")
    internal static let _3SummerSmith = ImageAsset(name: "Images/3 Summer Smith")
    internal static let _4BethSmith = ImageAsset(name: "Images/4 Beth Smith")
    internal static let _5JerrySmith = ImageAsset(name: "Images/5 Jerry Smith")
    internal static let _56BootlegPortalChemistRick = ImageAsset(name: "Images/56 Bootleg Portal Chemist Rick")
    internal static let _6AbadangoClusterPrincess = ImageAsset(name: "Images/6 Abadango Cluster Princess")
    internal static let _7AbradolfLincler = ImageAsset(name: "Images/7 Abradolf Lincler")
    internal static let _8AdjudicatorRick = ImageAsset(name: "Images/8 Adjudicator Rick")
    internal static let _9AgencyDirector = ImageAsset(name: "Images/9 Agency Director")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
