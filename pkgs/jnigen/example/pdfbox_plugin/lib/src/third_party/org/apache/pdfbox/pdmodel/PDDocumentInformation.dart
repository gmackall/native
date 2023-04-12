// Generated from Apache PDFBox library which is licensed under the Apache License 2.0.
// The following copyright from the original authors applies.
//
// Licensed to the Apache Software Foundation (ASF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to You under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance with
// the License.  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: file_names
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: overridden_fields
// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_shown_name

import "dart:isolate" show ReceivePort;
import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

import "../../../../_init.dart";

/// from: org.apache.pdfbox.pdmodel.PDDocumentInformation
///
/// This is the document metadata.  Each getXXX method will return the entry if
/// it exists or null if it does not exist.  If you pass in null for the setXXX
/// method then it will clear the value.
///@author Ben Litchfield
///@author Gerardo Ortiz
class PDDocumentInformation extends jni.JObject {
  @override
  late final jni.JObjType $type = type;

  PDDocumentInformation.fromRef(
    jni.JObjectPtr ref,
  ) : super.fromRef(ref);

  /// The type which includes information such as the signature of this class.
  static const type = $PDDocumentInformationType();
  static final _ctor = jniLookup<ffi.NativeFunction<jni.JniResult Function()>>(
          "PDDocumentInformation__ctor")
      .asFunction<jni.JniResult Function()>();

  /// from: public void <init>()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// Default Constructor.
  factory PDDocumentInformation() {
    return PDDocumentInformation.fromRef(_ctor().object);
  }

  static final _ctor1 = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__ctor1")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public void <init>(org.apache.pdfbox.cos.COSDictionary dic)
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// Constructor that is used for a preexisting dictionary.
  ///@param dic The underlying dictionary.
  factory PDDocumentInformation.ctor1(
    jni.JObject dic,
  ) {
    return PDDocumentInformation.fromRef(_ctor1(dic.reference).object);
  }

  static final _getCOSObject = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getCOSObject")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public org.apache.pdfbox.cos.COSDictionary getCOSObject()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the underlying dictionary that this object wraps.
  ///@return The underlying info dictionary.
  jni.JObject getCOSObject() {
    return const jni.JObjectType().fromRef(_getCOSObject(reference).object);
  }

  static final _getPropertyStringValue = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getPropertyStringValue")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.Object getPropertyStringValue(java.lang.String propertyKey)
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// Return the properties String value.
  ///
  /// Allows to retrieve the
  /// low level date for validation purposes.
  ///
  ///
  ///@param propertyKey the dictionaries key
  ///@return the properties value
  jni.JObject getPropertyStringValue(
    jni.JString propertyKey,
  ) {
    return const jni.JObjectType().fromRef(
        _getPropertyStringValue(reference, propertyKey.reference).object);
  }

  static final _getTitle = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getTitle")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getTitle()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the title of the document.  This will return null if no title exists.
  ///@return The title of the document.
  jni.JString getTitle() {
    return const jni.JStringType().fromRef(_getTitle(reference).object);
  }

  static final _setTitle = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setTitle")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setTitle(java.lang.String title)
  ///
  /// This will set the title of the document.
  ///@param title The new title for the document.
  void setTitle(
    jni.JString title,
  ) {
    return _setTitle(reference, title.reference).check();
  }

  static final _getAuthor = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getAuthor")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getAuthor()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the author of the document.  This will return null if no author exists.
  ///@return The author of the document.
  jni.JString getAuthor() {
    return const jni.JStringType().fromRef(_getAuthor(reference).object);
  }

  static final _setAuthor = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setAuthor")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setAuthor(java.lang.String author)
  ///
  /// This will set the author of the document.
  ///@param author The new author for the document.
  void setAuthor(
    jni.JString author,
  ) {
    return _setAuthor(reference, author.reference).check();
  }

  static final _getSubject = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getSubject")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getSubject()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the subject of the document.  This will return null if no subject exists.
  ///@return The subject of the document.
  jni.JString getSubject() {
    return const jni.JStringType().fromRef(_getSubject(reference).object);
  }

  static final _setSubject = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setSubject")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setSubject(java.lang.String subject)
  ///
  /// This will set the subject of the document.
  ///@param subject The new subject for the document.
  void setSubject(
    jni.JString subject,
  ) {
    return _setSubject(reference, subject.reference).check();
  }

  static final _getKeywords = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getKeywords")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getKeywords()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the keywords of the document.  This will return null if no keywords exists.
  ///@return The keywords of the document.
  jni.JString getKeywords() {
    return const jni.JStringType().fromRef(_getKeywords(reference).object);
  }

  static final _setKeywords = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setKeywords")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setKeywords(java.lang.String keywords)
  ///
  /// This will set the keywords of the document.
  ///@param keywords The new keywords for the document.
  void setKeywords(
    jni.JString keywords,
  ) {
    return _setKeywords(reference, keywords.reference).check();
  }

  static final _getCreator = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getCreator")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getCreator()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the creator of the document.  This will return null if no creator exists.
  ///@return The creator of the document.
  jni.JString getCreator() {
    return const jni.JStringType().fromRef(_getCreator(reference).object);
  }

