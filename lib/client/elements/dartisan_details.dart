// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_details;

import "dart:html";
import 'dart:js' as js;
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/user_edit.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:paper_elements/paper_checkbox.dart';
import 'package:connecting_dartisans/client/elements/dartisan_checkbox.dart';
import 'package:connecting_dartisans/client/elements/dartisan_level.dart';

class DartisanDetailsModel {
  Dartisan dartisan;

  bool get readyForSomeThing => dartisan.readyForTalks || dartisan.readyForTraining || dartisan.readyToBeHired;
  bool get hasBio => dartisan.bio != null || dartisan.dartisanBio != null;
}

@CustomTag('dartisan-details')
class DartisanDetails extends Positionable with Showable {
  final Logger log = new Logger('DartisanDetails');

  @observable DartisanDetailsModel model;

  DartisanDetails.created() : super.created();

  factory DartisanDetails.newElement(Dartisan dartisan) {
    return (new Element.tag('dartisan-details') as DartisanDetails)..dartisan = dartisan;
  }

  set dartisan(Dartisan value) {
    model = new DartisanDetailsModel()..dartisan = value;
  }

  HtmlElement get mainElement => $["main"] as HtmlElement;
}
