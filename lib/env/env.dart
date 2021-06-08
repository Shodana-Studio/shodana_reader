import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify(path: 'scripts/.env')
abstract class ScriptEnv {
    static const String databaseKey = _ScriptEnv.databaseKey;
    static const String healthKey = _ScriptEnv.healthKey;
}