  static final _setCreator = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setCreator")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setCreator(java.lang.String creator)
  ///
  /// This will set the creator of the document.
  ///@param creator The new creator for the document.
  void setCreator(
    jni.JString creator,
  ) {
    return _setCreator(reference, creator.reference).check();
  }

  static final _getProducer = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getProducer")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getProducer()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the producer of the document.  This will return null if no producer exists.
  ///@return The producer of the document.
  jni.JString getProducer() {
    return const jni.JStringType().fromRef(_getProducer(reference).object);
  }

  static final _setProducer = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setProducer")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setProducer(java.lang.String producer)
  ///
  /// This will set the producer of the document.
  ///@param producer The new producer for the document.
  void setProducer(
    jni.JString producer,
  ) {
    return _setProducer(reference, producer.reference).check();
  }

  static final _getCreationDate = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getCreationDate")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.util.Calendar getCreationDate()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the creation date of the document.  This will return null if no creation date exists.
  ///@return The creation date of the document.
  jni.JObject getCreationDate() {
    return const jni.JObjectType().fromRef(_getCreationDate(reference).object);
  }

  static final _setCreationDate = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__setCreationDate")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setCreationDate(java.util.Calendar date)
  ///
  /// This will set the creation date of the document.
  ///@param date The new creation date for the document.
  void setCreationDate(
    jni.JObject date,
  ) {
    return _setCreationDate(reference, date.reference).check();
  }

  static final _getModificationDate = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getModificationDate")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.util.Calendar getModificationDate()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the modification date of the document.  This will return null if no modification date exists.
  ///@return The modification date of the document.
  jni.JObject getModificationDate() {
    return const jni.JObjectType()
        .fromRef(_getModificationDate(reference).object);
  }

  static final _setModificationDate = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__setModificationDate")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setModificationDate(java.util.Calendar date)
  ///
  /// This will set the modification date of the document.
  ///@param date The new modification date for the document.
  void setModificationDate(
    jni.JObject date,
  ) {
    return _setModificationDate(reference, date.reference).check();
  }

  static final _getTrapped = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__getTrapped")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getTrapped()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the trapped value for the document.
  /// This will return null if one is not found.
  ///@return The trapped value for the document.
  jni.JString getTrapped() {
    return const jni.JStringType().fromRef(_getTrapped(reference).object);
  }

  static final _getMetadataKeys = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getMetadataKeys")
      .asFunction<jni.JniResult Function(ffi.Pointer<ffi.Void>)>();

  /// from: public java.util.Set<java.lang.String> getMetadataKeys()
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the keys of all metadata information fields for the document.
  ///@return all metadata key strings.
  ///@since Apache PDFBox 1.3.0
  jni.JObject getMetadataKeys() {
    return const jni.JObjectType().fromRef(_getMetadataKeys(reference).object);
  }

  static final _getCustomMetadataValue = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__getCustomMetadataValue")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public java.lang.String getCustomMetadataValue(java.lang.String fieldName)
  /// The returned object must be deleted after use, by calling the `delete` method.
  ///
  /// This will get the value of a custom metadata information field for the document.
  ///  This will return null if one is not found.
  ///@param fieldName Name of custom metadata field from pdf document.
  ///@return String Value of metadata field
  jni.JString getCustomMetadataValue(
    jni.JString fieldName,
  ) {
    return const jni.JStringType().fromRef(
        _getCustomMetadataValue(reference, fieldName.reference).object);
  }

  static final _setCustomMetadataValue = jniLookup<
              ffi.NativeFunction<
                  jni.JniResult Function(ffi.Pointer<ffi.Void>,
                      ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>>(
          "PDDocumentInformation__setCustomMetadataValue")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: public void setCustomMetadataValue(java.lang.String fieldName, java.lang.String fieldValue)
  ///
  /// Set the custom metadata value.
  ///@param fieldName The name of the custom metadata field.
  ///@param fieldValue The value to the custom metadata field.
  void setCustomMetadataValue(
    jni.JString fieldName,
    jni.JString fieldValue,
  ) {
    return _setCustomMetadataValue(
            reference, fieldName.reference, fieldValue.reference)
        .check();
  }

  static final _setTrapped = jniLookup<
          ffi.NativeFunction<
              jni.JniResult Function(ffi.Pointer<ffi.Void>,
                  ffi.Pointer<ffi.Void>)>>("PDDocumentInformation__setTrapped")
      .asFunction<
          jni.JniResult Function(
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void setTrapped(java.lang.String value)
  ///
  /// This will set the trapped of the document.  This will be
  /// 'True', 'False', or 'Unknown'.
  ///@param value The new trapped value for the document.
  ///@throws IllegalArgumentException if the parameter is invalid.
  void setTrapped(
    jni.JString value,
  ) {
    return _setTrapped(reference, value.reference).check();
  }
}

class $PDDocumentInformationType extends jni.JObjType<PDDocumentInformation> {
  const $PDDocumentInformationType();

  @override
  String get signature => r"Lorg/apache/pdfbox/pdmodel/PDDocumentInformation;";

  @override
  PDDocumentInformation fromRef(jni.JObjectPtr ref) =>
      PDDocumentInformation.fromRef(ref);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($PDDocumentInformationType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == $PDDocumentInformationType &&
        other is $PDDocumentInformationType;
  }
}