// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_summary;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:gex_webapp_kit/client/elements/formated_text.dart';

class DartisanSummaryModel {
  Dartisan dartisan;

  @observable String get bioSummary {
    if (dartisan == null) {
      return "";
    }

    String bioSummary = "";
    if (dartisan.dartisanBio != null) {
      bioSummary += dartisan.dartisanBio;
    }
    if (dartisan.bio != null) {
      bioSummary += " " + dartisan.bio;
    }
    if (bioSummary.length > 300) {
      bioSummary = bioSummary.substring(0, 297) + "...";
    }
    return bioSummary;
  }
}

@CustomTag('dartisan-summary')
class DartisanSummary extends Positionable with Showable {
  final Logger log = new Logger('DartisanSummary');

  @observable bool small = false;

  @observable DartisanSummaryModel model;
  @observable Color color = Color.BLUE_0082C8.lightColorAsColor;

  DartisanSummary.created() : super.created();

  factory DartisanSummary.newElement(Dartisan dartisan) {
    return (new Element.tag('dartisan-summary') as DartisanSummary)..dartisan = dartisan;
  }

  @override
  void ready() {
    mainElement.onMouseEnter.listen((e) => mainElement.style.backgroundColor = Color.WHITE.mainColor);
    mainElement.onMouseLeave.listen((e) => mainElement.style.backgroundColor = color.lightColor);
  }

  set dartisan(Dartisan value) {
    model = new DartisanSummaryModel()..dartisan = value;
    ($["formatedBio"] as FormatedText).text = model.bioSummary;
  }

  Dartisan get dartisan => model.dartisan;

  HtmlElement get mainElement => $["main"] as HtmlElement;
}
