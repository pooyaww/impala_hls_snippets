; ModuleID = 'pipeline_sa'
source_filename = "pipeline_sa"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@0 = private unnamed_addr constant [8 x i8] c"hls_top\00", align 1
@1 = private unnamed_addr constant [15 x i8] c"pipeline_sa.cl\00", align 1

define void @main() local_unnamed_addr {
main:
  %types = alloca [0 x i8], align 8
  %0 = alloca [3 x i32], align 4
  %1 = alloca [3 x i32], align 4
  %.repack = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 0
  store i32 1, i32* %.repack, align 4
  %.repack1 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 1
  store i32 1, i32* %.repack1, align 4
  %.repack2 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 2
  store i32 1, i32* %.repack2, align 4
  %.repack3 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  store i32 1, i32* %.repack3, align 4
  %.repack4 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 1
  store i32 1, i32* %.repack4, align 4
  %.repack5 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 2
  store i32 1, i32* %.repack5, align 4
  %2 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 0
  %3 = getelementptr inbounds [3 x i32], [3 x i32]* %0, i64 0, i64 0
  %4 = bitcast [0 x i8]* %types to i8**
  %5 = bitcast [0 x i8]* %types to i32*
  %6 = bitcast [0 x i8]* %types to i32*
  %7 = bitcast [0 x i8]* %types to i32*
  %8 = getelementptr inbounds [0 x i8], [0 x i8]* %types, i64 0, i64 0
  call void @anydsl_launch_kernel(i32 2, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @0, i64 0, i64 0), i32* nonnull %2, i32* nonnull %3, i8** nonnull %4, i32* nonnull %5, i32* nonnull %6, i32* nonnull %7, i8* nonnull %8, i32 0)
  ret void
}

declare void @anydsl_launch_kernel(i32, i8*, i8*, i32*, i32*, i8**, i32*, i32*, i32*, i8*, i32) local_unnamed_addr
