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

@CustomTag('dartisan-edit')
class DartisanEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanEdit');

  @observable String dartisanBio;
  
  DartisanEdit.created() : super.created();

  @override
  void ready() {
    bioTextArea.rows = 10;
    bioTextArea.maxLength = 5000;
  }

  set dartisan(Dartisan dartisan) {
    userEdit.user = dartisan ;
    dartisanBio = dartisan.dartisanBio;
    readyForTrainingCheckBox.checked = dartisan.readyForTraining;
  }

  set user(User user) {
    userEdit.user = user ;
  }
  
  Dartisan get dartisan => new Dartisan.fromUser(
      userEdit.user,
      dartisanBio:bioTextArea.value,
      readyForTraining: readyForTrainingCheckBox.checked ,
      readyForTalks: readyForTalksCheckBox.checked ,
      readyToBeHired: readyToBeHiredCheckBox.checked );

  TextAreaElement get bioTextArea => $["bioTextArea"] as TextAreaElement;
  UserEdit get userEdit => $["userEdit"] as UserEdit;
  PaperCheckbox get readyForTrainingCheckBox => $["readyForTraining"] as PaperCheckbox;
  PaperCheckbox get readyForTalksCheckBox => $["readyForTalks"] as PaperCheckbox;
  PaperCheckbox get readyToBeHiredCheckBox => $["readyToBeHired"] as PaperCheckbox;

  

}
