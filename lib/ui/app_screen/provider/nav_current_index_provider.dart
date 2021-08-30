import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'default_starting_page_provider.dart';

final navCurrentIndexProvider = StateProvider((ref) => ref.read
  (defaultStartingPageProvider.notifier).getDefaultPage());

