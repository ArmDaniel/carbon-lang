// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() -> (i32, i32);

fn G() -> (i32, i32) {
  var v: (i32, i32) = F();
  v = F();
  return F();
}

fn H() -> i32 {
  return G()[0];
}

// CHECK:STDOUT: file "in_place_tuple_initialization.carbon" {
// CHECK:STDOUT:   %F = fn_decl @F
// CHECK:STDOUT:   %G = fn_decl @G
// CHECK:STDOUT:   %H = fn_decl @H
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> %return: (i32, i32);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() -> %return: (i32, i32) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_19: (type, type) = tuple_literal (i32, i32)
// CHECK:STDOUT:   %v: ref (i32, i32) = var "v"
// CHECK:STDOUT:   %F.ref.loc10 = name_reference_untyped "F", package.%F
// CHECK:STDOUT:   %.loc10_7: ref (i32, i32) = splice_block %v {}
// CHECK:STDOUT:   %.loc10_24: init (i32, i32) = call @F() to %.loc10_7
// CHECK:STDOUT:   assign %v, %.loc10_24
// CHECK:STDOUT:   %v.ref: ref (i32, i32) = name_reference "v", %v
// CHECK:STDOUT:   %F.ref.loc11 = name_reference_untyped "F", package.%F
// CHECK:STDOUT:   %.loc11_3: ref (i32, i32) = splice_block %v.ref {}
// CHECK:STDOUT:   %.loc11_8: init (i32, i32) = call @F() to %.loc11_3
// CHECK:STDOUT:   assign %v.ref, %.loc11_8
// CHECK:STDOUT:   %F.ref.loc12 = name_reference_untyped "F", package.%F
// CHECK:STDOUT:   %.loc9: ref (i32, i32) = splice_block %return {}
// CHECK:STDOUT:   %.loc12: init (i32, i32) = call @F() to %.loc9
// CHECK:STDOUT:   return %.loc12
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @H() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %G.ref = name_reference_untyped "G", package.%G
// CHECK:STDOUT:   %.loc16_11.1: ref (i32, i32) = temporary_storage
// CHECK:STDOUT:   %.loc16_11.2: init (i32, i32) = call @G() to %.loc16_11.1
// CHECK:STDOUT:   %.loc16_14: i32 = int_literal 0
// CHECK:STDOUT:   %.loc16_11.3: ref (i32, i32) = temporary %.loc16_11.1, %.loc16_11.2
// CHECK:STDOUT:   %.loc16_15.1: ref i32 = tuple_index %.loc16_11.3, %.loc16_14
// CHECK:STDOUT:   %.loc16_15.2: i32 = bind_value %.loc16_15.1
// CHECK:STDOUT:   return %.loc16_15.2
// CHECK:STDOUT: }
