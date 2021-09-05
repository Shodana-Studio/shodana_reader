import 'package:flappwrite_account_kit/flappwrite_account_kit.dart';

enum OAuth {amazon, apple, bitbucket, bitly, box, discord, dropbox, facebook, github, gitlab, google, linkedin, microsoft, paypal, paypalSandbox, salesforce, slack, spotify, tradeshift, tradeshiftBox, twitch, vk, yahoo, yandex, wordpress}

extension OAuthExt on AuthNotifier {
  /// Create Account Session with OAuth2
  /// 
  /// Allow the user to login to their account using the OAuth2 provider of their choice.
  /// Each OAuth2 provider should be enabled from the Appwrite console first.
  /// Use the success and failure arguments to provide a redirect URL's back to your app when login is completed.
  Future<bool> createOAuth2SessionFromEnum({
    required OAuth provider,
    // TODO: Add success and failure URLs once I implement OAuth
    String success = 'https://appwrite.io/auth/oauth2/success',
    String failure = 'https://appwrite.io/auth/oauth2/failure',
    List scopes = const [],
  }) async {
    final String providerStr;
    switch (provider) {
      case OAuth.amazon:
        providerStr = 'amazon';
        break;
      case OAuth.apple:
        providerStr = 'apple';
        break;
      case OAuth.bitbucket:
        providerStr = 'bitbucket';
        break;
      case OAuth.bitly:
        providerStr = 'bitly';
        break;
      case OAuth.box:
        providerStr = 'box';
        break;
      case OAuth.discord:
        providerStr = 'discord';
        break;
      case OAuth.dropbox:
        providerStr = 'dropbox';
        break;
      case OAuth.facebook:
        providerStr = 'facebook';
        break;
      case OAuth.github:
        providerStr = 'github';
        break;
      case OAuth.gitlab:
        providerStr = 'gitlab';
        break;
      case OAuth.google:
        providerStr = 'google';
        break;
      case OAuth.linkedin:
        providerStr = 'linkedin';
        break;
      case OAuth.microsoft:
        providerStr = 'microsoft';
        break;
      case OAuth.paypal:
        providerStr = 'paypal';
        break;
      case OAuth.paypalSandbox:
        providerStr = 'paypalSandbox';
        break;
      case OAuth.salesforce:
        providerStr = 'salesforce';
        break;
      case OAuth.slack:
        providerStr = 'slack';
        break;
      case OAuth.spotify:
        providerStr = 'spotify';
        break;
      case OAuth.tradeshift:
        providerStr = 'tradeshift';
        break;
      case OAuth.tradeshiftBox:
        providerStr = 'tradeshiftBox';
        break;
      case OAuth.twitch:
        providerStr = 'twitch';
        break;
      case OAuth.vk:
        providerStr = 'vk';
        break;
      case OAuth.yahoo:
        providerStr = 'yahoo';
        break;
      case OAuth.yandex:
        providerStr = 'yandex';
        break;
      case OAuth.wordpress:
        providerStr = 'wordpress';
        break;
    }

    return createOAuth2Session(provider: providerStr, success: success, failure: failure, scopes: scopes);
  }
}