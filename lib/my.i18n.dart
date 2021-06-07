import 'package:i18n_extension/i18n_extension.dart';

const String legalese = 'Blah blah.';

extension Localization on String {
  static final _t = Translations.byLocale('en_us') +
    {
      'en_us': {
        'Shodana Reader': 'Shodana Reader',
        'Oops, there was an error': 'Oops, there was an error',
        'Error: Unknown Page': 'Error: Unknown Page',
        'Settings': 'Settings',
        'Version': 'Version',
        'Website': 'Website',
        'Open source licenses': 'Open source licenses',
        'Left handed navigation rail': 'Left handed navigation rail',
        'Show on left side': 'Show on left side',
        'Show on right side': 'Show on right side',
        legalese: 'Blah blah.',
        'Github': 'Github',
        'Discord': 'Discord',
        'About': 'About',
        'General': 'General',
        'Theme': 'Theme',
        'Dark mode': 'Dark mode',
        'Follow system theme': 'Follow system theme',
        'Dark mode setting will be ignored': 'Dark mode setting will be ignored',
        'Login': 'Login',
        'Sign up': 'Sign up',
        'Continue with Google': 'Continue with Google',
        'Email': 'Email',
        'Password': 'Password',
        'Please enter email': 'Please enter email',
        'Please enter password': 'Please enter password',
        'Please confirm password': 'Please confirm password',
        'Passwords do not match': 'Passwords do not match',
        'Confirm password': 'Confirm password',
        'Profile': 'Profile',
        'Username': 'Username',
        'Edit Profile': 'Edit Profile',
        'Save': 'Save',
        'Cancel': 'Cancel',
        'Get Started': 'Get Started',
        'Account': 'Account',
        'Shodana': 'Shodana',
        'More': 'More',
        'Home': 'Home',
        'Shelves': 'Shelves',
        'Clubs': 'Clubs',
        'Discover': 'Discover',
        'Last used': 'Last used',
        'Starting screen': 'Starting screen'
      },
    }
    // + 
    // {
    //   'language_code': {
    //     'Original string': 'Translated string',
    //   }
    // }
    ;

  String get i18n => localize(this, _t);

  /// String interpolation parameters
  String fill(List<Object> params) => localizeFill(this, params);

  /// Show different text based on the number
  String plural(int value) => localizePlural(value, this, _t);

  // Custom modifier based on enums
  // String version(Object modifier) => localizeVersion(modifier, this, _t);

  /// Returns a map of all translated strings, where modifiers are the keys.
  /// In special, the unversioned text is indexed with a `null` key.
  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}