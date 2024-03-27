// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../native_assets_cli_internal.dart';
import 'link_config.dart';
import 'link_output.dart';

/// Runs a native assets link.
///
/// Can link native assets which are not already available, or expose existing
/// files. Each individual asset is assigned a unique asset ID.
///
/// The linking script may receive assets from build scripts, which are accessed
/// through [LinkConfig.assets]. They will only be bundled with the final
/// application if included in the [LinkOutput].
///
/// As the linking runs after kernel compilation, you can use treeshaking
/// information provided through [LinkConfig.resources] to decide which assets
/// to include.
///
///
/// ```dart
/// import 'package:native_assets_cli/native_assets_cli.dart';
///
/// void main(List<String> args) async {
///   await link(args, (config, output) async {
///     final packageName = config.packageName;
///     final root = config.packageRoot;
///     final allAssets = [
///       DataAsset(
///         package: packageName,
///         name: 'unused',
///         file: root.resolve('assets').resolve('unused_asset.json'),
///       ),
///       DataAsset(
///         package: packageName,
///         name: 'used',
///         file: root.resolve('assets').resolve('used_asset.json'),
///       )
///     ];
///     output.addAssets(shake(allAssets, config.resources));
///   });
/// }
///
/// Iterable<Asset> shake(
///   List<DataAsset> allAssets,
///   List<Resource> resources,
/// ) =>
///     allAssets.where(
///       (asset) => resources.any((resource) => resource.metadata == asset.id),
///     );
/// ```
Future<void> link(
  List<String> arguments,
  Future<void> Function(LinkConfig config, LinkOutput output) builder,
) async {
  final config = LinkConfig(arguments) as LinkConfigImpl;

  // The built assets are dependencies of linking, as the linking should be
  // rerun if they change.
  final builtAssetsFiles =
      config.assets.map((asset) => asset.file).whereType<Uri>().toList();
  final linkOutput =
      LinkOutputImpl(dependencies: Dependencies(builtAssetsFiles));
  await builder(config, linkOutput);
  await linkOutput.writeToFile(config: config);
}
