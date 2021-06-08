import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify(path: 'scripts/.env')
abstract class ScriptEnv {
    static const databaseKey = _ScriptEnv.databaseKey;
}