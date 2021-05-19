import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../ui/app_screen/provider/default_starting_page_provider.dart';

final navCurrentIndexProvider = StateProvider((ref) => ref.read
  (defaultStartingPageProvider.notifier).getDefaultPage());

