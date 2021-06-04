
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'tr_en.dart';

/// Callers can lookup localized strings with an instance of TR returned
/// by `TR.of(context)`.
///
/// Applications need to include `TR.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/tr.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TR.localizationsDelegates,
///   supportedLocales: TR.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the TR.supportedLocales
/// property.
abstract class TR {
  TR(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TR? of(BuildContext context) {
    return Localizations.of<TR>(context, TR);
  }

  static const LocalizationsDelegate<TR> delegate = _TRDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// The name of the app
  ///
  /// In en, this message translates to:
  /// **'Shodana Reader'**
  String get appName;

  /// General error text
  ///
  /// In en, this message translates to:
  /// **'Oops, there was an error'**
  String get errorText;

  /// Error text for when it is routed to an invalid url
  ///
  /// In en, this message translates to:
  /// **'Error: Unknown Page'**
  String get errorPageText;

  /// Text for the settings button
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsButtonText;

  /// Text for the version button
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get versionButtonText;

  /// Text for the website button
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get websiteButtonText;

  /// Text for the open source licenses button
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get licensesButtonText;

  /// Text for the switch to change which side to show the navigation rail on
  ///
  /// In en, this message translates to:
  /// **'Left handed navigation rail'**
  String get leftHandedNavigationRailSwitchText;

  /// Navigation rail will be on the left side of the screen in landscape mode
  ///
  /// In en, this message translates to:
  /// **'Show on left side'**
  String get leftHandedNavigationRailSubtitleLeftText;

  /// Navigation rail will be on the right side of the screen in landscape mode
  ///
  /// In en, this message translates to:
  /// **'Show on right side'**
  String get leftHandedNavigationRailSubtitleRightText;

  /// Text for the open source licenses legalese
  ///
  /// In en, this message translates to:
  /// **'Blah blah.'**
  String get applicationLegalese;

  /// Text for the Github button
  ///
  /// In en, this message translates to:
  /// **'Github'**
  String get githubButtonText;

  /// Text for the Discord button
  ///
  /// In en, this message translates to:
  /// **'Discord'**
  String get discordButtonText;

  /// Text for the about button
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutButtonText;

  /// Text for the general settings button
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalButtonText;

  /// Theme section title for the general settings page
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSectionText;

  /// Text for the dark mode switch
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkModeSwitchText;

  /// Text for the follow system theme switch
  ///
  /// In en, this message translates to:
  /// **'Follow system theme'**
  String get followSysThemeSwitchText;

  /// Description text for the follow system theme switch
  ///
  /// In en, this message translates to:
  /// **'Dark mode setting will be ignored'**
  String get followSysThemeSwitchSubtitle;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonText;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signupButtonText;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get googleButtonText;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomePageTitle;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'EBook Reader App'**
  String get welcomePageSubtitle;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailFieldlabel;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordFieldLabel;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get emailValidationError;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get passwordValidationError;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmPasswordValidationEmptyError;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmPasswordValidationMatchError;

  /// Text used on the login/signup page
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordFieldLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profilePageTitle;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameFieldLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get nameValidationError;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButtonLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get pickFromGalleryButtonLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get pickFromCameraButtonLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonLabel;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImageDialogTitle;

  /// Not used
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get introFinishButtonLabel;

  /// App bar title for the home page
  ///
  /// In en, this message translates to:
  /// **'Shodana'**
  String get homePageTitle;

  /// App bar title for the shelves page
  ///
  /// In en, this message translates to:
  /// **'Shelves'**
  String get shelvesPageTitle;

  /// App bar title for the clubs page
  ///
  /// In en, this message translates to:
  /// **'Clubs'**
  String get clubsPageTitle;

  /// App bar title for the discover page
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverPageTitle;

  /// App bar title for the account page
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountPageTitle;

  /// App bar title for the more page
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get morePageTitle;

  /// App bar title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// App bar title for the settings->general page
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalPageTitle;

  /// App bar title for the settings->about page
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutPageTitle;

  /// Navigation bar text for the home item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeBottomNavItemText;

  /// Navigation bar text for the shelves item
  ///
  /// In en, this message translates to:
  /// **'Shelves'**
  String get shelvesBottomNavItemText;

  /// Navigation bar text for the clubs item
  ///
  /// In en, this message translates to:
  /// **'Clubs'**
  String get clubsBottomNavItemText;

  /// Navigation bar text for the discover item
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverBottomNavItemText;

  /// Navigation bar text for the more item
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreBottomNavItemText;

  /// Text for button to set the starting screen to the last used, given that it is home, shelves, or clubs.
  ///
  /// In en, this message translates to:
  /// **'Last used'**
  String get startingScreenOptionLastUsedText;

  /// Text for button to set the starting screen to the home screen
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get startingScreenOptionHomeText;

  /// Text for button to set the starting screen to shelves
  ///
  /// In en, this message translates to:
  /// **'Shelves'**
  String get startingScreenOptionShelvesText;

  /// Text for button to set the starting screen to clubs
  ///
  /// In en, this message translates to:
  /// **'Clubs'**
  String get startingScreenOptionClubsText;

  /// Text for button to set the starting screen to discover
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get startingScreenOptionDiscoverText;

  /// Text for button to set the starting screen to more
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get startingScreenOptionMoreText;

  /// Text for dialog for setting the starting screen
  ///
  /// In en, this message translates to:
  /// **'Starting screen'**
  String get setStartingScreenDialogText;
}

class _TRDelegate extends LocalizationsDelegate<TR> {
  const _TRDelegate();

  @override
  Future<TR> load(Locale locale) {
    return SynchronousFuture<TR>(_lookupTR(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TRDelegate old) => false;
}

TR _lookupTR(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'en': return TREn();
}


  throw FlutterError(
    'TR.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
