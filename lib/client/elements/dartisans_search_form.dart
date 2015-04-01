// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_search_form;

import "dart:html";
import "dart:async";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:connecting_dartisans/connecting_dartisans_client.dart';
import 'package:gex_webapp_kit_client/elements/ternary_options.dart';
import 'package:gex_webapp_kit_client/elements/multi_select.dart';

@CustomTag('dartisans-search-form')
class DartisansSearchFormElement extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisansSearchForm');

  DartisansSearchFormElement.created() : super.created() {}

  DartisansSearchForm _lastSearchFormFired = new DartisansSearchForm();
  void _updateDartisansSearchForm() {
    DartisansSearchForm current = dartisansSearchForm;
    if (_lastSearchFormFired != current) {
      _lastSearchFormFired = current.clone();
      fireApplicationEvent(new DartisansApplicationEvent.callSearch(this, _lastSearchFormFired));
    }
    new Timer(new Duration(seconds: 1), _updateDartisansSearchForm);
  }

  @override
  void recieveApplicationEvent(ApplicationEvent event) {
    super.recieveApplicationEvent(event);
    if (event.isViewPortChange) {
      _orientationMultiSelect(event.viewPort.windowWidth);
    }
  }

  void _orientationMultiSelect(num windowWidth) {
    if (windowWidth < 975) {
      levelSelect.vertical();
      atWorkSelect.vertical();
    } else {
      levelSelect.horizontal();
      atWorkSelect.horizontal();
    }
  }

  @override
  void ready() {
    MultiSelectModel levelSelectModel =
        new MultiSelectModel(new Set<num>(), ["", "Beginner", "Intermediate", "Experienced", "Advanced", "Expert"]);
    levelSelect.init(levelSelectModel);
    MultiSelectModel atWorkSelectModel =
        new MultiSelectModel(new Set<num>(), ["", "At home", "Little time", "Half time", "Most of time", "Full time"]);
    atWorkSelect.init(atWorkSelectModel);
    _orientationMultiSelect(window.innerWidth);

    optionsReadyForTraining.init(new TernaryOptionsModel("Ready for training"));
    optionsReadyToBeHired.init(new TernaryOptionsModel("Ready to be hired"));
    optionsReadyForTalks.init(new TernaryOptionsModel("Ready for talks"));

    _updateDartisansSearchForm();
  }

  DartisansSearchForm get dartisansSearchForm {
    DartisansSearchForm form = new DartisansSearchForm();
    form.fullTextSearch = fullTextSearch.value;
    form.readyForTraining = optionsReadyForTraining.optionAsBool;
    form.readyForTalks = optionsReadyForTalks.optionAsBool;
    form.readyToBeHired = optionsReadyToBeHired.optionAsBool;
    form.selectedLevels = levelSelect.selectedElements;
    form.selectedAtWork = atWorkSelect.selectedElements;

    return form;
  }
  set dartisansSearchForm(DartisansSearchForm form) {
    fullTextSearch.value = form.fullTextSearch;
    optionsReadyForTraining.optionAsBool = form.readyForTraining;
    optionsReadyForTalks.optionAsBool = form.readyForTalks;
    optionsReadyToBeHired.optionAsBool = form.readyToBeHired;
  }

  TernaryOptions get optionsReadyForTraining => $["optionsReadyForTraining"];
  TernaryOptions get optionsReadyForTalks => $["optionsReadyForTalks"];
  TernaryOptions get optionsReadyToBeHired => $["optionsReadyToBeHired"];
  InputElement get fullTextSearch => $["fullTextSearch"];
  MultiSelect get levelSelect => $["levelSelect"];
  MultiSelect get atWorkSelect => $["atWorkSelect"];
}
