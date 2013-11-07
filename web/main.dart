import 'package:angular/angular.dart';
import 'package:celebrating_special_occasions/main.dart';

main() {
  var module = new AngularModule()
    ..type(EventsCtrl);

  ngBootstrap(module: module);
}
