// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_at_work;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_slider.dart';

@CustomTag('dartisan-level')
class DartisanAtWork extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanLevel');

  @published String mainLabel;
  @observable String levelLabel;

  DartisanAtWork.created() : super.created();

  @override
  void ready() {
    levelSlider.on['core-change'].listen((_) {
      _updateLabel();
    });
  }

  void set level(num value) {
    levelSlider.value = value;
  }

  num get level => levelSlider.value;

  void _updateLabel() {
    switch (levelSlider.value) {
      case 1:
        levelLabel = "Only at home";
        break;
      case 2:
        levelLabel = "Some experimentation only";
        break;
      case 3:
        levelLabel = "A small part of my time";
        break;
      case 4:
        levelLabel = "A large part of my time";
        break;
      case 5:
        levelLabel = "Full time on Dart";
        break;
      default:
        levelLabel = "";
    }
  }

  PaperSlider get levelSlider => $["levelSlider"] as PaperSlider;
}
