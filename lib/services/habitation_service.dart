import 'package:location/models/habitation.dart';
import 'package:location/models/habitations_data.dart';
import 'package:location/models/type_habitat.dart';
import 'package:location/models/type_habitat_data.dart';

class HabitationService {
  var _typehabitats;
  var _habitations;

  HabitationService() {
    _typehabitats = TypeHabitatData.buildList();
    _habitations = HabitationsData.buildList();
  }

  List<TypeHabitat> getTypeHabitats() {
    return _typehabitats;
  }

  List<Habitation> getHabitationsTop10() {
    return _habitations
        .where((element) => element.id%2 == 1)
        .take(10)
        .toList();
  }

  List<Habitation> getMaisons() {
    return _getHabitations(isHouse: true);
  }

  List<Habitation> getAppartements() {
    return _getHabitations(isHouse: false);
  }

  List<Habitation> _getHabitations({bool isHouse = true}) {
    return _habitations
        .where((element) => element.typeHabitat.id == (isHouse ? 1 : 2))
        .toList();
  }
}