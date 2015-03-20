// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisans_search_form;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:gex_webapp_kit_client/elements/ternary_options.dart';



@CustomTag('dartisans-search-form')
class DartisansSearchFormElement extends Positionable with Showable {
  final Logger log = new Logger('DartisansSearchForm');

  @observable DartisansSearchForm _model;

  DartisansSearchFormElement.created() : super.created();

  @override
  void ready(){
    optionsReadyForTraining.init(new TernaryOptionsModel("Ready for training"));
    optionsReadyToBeHired.init(new TernaryOptionsModel("Ready to be hired"));
    optionsReadyForTalks.init(new TernaryOptionsModel("Ready for talks"));    
  }
  
  DartisansSearchForm get model => _model; 
  set model(DartisansSearchForm value) { 
    _model = value;
    optionsReadyForTraining.option = _model.readyForTraining ;
    optionsReadyForTalks.option = _model.readyForTalks ;
    optionsReadyToBeHired.option = _model.readyToBeHired ;
    
  }
  
  TernaryOptions get optionsReadyForTraining  => $["optionsReadyForTraining"];
  TernaryOptions get optionsReadyForTalks  => $["optionsReadyForTalks"];
  TernaryOptions get optionsReadyToBeHired  => $["optionsReadyToBeHired"];
  

}