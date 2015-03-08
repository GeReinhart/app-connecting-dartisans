// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans_server;

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:redstone/server.dart' as app;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:connection_pool/connection_pool.dart';
import "package:redstone_mapper/plugin.dart";
import "package:redstone_mapper_mongo/service.dart";

import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:gex_webapp_kit_client/webapp_kit_server.dart' hide UserService;
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';

part 'server/dartisan_service.dart';
