// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_edit;

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

@CustomTag('dartisan-summary')
class DartisanSummary extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanSummary');

  @observable Dartisan dartisan;

  DartisanSummary.created() : super.created();

  factory DartisanSummary.newElement(Dartisan dartisan) {
    return (new Element.tag('dartisan-summary') as DartisanSummary)..dartisan = dartisan;
  }
}
