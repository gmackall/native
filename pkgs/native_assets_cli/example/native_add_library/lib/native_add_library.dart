// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'dart:ffi' as ffi;

@ffi.Native<ffi.Int32 Function(ffi.Int32, ffi.Int32)>(symbol: 'add')
external int add(
  int a,
  int b,
);

@ffi.Native<
    ffi.Void Function(ffi.Pointer<ffi.Void>,
        ffi.Pointer<ffi.Pointer<ffi.Char>>)>(symbol: 'the_finalizer')
external void the_finalizer(
  ffi.Pointer<ffi.Void> native_resource,
  ffi.Pointer<ffi.Pointer<ffi.Char>> err,
);

@ffi.Native<ffi.Void Function(ffi.Pointer<FinalizerHelper>)>(
    symbol: 'finalizer_wrapper')
external void finalizer_wrapper(
  ffi.Pointer<FinalizerHelper> helper,
);

final class FinalizerHelper extends ffi.Struct {
  external ffi.Pointer<ffi.Void> thing_to_free;

  external ffi
      .Pointer<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<ffi.Char>)>>
      callback;
}
