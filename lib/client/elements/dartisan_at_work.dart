// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_at_work;

import "dart:html";
import 'package:logging/logging.dart';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_slider.dart';

@CustomTag('dartisan-at-work')
class DartisanAtWork extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanAtWork');

  @published String mainLabel;
  @observable String atWorkLabel;

  DartisanAtWork.created() : super.created();

  @override
  void ready() {
    atWorkSlider.on['core-change'].listen((_) {
      _updateLabel();
    });
  }

  void set atWork(num value) {
    atWorkSlider.value = value;
  }

  num get atWork => atWorkSlider.value;

  void _updateLabel() {
    switch (atWorkSlider.value) {
      case 1:
        atWorkLabel = "Only at home";
        break;
      case 2:
        atWorkLabel = "Some experimentation only";
        break;
      case 3:
        atWorkLabel = "A small part of my time";
        break;
      case 4:
        atWorkLabel = "A large part of my time";
        break;
      case 5:
        atWorkLabel = "Full time on Dart";
        break;
      default:
        atWorkLabel = "";
    }
  }

  PaperSlider get atWorkSlider => $["atWorkSlider"] as PaperSlider;
}
