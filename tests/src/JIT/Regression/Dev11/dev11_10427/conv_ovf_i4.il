// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
// See the LICENSE file in the project root for more information.

.assembly Conv_ovf_u4_Bug {}


.assembly extern System.Console
{
  .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A )
  .ver 4:0:0:0
}
.assembly extern mscorlib
{
.publickeytoken = (B7 7A 5C 56 19 34 E0 89 )
.ver 2:0:0:0
}

.method static public int32 main() il managed
{
.entrypoint
.locals init ([0] int64 alpha, [1] int32 delta, [2] int32 result)

.try
{
call int32 [mscorlib]System.Environment::get_TickCount()
conv.i8
ldc.i8 0x80000000
or
stloc.0
ldc.i4 100
stloc result

ldloc.0
ldc.i4.m1
conv.u8
and
conv.ovf.i4
stloc.1

ldstr "First conv.ovf.i4 raised no exception. delta = "
call void [System.Console]System.Console::Write(string)
ldloc.1
call void [System.Console]System.Console::WriteLine(int32)
ldc.i4 101
stloc result

ldloc.0
ldc.i4.m1
conv.u8
and

stloc.0
ldloc.0

conv.ovf.i4
stloc.1

ldstr "Second conv.ovf.i4 raised no exception. delta = "
call void [System.Console]System.Console::Write(string)
ldloc.1
call void [System.Console]System.Console::WriteLine(int32)

leave.s EXIT
}
catch [mscorlib]System.Exception
{
callvirt instance class [mscorlib]System.Type [mscorlib]System.Exception::GetType()
callvirt instance string [mscorlib]System.Reflection.MemberInfo::get_Name()
call void [System.Console]System.Console::Write(string)

leave.s EXIT
}

EXIT:
ldloc result
ret
}
