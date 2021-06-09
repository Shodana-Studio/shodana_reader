import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify(path: 'scripts/.env', name: 'ScriptEnv')
abstract class ScriptEnv {
    static const databaseKey = _ScriptEnv.databaseKey;
    static const healthKey = _ScriptEnv.healthKey;
}