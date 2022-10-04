// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:jnigen/src/elements/elements.dart';
import 'package:jnigen/src/config/config.dart';

import 'common.dart';

// TODO(#52): Do not use long names in C bindings. Use conflict-renamed short
// name as class name; Use `__` between class & method name.

// fullName / mangled name =
// binaryName with replace('.', '_'), replace('$', '__');

class CBindingGenerator {
  static const _classVarPrefix = '_c';
  static const _methodVarPrefix = '_m';
  static const _fieldVarPrefix = '_f';
  static final indent = ' ' * 4;

  // These should be avoided in parameter names.
  static const _cTypeKeywords = {
    'short',
    'char',
    'int',
    'long',
    'float',
    'double',
  };

  String _renameCParam(String paramName) =>
      _cTypeKeywords.contains(paramName) ? '${paramName}0' : paramName;

  CBindingGenerator(this.config);
  Config config;

  String generateBinding(ClassDecl c) => _class(c);

  String _class(ClassDecl c) {
    final s = StringBuffer();
    final fullName = mangledClassName(c);

    // global variable in C that holds the reference to class
    final classVar = '${_classVarPrefix}_$fullName';
    s.write('// ${c.binaryName}\n');
    s.write('jclass $classVar = NULL;\n\n');

    for (var m in c.methods) {
      if (!m.isIncluded) {
        continue;
      }
      s.write(_method(c, m));
      s.writeln();
    }

    for (var f in c.fields) {
      if (!f.isIncluded) {
        continue;
      }
      final fieldBinding = _field(c, f);
      s.write(fieldBinding);
      // Fields are skipped if they're static final. In that case
      // do not write too much whitespace.
      if (fieldBinding.isNotEmpty) s.writeln();
    }
    return s.toString();
  }

  String _method(ClassDecl c, Method m) {
    final cClassName = mangledClassName(c);
    final isACtor = isCtor(m);
    final isStatic = isStaticMethod(m);

    final s = StringBuffer();
    final name = m.finalName;

    final methodID = '${_methodVarPrefix}_${cClassName}_$name';
    s.write('jmethodID $methodID = NULL;\n');

    final returnType = isCtor(m) ? 'jobject' : m.returnType.name;
    final cReturnType = getCType(returnType);
    final cMethodName = '${cClassName}_$name';
    final cParams = _formalArgs(m);
    s.write('FFI_PLUGIN_EXPORT\n');
    s.write('$cReturnType $cMethodName($cParams) {\n');

    final classVar = '${_classVarPrefix}_$cClassName';
    final jniSignature = getJniSignature(m);

    final ifError = '($cReturnType)0';

    s.write(_loadEnvCall);
    s.write(_loadClassCall(classVar, getInternalName(c.binaryName), ifError));

    final ifStatic = isStatic ? 'static_' : '';
    s.write('${indent}load_${ifStatic}method($classVar, '
        '&$methodID, "${m.name}", "$jniSignature");\n');
    s.write('${indent}if ($methodID == NULL) return $ifError;\n');

    var returnTypeName = m.returnType.name;
    if (isACtor) {
      returnTypeName = c.binaryName;
    }

    s.write(indent);
    if (returnTypeName != 'void') {
      s.write('${getCType(returnTypeName)} _result = ');
    }

    final callType = _typeNameAtCallSite(m.returnType);
    final callArgs = _callArgs(m, classVar, methodID);
    if (isACtor) {
      s.write('(*jniEnv)->NewObject($callArgs);\n');
    } else {
      final ifStatic = isStatic ? 'Static' : '';
      s.write('(*jniEnv)->Call$ifStatic${callType}Method($callArgs);\n');
    }
    if (returnTypeName != 'void') {
      s.write(_result(m));
    }
    s.write('}\n');
    return s.toString();
  }

