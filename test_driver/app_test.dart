import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// Temp test file, will be updated once the app is more functional
void main() {
  group('Reader app', () {
    /*final button = */find.byType('FloatingActionButton');

    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if(driver != null) {
        await driver!.close();
      }
    });

    test('Given test case', () async {
      // await driver!.tap(button);

      // final text = find.text('Text here');

      // expect(await driver!.getText(text), 'Text here');
    });
  });
}