import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NativeView extends StatelessWidget {
  const NativeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // THis is used in the platform side to register the view.
    const String viewType = '<platform-view-type>';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
