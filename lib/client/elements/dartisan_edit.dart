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

@CustomTag('gex-dartisan-edit')
class DartisanEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanEdit');

  @observable String dartisanBio;

  DartisanEdit.created() : super.created();

  @override
  void ready() {
    bioTextArea.rows = 10;
    bioTextArea.maxLength = 5000;
  }

  set user(User user) {
    openId = user.openId;
    email = user.email;
    displayName = user.displayName;
    familyName = user.familyName;
    givenName = user.givenName;
    avatarUrl = user.avatarUrl;
    bio = user.bio;
  }
  User get user => new User.fromFields(
      openId: openId,
      email: email,
      displayName: displayName,
      familyName: familyName,
      givenName: givenName,
      avatarUrl: avatarUrl,
      bio: bioTextArea.value);

  TextAreaElement get bioTextArea => $["bioTextArea"] as TextAreaElement;
}