  String _field(ClassDecl c, Field f) {
    final cClassName = mangledClassName(c);
    final isStatic = isStaticField(f);

    // If the field is final and default is assigned, then no need to wrap
    // this field. It should then be a constant in dart code.
    if (isStatic && isFinalField(f) && f.defaultValue != null) {
      return "";
    }

    final s = StringBuffer();

    final fieldName = f.finalName;
    final fieldVar = "${_fieldVarPrefix}_${cClassName}_$fieldName";

    s.write('jfieldID $fieldVar = NULL;\n');
    final classVar = '${_classVarPrefix}_$cClassName';

    void writeAccessor({bool isSetter = false}) {
      final ct = isSetter ? 'void' : getCType(f.type.name);
      // Getter
      final prefix = isSetter ? 'set' : 'get';
      s.write('FFI_PLUGIN_EXPORT\n');
      s.write('$ct ${prefix}_${memberNameInC(c, fieldName)}(');
      final formalArgs = <String>[
        if (!isStatic) 'jobject self_',
        if (isSetter) '${getCType(f.type.name)} value',
      ];
      s.write(formalArgs.join(', '));
      s.write(') {\n');
      s.write(_loadEnvCall);
      s.write(
          _loadClassCall(classVar, getInternalName(c.binaryName), '($ct)0'));

      var ifStatic = isStatic ? 'static_' : '';
      s.write(
          '${indent}load_${ifStatic}field($classVar, &$fieldVar, "$fieldName",'
          '"${_fieldSignature(f)}");\n');

      ifStatic = isStatic ? 'Static' : '';
      final callType = _typeNameAtCallSite(f.type);
      final acc = isSetter ? 'Set' : 'Get';
      final ret = isSetter ? '' : 'return ';
      final conv = !isSetter && !isPrimitive(f.type) ? 'to_global_ref' : '';
      s.write('$indent$ret$conv((*jniEnv)->$acc$ifStatic${callType}Field');
      final secondArg = isStatic ? classVar : 'self_';
      s.write('(jniEnv, $secondArg, $fieldVar');
      if (isSetter) {
        s.write(', value');
      }
      s.write('));\n');
      s.write('}\n\n');
    }

    writeAccessor(isSetter: false);
    if (isFinalField(f)) {
      return s.toString();
    }
    writeAccessor(isSetter: true);
    return s.toString();
  }

  final String _loadEnvCall = '${indent}load_env();\n';

  String _loadClassCall(String classVar, String internalName, String ifError) {
    return '${indent}load_class_gr(&$classVar, '
        '"$internalName");\n'
        '${indent}if ($classVar == NULL) return $ifError;\n';
  }

  String _formalArgs(Method m) {
    final args = <String>[];
    if (hasSelfParam(m)) {
      // The underscore-suffixed name prevents accidental collision with
      // parameter named self, if any.
      args.add('jobject self_');
    }

    for (var param in m.params) {
      final paramName = _renameCParam(param.name);
      args.add('${getCType(param.type.name)} $paramName');
    }

    return args.join(", ");
  }

  // Returns arguments at call site, concatenated by `,`.
  String _callArgs(Method m, String classVar, String methodVar) {
    final args = ['jniEnv'];
    if (hasSelfParam(m)) {
      args.add('self_');
    } else {
      args.add(classVar);
    }
    args.add(methodVar);
    for (var param in m.params) {
      final paramName = _renameCParam(param.name);
      args.add(paramName);
    }
    return args.join(', ');
  }

  String _result(Method m) {
    final cReturnType = getCType(m.returnType.name);
    if (cReturnType == 'jobject' || isCtor(m)) {
      return '${indent}return to_global_ref(_result);\n';
    } else {
      return '${indent}return _result;\n';
    }
  }

  String _fieldSignature(Field f) {
    final internalName = getInternalNameOfUsage(f.type);
    if (internalName.length == 1) {
      return internalName;
    }
    return 'L$internalName;';
  }

  /// Returns capitalized java type name to be used as in call${type}Method
  /// or get${type}Field etc..
  String _typeNameAtCallSite(TypeUsage type) {
    if (isPrimitive(type)) {
      return type.name.substring(0, 1).toUpperCase() + type.name.substring(1);
    }
    return "Object";
  }
}

class CPreludes {
  static const autoGeneratedNotice = '// Autogenerated by jnigen. '
      'DO NOT EDIT!\n\n';
  static const includes = '#include <stdint.h>\n'
      '#include "jni.h"\n'
      '#include "dartjni.h"\n'
      '\n';
  static const defines = 'thread_local JNIEnv *jniEnv;\n'
      'JniContext jni;\n\n'
      'JniContext (*context_getter)(void);\n'
      'JNIEnv *(*env_getter)(void);\n'
      '\n';
  static const initializers = 'void setJniGetters(JniContext (*cg)(void),\n'
      '        JNIEnv *(*eg)(void)) {\n'
      '    context_getter = cg;\n'
      '    env_getter = eg;\n'
      '}\n'
      '\n';
  static const prelude =
      autoGeneratedNotice + includes + defines + initializers;
}