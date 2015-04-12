// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_details;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:gex_webapp_kit/client/elements/formated_text.dart';

class DartisanDetailsModel {
  Dartisan dartisan;

  bool get readyForSomeThing => dartisan.readyForTalks || dartisan.readyForTraining || dartisan.readyToBeHired;
  bool get hasBio => dartisan.bio != null || dartisan.dartisanBio != null;
  bool get hasGitHub => dartisan.gitHubAccount != null;
  bool get hasTwitter => dartisan.twitterAccount != null;
  bool get hasGooglePLus => dartisan.googlePlusUrl != null;

  String get atWorkLabel {
    if (dartisan.atWork == null) {
      return null;
    }
    if (dartisan.atWork == 1) {
      return "Work on Dart only at home";
    } else {
      return "At my job : " + dartisan.atWorkLabel;
    }
  }
}

@CustomTag('dartisan-details')
class DartisanDetails extends Positionable with Showable {
  final Logger log = new Logger('DartisanDetails');

  @observable DartisanDetailsModel model;

  DartisanDetails.created() : super.created();

  factory DartisanDetails.newElement(Dartisan dartisan) {
    return (new Element.tag('dartisan-details') as DartisanDetails)..dartisan = dartisan;
  }

  set dartisan(Dartisan dartisan) {
    model = new DartisanDetailsModel()..dartisan = dartisan;
    ($["formatedBio"] as FormatedText).text = dartisan.bio;
    ($["formatedDartisanBio"] as FormatedText).text = dartisan.dartisanBio;
  }
}
