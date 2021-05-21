import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreAboutScreenMobile extends StatelessWidget {
  const MoreAboutScreenMobile({
    Key? key,
    required this.aboutFuture}) : super(key: key);
  final Future<Widget> aboutFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context)!.errorText)
            );
          }
          // Once complete, show your application
          else if (snapshot.hasData) {
            return Container(child: snapshot.data,);
          }

          else {
            // ignore: sized_box_for_whitespace
            return Container(
                height: MediaQuery.of(context).size.height /
                    1.25,
                width: MediaQuery.of(context).size.width /
                    1.25,
                child: const CircularProgressIndicator()
            );
          }
        },
        future: aboutFuture
    );
  }
}
