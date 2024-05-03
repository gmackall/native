// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:cli_config/cli_config.dart';
import 'package:collection/collection.dart';
import 'package:pub_semver/pub_semver.dart';

import '../model/hook.dart';
import '../model/resource_identifiers.dart';
import '../utils/map.dart';
import 'architecture.dart';
import 'asset.dart';
import 'build_config.dart';
import 'build_mode.dart';
import 'hook_config.dart';
import 'ios_sdk.dart';
import 'link_mode_preference.dart';
import 'os.dart';
import 'resource.dart';

part '../model/link_config.dart';

/// The configuration for a link hook (`hook/link.dart`) invocation.
///
/// It consists of a subset of the fields from the [BuildConfig] already passed
/// to the build hook, the [assets] from the build step, and the
/// [treeshakingInformation] generated during the kernel compilation.
abstract class LinkConfig implements HookConfig {
  /// The list of assets to be linked. These are the assets generated by a
  /// `build.dart` script destined for this packages `link.dart`.
  Iterable<Asset> get assets;

  /// A collection of methods annotated with `@ResourceIdentifier`, which are
  /// called in the tree-shaken Dart code. This information can be used to
  /// dispose unused [assets].
  ///
  /// This is `null` in JIT mode, where no resources are collected, or in a dry
  /// run.
  Iterable<Resource>? get treeshakingInformation;

  /// Generate the [LinkConfig] from the input arguments to the linking script.
  factory LinkConfig.fromArguments(List<String> arguments) =>
      LinkConfigImpl.fromArguments(arguments);

  factory LinkConfig.build({
    required Uri outputDirectory,
    required String packageName,
    required Uri packageRoot,
    Architecture? targetArchitecture,
    required OS targetOS,
    IOSSdk? targetIOSSdk,
    CCompilerConfig? cCompiler,
    BuildMode? buildMode,
    List<String>? supportedAssetTypes,
    int? targetAndroidNdkApi,
    required Iterable<Asset> assets,
    Uri? resourceIdentifierUri,
    required LinkModePreference linkModePreference,
    bool? dryRun,
    Version? version,
  }) =>
      LinkConfigImpl(
        assets: assets.cast(),
        resourceIdentifierUri: resourceIdentifierUri,
        outputDirectory: outputDirectory,
        packageName: packageName,
        packageRoot: packageRoot,
        buildMode: buildMode as BuildModeImpl,
        cCompiler: cCompiler as CCompilerConfigImpl?,
        targetAndroidNdkApi: targetAndroidNdkApi,
        targetArchitecture: targetArchitecture as ArchitectureImpl?,
        targetIOSSdk: targetIOSSdk as IOSSdkImpl?,
        targetOS: targetOS as OSImpl,
        dryRun: dryRun,
        linkModePreference: linkModePreference as LinkModePreferenceImpl,
        supportedAssetTypes: supportedAssetTypes,
        version: version,
      );

  factory LinkConfig.dryRun({
    required Uri outputDirectory,
    required String packageName,
    required Uri packageRoot,
    required OS targetOS,
    List<String>? supportedAssetTypes,
    required Iterable<Asset> assets,
    Uri? resourceIdentifierUri,
    required LinkModePreference linkModePreference,
    Version? version,
  }) =>
      LinkConfigImpl.dryRun(
        assets: assets.cast(),
        resourceIdentifierUri: resourceIdentifierUri,
        outputDirectory: outputDirectory,
        packageName: packageName,
        packageRoot: packageRoot,
        targetOS: targetOS as OSImpl,
        supportedAssetTypes: supportedAssetTypes,
        linkModePreference: linkModePreference as LinkModePreferenceImpl,
        version: version,
      );

  /// The version of [BuildConfig].
  ///
  /// The build config is used in the protocol between the Dart and Flutter SDKs
  /// and packages through build hook invocations.
  ///
  /// We're trying to avoid breaking changes. However, in the case that we have
  /// to, the major version mismatch between the Dart or Flutter SDK and build
  /// hook (`hook/build.dart`) will lead to a nice error message.
  static Version get latestVersion => HookConfigImpl.latestVersion;
}
