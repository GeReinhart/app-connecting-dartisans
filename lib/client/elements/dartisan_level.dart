// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_level;

import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_slider.dart';

@CustomTag('dartisan-level')
class DartisanLevel extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanLevel');

  @published String mainLabel;
  @observable String levelLabel;

  DartisanLevel.created() : super.created();

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
        levelLabel = "Beginner";
        break;
      case 2:
        levelLabel = "Intermediate";
        break;
      case 3:
        levelLabel = "Experienced";
        break;
      case 4:
        levelLabel = "Advanced";
        break;
      case 5:
        levelLabel = "Expert";
        break;
      default:
        levelLabel = "";
    }
  }

  PaperSlider get levelSlider => $["levelSlider"] as PaperSlider;
}
