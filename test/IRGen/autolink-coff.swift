// RUN: rm -rf %t
// RUN: mkdir -p %t
// RUN: %swift -target thumbv7--windows-gnu -parse-as-library -parse-stdlib -emit-module-path %t/module.swiftmodule -module-name module -module-link-name module %s
// RUN: %swift -target thumbv7--windows-gnu -parse-as-library -parse-stdlib -module-name autolink -I %t -D MAIN_MODULE -emit-ir -o - %s | FileCheck %s -check-prefix CHECK-GNU-IR
// RUN: %swift -target thumbv7--windows-gnu -parse-as-library -parse-stdlib -module-name autolink -I %t -D MAIN_MODULE -S -o - %s | FileCheck %s -check-prefix CHECK-GNU-ASM

#if MAIN_MODULE
import module
#endif

// CHECK-GNU-IR: !{{[0-9]+}} = !{i32 {{[0-9]+}}, !"Linker Options", [[NODE:![0-9]+]]}
// CHECK-GNU-IR: [[NODE]] = !{[[LIST:![0-9]+]]}
// CHECK-GNU-IR: [[LIST]] = !{!"-lmodule"}

// CHECK-GNU-ASM: .section .drectve
// CHECK-GNU-ASM: .ascii " -lmodule"

