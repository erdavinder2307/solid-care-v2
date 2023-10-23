import 'package:solidcare/main.dart';
import 'package:solidcare/model/encounter_model.dart';
import 'package:solidcare/model/encounter_type_model.dart';
import 'package:solidcare/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

List<EncounterType> getEncounterOtherTypeList(
    {required String encounterType, required EncounterModel encounterData}) {
  switch (encounterType) {
    case PROBLEM:
      return encounterData.problem.validate();
    case OBSERVATION:
      return encounterData.observation.validate();
    case NOTE:
      return encounterData.note.validate();
    default:
      return [];
  }
}

(List<EncounterType> encounterOtherTypeList, {String? emptyText})
    getEncounterOtherTypeListData(
        {required String encounterType,
        required EncounterModel encounterData}) {
  switch (encounterType) {
    case PROBLEM:
      return (
        encounterData.problem.validate(),
        emptyText: encounterData.problem.validate().isEmpty
            ? locale.lblNoProblemFound
            : null
      );
    case OBSERVATION:
      return (
        encounterData.observation.validate(),
        emptyText: encounterData.observation.validate().isEmpty
            ? locale.lblNoObservationsFound
            : null
      );
    case NOTE:
      return (
        encounterData.note.validate(),
        emptyText: encounterData.note.validate().isEmpty
            ? locale.lblNoNotesFound
            : null
      );
    default:
      return ([], emptyText: '');
  }
}
