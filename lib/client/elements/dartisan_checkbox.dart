// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_checkbox;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_checkbox.dart';

@CustomTag('dartisan-checkbox')
class DartisanCheckBox extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanLevel');

  @published String checkMain;
  @published String checkDetails;

  DartisanCheckBox.created() : super.created();

  void set checked(bool value) {
    checkbox.checked = value;
  }

  bool get checked => checkbox.checked;

  PaperCheckbox get checkbox => $["checkbox"] as PaperCheckbox;
}
