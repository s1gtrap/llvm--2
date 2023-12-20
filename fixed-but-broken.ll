; ModuleID = 'all.c'
source_filename = "all.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-macosx14.0.0"

%struct.anon = type { i32, ptr }
%struct.mz_stream_s = type { ptr, i32, i64, ptr, i32, i64, ptr, ptr, ptr, ptr, ptr, i32, i64, i64, i64 }
%struct.tdefl_compressor = type { ptr, ptr, i32, [2 x i32], i32, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, ptr, ptr, ptr, ptr, i32, ptr, i64, i64, [33025 x i8], [3 x [288 x i32]], [3 x [288 x i32]], [3 x [288 x i8]], [65536 x i8], [32768 x i32], [32768 x i32], [85196 x i8] }
%struct.inflate_state = type { %struct.tinfl_decompressor_tag, i32, i32, i32, i32, i32, [32768 x i8], i32 }
%struct.tinfl_decompressor_tag = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [3 x i32], i64, i64, [3 x %struct.tinfl_huff_table], [4 x i8], [457 x i8] }
%struct.tinfl_huff_table = type { [288 x i8], [1024 x i32], [576 x i32] }
%struct.tdefl_output_buffer = type { i64, i64, ptr, i32 }
%struct.mini_gzip = type { i64, i64, i64, i32, i32, i32, ptr, ptr, ptr, ptr, ptr, [3 x i8] }
%struct.stat = type { i32, i32, i32, i64, i32, i32, i32, %struct.timespec, %struct.timespec, %struct.timespec, %struct.timespec, i64, i64, i32, i32, i32, i32, [2 x i64] }
%struct.timespec = type { i64, i64 }
%struct.tdefl_sym_freq = type { i32, i32 }

@mz_crc32.s_crc32 = internal constant [16 x i32] [i32 0, i32 498536548, i32 997073096, i32 651767980, i32 1994146192, i32 1802195444, i32 1303535960, i32 1342533948, i32 -306674912, i32 -267414716, i32 -690576408, i32 -882789492, i32 -1687895376, i32 -2032938284, i32 -1609899400, i32 -1111625188], align 16
@.str = private unnamed_addr constant [7 x i8] c"9.1.12\00", align 1
@mz_error.s_error_descs = internal global [10 x %struct.anon] [%struct.anon { i32 0, ptr @.str.1 }, %struct.anon { i32 1, ptr @.str.2 }, %struct.anon { i32 2, ptr @.str.3 }, %struct.anon { i32 -1, ptr @.str.4 }, %struct.anon { i32 -2, ptr @.str.5 }, %struct.anon { i32 -3, ptr @.str.6 }, %struct.anon { i32 -4, ptr @.str.7 }, %struct.anon { i32 -5, ptr @.str.8 }, %struct.anon { i32 -6, ptr @.str.9 }, %struct.anon { i32 -10000, ptr @.str.10 }], align 16
@.str.1 = private unnamed_addr constant [1 x i8] c"\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"stream end\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"need dictionary\00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"file error\00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"stream error\00", align 1
@.str.6 = private unnamed_addr constant [11 x i8] c"data error\00", align 1
@.str.7 = private unnamed_addr constant [14 x i8] c"out of memory\00", align 1
@.str.8 = private unnamed_addr constant [10 x i8] c"buf error\00", align 1
@.str.9 = private unnamed_addr constant [14 x i8] c"version error\00", align 1
@.str.10 = private unnamed_addr constant [16 x i8] c"parameter error\00", align 1
@tinfl_decompress.s_length_base = internal constant [31 x i32] [i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 13, i32 15, i32 17, i32 19, i32 23, i32 27, i32 31, i32 35, i32 43, i32 51, i32 59, i32 67, i32 83, i32 99, i32 115, i32 131, i32 163, i32 195, i32 227, i32 258, i32 0, i32 0], align 16
@tinfl_decompress.s_length_extra = internal constant [31 x i32] [i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 1, i32 1, i32 2, i32 2, i32 2, i32 2, i32 3, i32 3, i32 3, i32 3, i32 4, i32 4, i32 4, i32 4, i32 5, i32 5, i32 5, i32 5, i32 0, i32 0, i32 0], align 16
@tinfl_decompress.s_dist_base = internal constant [32 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5, i32 7, i32 9, i32 13, i32 17, i32 25, i32 33, i32 49, i32 65, i32 97, i32 129, i32 193, i32 257, i32 385, i32 513, i32 769, i32 1025, i32 1537, i32 2049, i32 3073, i32 4097, i32 6145, i32 8193, i32 12289, i32 16385, i32 24577, i32 0, i32 0], align 16
@tinfl_decompress.s_dist_extra = internal constant [32 x i32] [i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 2, i32 2, i32 3, i32 3, i32 4, i32 4, i32 5, i32 5, i32 6, i32 6, i32 7, i32 7, i32 8, i32 8, i32 9, i32 9, i32 10, i32 10, i32 11, i32 11, i32 12, i32 12, i32 13, i32 13, i32 0, i32 0], align 16
@tinfl_decompress.s_length_dezigzag = internal constant [19 x i8] c"\10\11\12\00\08\07\09\06\0A\05\0B\04\0C\03\0D\02\0E\01\0F", align 16
@tinfl_decompress.s_min_table_sizes = internal constant [3 x i32] [i32 257, i32 1, i32 4], align 4
@.str.11 = private unnamed_addr constant [4 x i8] c"\05\05\04\00", align 1
@.str.12 = private unnamed_addr constant [4 x i8] c"\02\03\07\00", align 1
@.str.13 = private unnamed_addr constant [4 x i8] c"\03\03\0B\00", align 1
@__func__.tdefl_compress_buffer = private unnamed_addr constant [22 x i8] c"tdefl_compress_buffer\00", align 1
@.str.14 = private unnamed_addr constant [6 x i8] c"all.c\00", align 1
@.str.15 = private unnamed_addr constant [19 x i8] c"d->m_pPut_buf_func\00", align 1
@s_tdefl_num_probes = internal constant [11 x i32] [i32 0, i32 1, i32 6, i32 32, i32 16, i32 32, i32 128, i32 256, i32 512, i32 768, i32 1500], align 16
@.str.16 = private unnamed_addr constant [6 x i8] c"\00\00\04\02\06\00", align 1
@.str.17 = private unnamed_addr constant [17 x i8] c"\00\00\00\00\00\00\00\00IEND\AEB`\82\00", align 1
@__func__.mini_gz_start = private unnamed_addr constant [14 x i8] c"mini_gz_start\00", align 1
@.str.18 = private unnamed_addr constant [15 x i8] c"gz_ptr != NULL\00", align 1
@__func__.mini_gz_chunksize_set = private unnamed_addr constant [22 x i8] c"mini_gz_chunksize_set\00", align 1
@.str.19 = private unnamed_addr constant [12 x i8] c"gz_ptr != 0\00", align 1
@.str.20 = private unnamed_addr constant [33 x i8] c"gz_ptr->magic == MINI_GZIP_MAGIC\00", align 1
@__func__.mini_gz_unpack = private unnamed_addr constant [15 x i8] c"mini_gz_unpack\00", align 1
@.str.21 = private unnamed_addr constant [21 x i8] c"gz_ptr->data_len > 0\00", align 1
@.str.22 = private unnamed_addr constant [20 x i8] c"ret != MZ_BUF_ERROR\00", align 1
@.str.23 = private unnamed_addr constant [12 x i8] c"cd123456789\00", align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str.24 = private unnamed_addr constant [9 x i8] c"o != '0'\00", align 1
@optind = external global i32, align 4
@.str.25 = private unnamed_addr constant [4 x i8] c".gz\00", align 1
@.str.26 = private unnamed_addr constant [27 x i8] c"flag_c: %d is_gzipped: %d\0A\00", align 1
@.str.27 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.28 = private unnamed_addr constant [31 x i8] c"in_fn: %s out_fn: %s level %d\0A\00", align 1
@.str.29 = private unnamed_addr constant [30 x i8] c"--- testing decompression --\0A\00", align 1
@.str.30 = private unnamed_addr constant [14 x i8] c"out_len = %d\0A\00", align 1
@.str.31 = private unnamed_addr constant [10 x i8] c"ret = %d\0A\00", align 1
@__func__.tdefl_compress_fast = private unnamed_addr constant [20 x i8] c"tdefl_compress_fast\00", align 1
@.str.32 = private unnamed_addr constant [106 x i8] c"(cur_match_len >= TDEFL_MIN_MATCH_LEN) && (cur_match_dist >= 1) && (cur_match_dist <= TDEFL_LZ_DICT_SIZE)\00", align 1
@s_tdefl_small_dist_sym = internal constant [512 x i8] c"\00\01\02\03\04\04\05\05\06\06\06\06\07\07\07\07\08\08\08\08\08\08\08\08\09\09\09\09\09\09\09\09\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\10\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11\11", align 16
@s_tdefl_large_dist_sym = internal constant [128 x i8] c"\00\00\12\13\14\14\15\15\16\16\16\16\17\17\17\17\18\18\18\18\18\18\18\18\19\19\19\19\19\19\19\19\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1A\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1B\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1C\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D\1D", align 16
@s_tdefl_len_sym = internal constant [256 x i32] [i32 257, i32 258, i32 259, i32 260, i32 261, i32 262, i32 263, i32 264, i32 265, i32 265, i32 266, i32 266, i32 267, i32 267, i32 268, i32 268, i32 269, i32 269, i32 269, i32 269, i32 270, i32 270, i32 270, i32 270, i32 271, i32 271, i32 271, i32 271, i32 272, i32 272, i32 272, i32 272, i32 273, i32 273, i32 273, i32 273, i32 273, i32 273, i32 273, i32 273, i32 274, i32 274, i32 274, i32 274, i32 274, i32 274, i32 274, i32 274, i32 275, i32 275, i32 275, i32 275, i32 275, i32 275, i32 275, i32 275, i32 276, i32 276, i32 276, i32 276, i32 276, i32 276, i32 276, i32 276, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 277, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 278, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 279, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 280, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 281, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 282, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 283, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 284, i32 285], align 16
@.str.33 = private unnamed_addr constant [32 x i8] c"lookahead_size >= cur_match_len\00", align 1
@__func__.tdefl_compress_normal = private unnamed_addr constant [22 x i8] c"tdefl_compress_normal\00", align 1
@.str.34 = private unnamed_addr constant [35 x i8] c"d->m_lookahead_size >= len_to_move\00", align 1
@__func__.tdefl_find_match = private unnamed_addr constant [17 x i8] c"tdefl_find_match\00", align 1
@.str.35 = private unnamed_addr constant [37 x i8] c"max_match_len <= TDEFL_MAX_MATCH_LEN\00", align 1
@__func__.tdefl_record_match = private unnamed_addr constant [19 x i8] c"tdefl_record_match\00", align 1
@.str.36 = private unnamed_addr constant [94 x i8] c"(match_len >= TDEFL_MIN_MATCH_LEN) && (match_dist >= 1) && (match_dist <= TDEFL_LZ_DICT_SIZE)\00", align 1
@__func__.tdefl_flush_block = private unnamed_addr constant [18 x i8] c"tdefl_flush_block\00", align 1
@.str.37 = private unnamed_addr constant [29 x i8] c"!d->m_output_flush_remaining\00", align 1
@.str.38 = private unnamed_addr constant [27 x i8] c"bits <= ((1U << len) - 1U)\00", align 1
@.str.39 = private unnamed_addr constant [40 x i8] c"d->m_pOutput_buf < d->m_pOutput_buf_end\00", align 1
@__func__.tdefl_start_static_block = private unnamed_addr constant [25 x i8] c"tdefl_start_static_block\00", align 1
@__func__.tdefl_start_dynamic_block = private unnamed_addr constant [26 x i8] c"tdefl_start_dynamic_block\00", align 1
@s_tdefl_packed_code_size_syms_swizzle = internal global [19 x i8] c"\10\11\12\00\08\07\09\06\0A\05\0B\04\0C\03\0D\02\0E\01\0F", align 16
@.str.40 = private unnamed_addr constant [32 x i8] c"code < TDEFL_MAX_HUFF_SYMBOLS_2\00", align 1
@__func__.tdefl_compress_lz_codes = private unnamed_addr constant [24 x i8] c"tdefl_compress_lz_codes\00", align 1
@.str.41 = private unnamed_addr constant [52 x i8] c"d->m_huff_code_sizes[0][s_tdefl_len_sym[match_len]]\00", align 1
@mz_bitmasks = internal constant [17 x i32] [i32 0, i32 1, i32 3, i32 7, i32 15, i32 31, i32 63, i32 127, i32 255, i32 511, i32 1023, i32 2047, i32 4095, i32 8191, i32 16383, i32 32767, i32 65535], align 16
@s_tdefl_len_extra = internal constant [256 x i8] c"\00\00\00\00\00\00\00\00\01\01\01\01\01\01\01\01\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\00", align 16
@s_tdefl_small_dist_extra = internal constant [512 x i8] c"\00\00\00\00\01\01\01\01\02\02\02\02\02\02\02\02\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\04\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07", align 16
@s_tdefl_large_dist_extra = internal constant [128 x i8] c"\00\00\08\08\09\09\09\09\0A\0A\0A\0A\0A\0A\0A\0A\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D", align 16
@.str.42 = private unnamed_addr constant [29 x i8] c"d->m_huff_code_sizes[1][sym]\00", align 1
@.str.43 = private unnamed_addr constant [29 x i8] c"d->m_huff_code_sizes[0][lit]\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @mz_adler32(i64 noundef %0, ptr noundef %1, i64 noundef %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i64, align 8
  store i64 %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  %12 = load i64, ptr %5, align 8
  %13 = and i64 %12, 65535
  %14 = trunc i64 %13 to i32
  store i32 %14, ptr %9, align 4
  %15 = load i64, ptr %5, align 8
  %16 = lshr i64 %15, 16
  %17 = trunc i64 %16 to i32
  store i32 %17, ptr %10, align 4
  %18 = load i64, ptr %7, align 8
  %19 = urem i64 %18, 5552
  store i64 %19, ptr %11, align 8
  %20 = load ptr, ptr %6, align 8
  %21 = icmp ne ptr %20, null
  br i1 %21, label %23, label %22

22:                                               ; preds = %3
  store i64 1, ptr %4, align 8
  br label %145

23:                                               ; preds = %3
  br label %24

24:                                               ; preds = %131, %23
  %25 = load i64, ptr %7, align 8
  %26 = icmp ne i64 %25, 0
  br i1 %26, label %27, label %139

27:                                               ; preds = %24
  store i32 0, ptr %8, align 4
  br label %28

28:                                               ; preds = %107, %27
  %29 = load i32, ptr %8, align 4
  %30 = add i32 %29, 7
  %31 = zext i32 %30 to i64
  %32 = load i64, ptr %11, align 8
  %33 = icmp ult i64 %31, %32
  br i1 %33, label %34, label %112

34:                                               ; preds = %28
  %35 = load ptr, ptr %6, align 8
  %36 = getelementptr inbounds i8, ptr %35, i64 0
  %37 = load i8, ptr %36, align 1
  %38 = zext i8 %37 to i32
  %39 = load i32, ptr %9, align 4
  %40 = add i32 %39, %38
  store i32 %40, ptr %9, align 4
  %41 = load i32, ptr %9, align 4
  %42 = load i32, ptr %10, align 4
  %43 = add i32 %42, %41
  store i32 %43, ptr %10, align 4
  %44 = load ptr, ptr %6, align 8
  %45 = getelementptr inbounds i8, ptr %44, i64 1
  %46 = load i8, ptr %45, align 1
  %47 = zext i8 %46 to i32
  %48 = load i32, ptr %9, align 4
  %49 = add i32 %48, %47
  store i32 %49, ptr %9, align 4
  %50 = load i32, ptr %9, align 4
  %51 = load i32, ptr %10, align 4
  %52 = add i32 %51, %50
  store i32 %52, ptr %10, align 4
  %53 = load ptr, ptr %6, align 8
  %54 = getelementptr inbounds i8, ptr %53, i64 2
  %55 = load i8, ptr %54, align 1
  %56 = zext i8 %55 to i32
  %57 = load i32, ptr %9, align 4
  %58 = add i32 %57, %56
  store i32 %58, ptr %9, align 4
  %59 = load i32, ptr %9, align 4
  %60 = load i32, ptr %10, align 4
  %61 = add i32 %60, %59
  store i32 %61, ptr %10, align 4
  %62 = load ptr, ptr %6, align 8
  %63 = getelementptr inbounds i8, ptr %62, i64 3
  %64 = load i8, ptr %63, align 1
  %65 = zext i8 %64 to i32
  %66 = load i32, ptr %9, align 4
  %67 = add i32 %66, %65
  store i32 %67, ptr %9, align 4
  %68 = load i32, ptr %9, align 4
  %69 = load i32, ptr %10, align 4
  %70 = add i32 %69, %68
  store i32 %70, ptr %10, align 4
  %71 = load ptr, ptr %6, align 8
  %72 = getelementptr inbounds i8, ptr %71, i64 4
  %73 = load i8, ptr %72, align 1
  %74 = zext i8 %73 to i32
  %75 = load i32, ptr %9, align 4
  %76 = add i32 %75, %74
  store i32 %76, ptr %9, align 4
  %77 = load i32, ptr %9, align 4
  %78 = load i32, ptr %10, align 4
  %79 = add i32 %78, %77
  store i32 %79, ptr %10, align 4
  %80 = load ptr, ptr %6, align 8
  %81 = getelementptr inbounds i8, ptr %80, i64 5
  %82 = load i8, ptr %81, align 1
  %83 = zext i8 %82 to i32
  %84 = load i32, ptr %9, align 4
  %85 = add i32 %84, %83
  store i32 %85, ptr %9, align 4
  %86 = load i32, ptr %9, align 4
  %87 = load i32, ptr %10, align 4
  %88 = add i32 %87, %86
  store i32 %88, ptr %10, align 4
  %89 = load ptr, ptr %6, align 8
  %90 = getelementptr inbounds i8, ptr %89, i64 6
  %91 = load i8, ptr %90, align 1
  %92 = zext i8 %91 to i32
  %93 = load i32, ptr %9, align 4
  %94 = add i32 %93, %92
  store i32 %94, ptr %9, align 4
  %95 = load i32, ptr %9, align 4
  %96 = load i32, ptr %10, align 4
  %97 = add i32 %96, %95
  store i32 %97, ptr %10, align 4
  %98 = load ptr, ptr %6, align 8
  %99 = getelementptr inbounds i8, ptr %98, i64 7
  %100 = load i8, ptr %99, align 1
  %101 = zext i8 %100 to i32
  %102 = load i32, ptr %9, align 4
  %103 = add i32 %102, %101
  store i32 %103, ptr %9, align 4
  %104 = load i32, ptr %9, align 4
  %105 = load i32, ptr %10, align 4
  %106 = add i32 %105, %104
  store i32 %106, ptr %10, align 4
  br label %107

107:                                              ; preds = %34
  %108 = load i32, ptr %8, align 4
  %109 = add i32 %108, 8
  store i32 %109, ptr %8, align 4
  %110 = load ptr, ptr %6, align 8
  %111 = getelementptr inbounds i8, ptr %110, i64 8
  store ptr %111, ptr %6, align 8
  br label %28, !llvm.loop !5

112:                                              ; preds = %28
  br label %113

113:                                              ; preds = %128, %112
  %114 = load i32, ptr %8, align 4
  %115 = zext i32 %114 to i64
  %116 = load i64, ptr %11, align 8
  %117 = icmp ult i64 %115, %116
  br i1 %117, label %118, label %131

118:                                              ; preds = %113
  %119 = load ptr, ptr %6, align 8
  %120 = getelementptr inbounds i8, ptr %119, i32 1
  store ptr %120, ptr %6, align 8
  %121 = load i8, ptr %119, align 1
  %122 = zext i8 %121 to i32
  %123 = load i32, ptr %9, align 4
  %124 = add i32 %123, %122
  store i32 %124, ptr %9, align 4
  %125 = load i32, ptr %9, align 4
  %126 = load i32, ptr %10, align 4
  %127 = add i32 %126, %125
  store i32 %127, ptr %10, align 4
  br label %128

128:                                              ; preds = %118
  %129 = load i32, ptr %8, align 4
  %130 = add i32 %129, 1
  store i32 %130, ptr %8, align 4
  br label %113, !llvm.loop !7

131:                                              ; preds = %113
  %132 = load i32, ptr %9, align 4
  %133 = urem i32 %132, 65521
  store i32 %133, ptr %9, align 4
  %134 = load i32, ptr %10, align 4
  %135 = urem i32 %134, 65521
  store i32 %135, ptr %10, align 4
  %136 = load i64, ptr %11, align 8
  %137 = load i64, ptr %7, align 8
  %138 = sub i64 %137, %136
  store i64 %138, ptr %7, align 8
  store i64 5552, ptr %11, align 8
  br label %24, !llvm.loop !8

139:                                              ; preds = %24
  %140 = load i32, ptr %10, align 4
  %141 = shl i32 %140, 16
  %142 = load i32, ptr %9, align 4
  %143 = add i32 %141, %142
  %144 = zext i32 %143 to i64
  store i64 %144, ptr %4, align 8
  br label %145

145:                                              ; preds = %139, %22
  %146 = load i64, ptr %4, align 8
  ret i64 %146
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @mz_crc32(i64 noundef %0, ptr noundef %1, i64 noundef %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8, align 1
  store i64 %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  %9 = load ptr, ptr %6, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %12, label %11

11:                                               ; preds = %3
  store i64 0, ptr %4, align 8
  br label %52

12:                                               ; preds = %3
  %13 = load i64, ptr %5, align 8
  %14 = xor i64 %13, -1
  store i64 %14, ptr %5, align 8
  br label %15

15:                                               ; preds = %19, %12
  %16 = load i64, ptr %7, align 8
  %17 = add i64 %16, -1
  store i64 %17, ptr %7, align 8
  %18 = icmp ne i64 %16, 0
  br i1 %18, label %19, label %49

19:                                               ; preds = %15
  %20 = load ptr, ptr %6, align 8
  %21 = getelementptr inbounds i8, ptr %20, i32 1
  store ptr %21, ptr %6, align 8
  %22 = load i8, ptr %20, align 1
  store i8 %22, ptr %8, align 1
  %23 = load i64, ptr %5, align 8
  %24 = lshr i64 %23, 4
  %25 = load i64, ptr %5, align 8
  %26 = and i64 %25, 15
  %27 = load i8, ptr %8, align 1
  %28 = zext i8 %27 to i32
  %29 = and i32 %28, 15
  %30 = sext i32 %29 to i64
  %31 = xor i64 %26, %30
  %32 = getelementptr inbounds [16 x i32], ptr @mz_crc32.s_crc32, i64 0, i64 %31
  %33 = load i32, ptr %32, align 4
  %34 = zext i32 %33 to i64
  %35 = xor i64 %24, %34
  store i64 %35, ptr %5, align 8
  %36 = load i64, ptr %5, align 8
  %37 = lshr i64 %36, 4
  %38 = load i64, ptr %5, align 8
  %39 = and i64 %38, 15
  %40 = load i8, ptr %8, align 1
  %41 = zext i8 %40 to i32
  %42 = ashr i32 %41, 4
  %43 = sext i32 %42 to i64
  %44 = xor i64 %39, %43
  %45 = getelementptr inbounds [16 x i32], ptr @mz_crc32.s_crc32, i64 0, i64 %44
  %46 = load i32, ptr %45, align 4
  %47 = zext i32 %46 to i64
  %48 = xor i64 %37, %47
  store i64 %48, ptr %5, align 8
  br label %15, !llvm.loop !9

49:                                               ; preds = %15
  %50 = load i64, ptr %5, align 8
  %51 = xor i64 %50, -1
  store i64 %51, ptr %4, align 8
  br label %52

52:                                               ; preds = %49, %11
  %53 = load i64, ptr %4, align 8
  ret i64 %53
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define ptr @mz_version() #0 {
  ret ptr @.str
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_deflateInit(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = load i32, ptr %4, align 4
  %7 = call i32 @mz_deflateInit2(ptr noundef %5, i32 noundef %6, i32 noundef 8, i32 noundef 15, i32 noundef 9, i32 noundef 0)
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_deflateInit2(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  store ptr %0, ptr %8, align 8
  store i32 %1, ptr %9, align 4
  store i32 %2, ptr %10, align 4
  store i32 %3, ptr %11, align 4
  store i32 %4, ptr %12, align 4
  store i32 %5, ptr %13, align 4
  %16 = load i32, ptr %9, align 4
  %17 = load i32, ptr %11, align 4
  %18 = load i32, ptr %13, align 4
  %19 = call i32 @tdefl_create_comp_flags_from_zip_params(i32 noundef %16, i32 noundef %17, i32 noundef %18)
  %20 = or i32 24576, %19
  store i32 %20, ptr %15, align 4
  %21 = load ptr, ptr %8, align 8
  %22 = icmp ne ptr %21, null
  br i1 %22, label %24, label %23

23:                                               ; preds = %6
  store i32 -2, ptr %7, align 4
  br label %94

24:                                               ; preds = %6
  %25 = load i32, ptr %10, align 4
  %26 = icmp ne i32 %25, 8
  br i1 %26, label %40, label %27

27:                                               ; preds = %24
  %28 = load i32, ptr %12, align 4
  %29 = icmp slt i32 %28, 1
  br i1 %29, label %40, label %30

30:                                               ; preds = %27
  %31 = load i32, ptr %12, align 4
  %32 = icmp sgt i32 %31, 9
  br i1 %32, label %40, label %33

33:                                               ; preds = %30
  %34 = load i32, ptr %11, align 4
  %35 = icmp ne i32 %34, 15
  br i1 %35, label %36, label %41

36:                                               ; preds = %33
  %37 = load i32, ptr %11, align 4
  %38 = sub nsw i32 0, %37
  %39 = icmp ne i32 %38, 15
  br i1 %39, label %40, label %41

40:                                               ; preds = %36, %30, %27, %24
  store i32 -10000, ptr %7, align 4
  br label %94

41:                                               ; preds = %36, %33
  %42 = load ptr, ptr %8, align 8
  %43 = getelementptr inbounds %struct.mz_stream_s, ptr %42, i32 0, i32 11
  store i32 0, ptr %43, align 8
  %44 = load ptr, ptr %8, align 8
  %45 = getelementptr inbounds %struct.mz_stream_s, ptr %44, i32 0, i32 12
  store i64 1, ptr %45, align 8
  %46 = load ptr, ptr %8, align 8
  %47 = getelementptr inbounds %struct.mz_stream_s, ptr %46, i32 0, i32 13
  store i64 0, ptr %47, align 8
  %48 = load ptr, ptr %8, align 8
  %49 = getelementptr inbounds %struct.mz_stream_s, ptr %48, i32 0, i32 6
  store ptr null, ptr %49, align 8
  %50 = load ptr, ptr %8, align 8
  %51 = getelementptr inbounds %struct.mz_stream_s, ptr %50, i32 0, i32 14
  store i64 0, ptr %51, align 8
  %52 = load ptr, ptr %8, align 8
  %53 = getelementptr inbounds %struct.mz_stream_s, ptr %52, i32 0, i32 2
  store i64 0, ptr %53, align 8
  %54 = load ptr, ptr %8, align 8
  %55 = getelementptr inbounds %struct.mz_stream_s, ptr %54, i32 0, i32 5
  store i64 0, ptr %55, align 8
  %56 = load ptr, ptr %8, align 8
  %57 = getelementptr inbounds %struct.mz_stream_s, ptr %56, i32 0, i32 8
  %58 = load ptr, ptr %57, align 8
  %59 = icmp ne ptr %58, null
  br i1 %59, label %63, label %60

60:                                               ; preds = %41
  %61 = load ptr, ptr %8, align 8
  %62 = getelementptr inbounds %struct.mz_stream_s, ptr %61, i32 0, i32 8
  store ptr @def_alloc_func, ptr %62, align 8
  br label %63

63:                                               ; preds = %60, %41
  %64 = load ptr, ptr %8, align 8
  %65 = getelementptr inbounds %struct.mz_stream_s, ptr %64, i32 0, i32 9
  %66 = load ptr, ptr %65, align 8
  %67 = icmp ne ptr %66, null
  br i1 %67, label %71, label %68

68:                                               ; preds = %63
  %69 = load ptr, ptr %8, align 8
  %70 = getelementptr inbounds %struct.mz_stream_s, ptr %69, i32 0, i32 9
  store ptr @def_free_func, ptr %70, align 8
  br label %71

71:                                               ; preds = %68, %63
  %72 = load ptr, ptr %8, align 8
  %73 = getelementptr inbounds %struct.mz_stream_s, ptr %72, i32 0, i32 8
  %74 = load ptr, ptr %73, align 8
  %75 = load ptr, ptr %8, align 8
  %76 = getelementptr inbounds %struct.mz_stream_s, ptr %75, i32 0, i32 10
  %77 = load ptr, ptr %76, align 8
  %78 = call ptr %74(ptr noundef %77, i64 noundef 1, i64 noundef 319360)
  store ptr %78, ptr %14, align 8
  %79 = load ptr, ptr %14, align 8
  %80 = icmp ne ptr %79, null
  br i1 %80, label %82, label %81

81:                                               ; preds = %71
  store i32 -4, ptr %7, align 4
  br label %94

82:                                               ; preds = %71
  %83 = load ptr, ptr %14, align 8
  %84 = load ptr, ptr %8, align 8
  %85 = getelementptr inbounds %struct.mz_stream_s, ptr %84, i32 0, i32 7
  store ptr %83, ptr %85, align 8
  %86 = load ptr, ptr %14, align 8
  %87 = load i32, ptr %15, align 4
  %88 = call i32 @tdefl_init(ptr noundef %86, ptr noundef null, ptr noundef null, i32 noundef %87)
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %90, label %93

90:                                               ; preds = %82
  %91 = load ptr, ptr %8, align 8
  %92 = call i32 @mz_deflateEnd(ptr noundef %91)
  store i32 -10000, ptr %7, align 4
  br label %94

93:                                               ; preds = %82
  store i32 0, ptr %7, align 4
  br label %94

94:                                               ; preds = %93, %90, %81, %40, %23
  %95 = load i32, ptr %7, align 4
  ret i32 %95
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_create_comp_flags_from_zip_params(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %4, align 4
  %9 = icmp sge i32 %8, 0
  br i1 %9, label %10, label %18

10:                                               ; preds = %3
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 10, %11
  br i1 %12, label %13, label %14

13:                                               ; preds = %10
  br label %16

14:                                               ; preds = %10
  %15 = load i32, ptr %4, align 4
  br label %16

16:                                               ; preds = %14, %13
  %17 = phi i32 [ 10, %13 ], [ %15, %14 ]
  br label %19

18:                                               ; preds = %3
  br label %19

19:                                               ; preds = %18, %16
  %20 = phi i32 [ %17, %16 ], [ 6, %18 ]
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [11 x i32], ptr @s_tdefl_num_probes, i64 0, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = load i32, ptr %4, align 4
  %25 = icmp sle i32 %24, 3
  %26 = zext i1 %25 to i64
  %27 = select i1 %25, i32 32768, i32 0
  %28 = or i32 %23, %27
  store i32 %28, ptr %7, align 4
  %29 = load i32, ptr %5, align 4
  %30 = icmp sgt i32 %29, 0
  br i1 %30, label %31, label %34

31:                                               ; preds = %19
  %32 = load i32, ptr %7, align 4
  %33 = or i32 %32, 4096
  store i32 %33, ptr %7, align 4
  br label %34

34:                                               ; preds = %31, %19
  %35 = load i32, ptr %4, align 4
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %40, label %37

37:                                               ; preds = %34
  %38 = load i32, ptr %7, align 4
  %39 = or i32 %38, 1048576
  store i32 %39, ptr %7, align 4
  br label %68

40:                                               ; preds = %34
  %41 = load i32, ptr %6, align 4
  %42 = icmp eq i32 %41, 1
  br i1 %42, label %43, label %46

43:                                               ; preds = %40
  %44 = load i32, ptr %7, align 4
  %45 = or i32 %44, 262144
  store i32 %45, ptr %7, align 4
  br label %67

46:                                               ; preds = %40
  %47 = load i32, ptr %6, align 4
  %48 = icmp eq i32 %47, 2
  br i1 %48, label %49, label %52

49:                                               ; preds = %46
  %50 = load i32, ptr %7, align 4
  %51 = and i32 %50, -4096
  store i32 %51, ptr %7, align 4
  br label %66

52:                                               ; preds = %46
  %53 = load i32, ptr %6, align 4
  %54 = icmp eq i32 %53, 4
  br i1 %54, label %55, label %58

55:                                               ; preds = %52
  %56 = load i32, ptr %7, align 4
  %57 = or i32 %56, 524288
  store i32 %57, ptr %7, align 4
  br label %65

58:                                               ; preds = %52
  %59 = load i32, ptr %6, align 4
  %60 = icmp eq i32 %59, 3
  br i1 %60, label %61, label %64

61:                                               ; preds = %58
  %62 = load i32, ptr %7, align 4
  %63 = or i32 %62, 131072
  store i32 %63, ptr %7, align 4
  br label %64

64:                                               ; preds = %61, %58
  br label %65

65:                                               ; preds = %64, %55
  br label %66

66:                                               ; preds = %65, %49
  br label %67

67:                                               ; preds = %66, %43
  br label %68

68:                                               ; preds = %67, %37
  %69 = load i32, ptr %7, align 4
  ret i32 %69
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal ptr @def_alloc_func(ptr noundef %0, i64 noundef %1, i64 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 %2, ptr %6, align 8
  %7 = load ptr, ptr %4, align 8
  %8 = load i64, ptr %5, align 8
  %9 = load i64, ptr %6, align 8
  %10 = mul i64 %8, %9
  %11 = call ptr @malloc(i64 noundef %10) #11
  ret ptr %11
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @def_free_func(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_init(ptr noundef %0, ptr noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store i32 %3, ptr %8, align 4
  %9 = load ptr, ptr %6, align 8
  %10 = load ptr, ptr %5, align 8
  %11 = getelementptr inbounds %struct.tdefl_compressor, ptr %10, i32 0, i32 0
  store ptr %9, ptr %11, align 8
  %12 = load ptr, ptr %7, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = getelementptr inbounds %struct.tdefl_compressor, ptr %13, i32 0, i32 1
  store ptr %12, ptr %14, align 8
  %15 = load i32, ptr %8, align 4
  %16 = load ptr, ptr %5, align 8
  %17 = getelementptr inbounds %struct.tdefl_compressor, ptr %16, i32 0, i32 2
  store i32 %15, ptr %17, align 8
  %18 = load i32, ptr %8, align 4
  %19 = and i32 %18, 4095
  %20 = add nsw i32 %19, 2
  %21 = sdiv i32 %20, 3
  %22 = add nsw i32 1, %21
  %23 = load ptr, ptr %5, align 8
  %24 = getelementptr inbounds %struct.tdefl_compressor, ptr %23, i32 0, i32 3
  %25 = getelementptr inbounds [2 x i32], ptr %24, i64 0, i64 0
  store i32 %22, ptr %25, align 4
  %26 = load i32, ptr %8, align 4
  %27 = and i32 %26, 32768
  %28 = icmp ne i32 %27, 0
  %29 = zext i1 %28 to i32
  %30 = load ptr, ptr %5, align 8
  %31 = getelementptr inbounds %struct.tdefl_compressor, ptr %30, i32 0, i32 4
  store i32 %29, ptr %31, align 4
  %32 = load i32, ptr %8, align 4
  %33 = and i32 %32, 4095
  %34 = ashr i32 %33, 2
  %35 = add nsw i32 %34, 2
  %36 = sdiv i32 %35, 3
  %37 = add nsw i32 1, %36
  %38 = load ptr, ptr %5, align 8
  %39 = getelementptr inbounds %struct.tdefl_compressor, ptr %38, i32 0, i32 3
  %40 = getelementptr inbounds [2 x i32], ptr %39, i64 0, i64 1
  store i32 %37, ptr %40, align 4
  %41 = load i32, ptr %8, align 4
  %42 = and i32 %41, 65536
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %51, label %44

44:                                               ; preds = %4
  %45 = load ptr, ptr %5, align 8
  %46 = getelementptr inbounds %struct.tdefl_compressor, ptr %45, i32 0, i32 42
  %47 = load ptr, ptr %5, align 8
  %48 = getelementptr inbounds %struct.tdefl_compressor, ptr %47, i32 0, i32 42
  %49 = call i64 @llvm.objectsize.i64.p0(ptr %48, i1 false, i1 true, i1 false)
  %50 = call ptr @__memset_chk(ptr noundef %46, i32 noundef 0, i64 noundef 65536, i64 noundef %49) #12
  br label %51

51:                                               ; preds = %44, %4
  %52 = load ptr, ptr %5, align 8
  %53 = getelementptr inbounds %struct.tdefl_compressor, ptr %52, i32 0, i32 17
  store i32 0, ptr %53, align 4
  %54 = load ptr, ptr %5, align 8
  %55 = getelementptr inbounds %struct.tdefl_compressor, ptr %54, i32 0, i32 16
  store i32 0, ptr %55, align 8
  %56 = load ptr, ptr %5, align 8
  %57 = getelementptr inbounds %struct.tdefl_compressor, ptr %56, i32 0, i32 15
  store i32 0, ptr %57, align 4
  %58 = load ptr, ptr %5, align 8
  %59 = getelementptr inbounds %struct.tdefl_compressor, ptr %58, i32 0, i32 9
  store i32 0, ptr %59, align 8
  %60 = load ptr, ptr %5, align 8
  %61 = getelementptr inbounds %struct.tdefl_compressor, ptr %60, i32 0, i32 8
  store i32 0, ptr %61, align 4
  %62 = load ptr, ptr %5, align 8
  %63 = getelementptr inbounds %struct.tdefl_compressor, ptr %62, i32 0, i32 7
  store i32 0, ptr %63, align 8
  %64 = load ptr, ptr %5, align 8
  %65 = getelementptr inbounds %struct.tdefl_compressor, ptr %64, i32 0, i32 26
  store i32 0, ptr %65, align 8
  %66 = load ptr, ptr %5, align 8
  %67 = getelementptr inbounds %struct.tdefl_compressor, ptr %66, i32 0, i32 18
  store i32 0, ptr %67, align 8
  %68 = load ptr, ptr %5, align 8
  %69 = getelementptr inbounds %struct.tdefl_compressor, ptr %68, i32 0, i32 25
  store i32 0, ptr %69, align 4
  %70 = load ptr, ptr %5, align 8
  %71 = getelementptr inbounds %struct.tdefl_compressor, ptr %70, i32 0, i32 24
  store i32 0, ptr %71, align 8
  %72 = load ptr, ptr %5, align 8
  %73 = getelementptr inbounds %struct.tdefl_compressor, ptr %72, i32 0, i32 23
  store i32 0, ptr %73, align 4
  %74 = load ptr, ptr %5, align 8
  %75 = getelementptr inbounds %struct.tdefl_compressor, ptr %74, i32 0, i32 22
  store i32 0, ptr %75, align 8
  %76 = load ptr, ptr %5, align 8
  %77 = getelementptr inbounds %struct.tdefl_compressor, ptr %76, i32 0, i32 40
  %78 = getelementptr inbounds [65536 x i8], ptr %77, i64 0, i64 0
  %79 = getelementptr inbounds i8, ptr %78, i64 1
  %80 = load ptr, ptr %5, align 8
  %81 = getelementptr inbounds %struct.tdefl_compressor, ptr %80, i32 0, i32 10
  store ptr %79, ptr %81, align 8
  %82 = load ptr, ptr %5, align 8
  %83 = getelementptr inbounds %struct.tdefl_compressor, ptr %82, i32 0, i32 40
  %84 = getelementptr inbounds [65536 x i8], ptr %83, i64 0, i64 0
  %85 = load ptr, ptr %5, align 8
  %86 = getelementptr inbounds %struct.tdefl_compressor, ptr %85, i32 0, i32 11
  store ptr %84, ptr %86, align 8
  %87 = load ptr, ptr %5, align 8
  %88 = getelementptr inbounds %struct.tdefl_compressor, ptr %87, i32 0, i32 14
  store i32 8, ptr %88, align 8
  %89 = load ptr, ptr %5, align 8
  %90 = getelementptr inbounds %struct.tdefl_compressor, ptr %89, i32 0, i32 43
  %91 = getelementptr inbounds [85196 x i8], ptr %90, i64 0, i64 0
  %92 = load ptr, ptr %5, align 8
  %93 = getelementptr inbounds %struct.tdefl_compressor, ptr %92, i32 0, i32 12
  store ptr %91, ptr %93, align 8
  %94 = load ptr, ptr %5, align 8
  %95 = getelementptr inbounds %struct.tdefl_compressor, ptr %94, i32 0, i32 43
  %96 = getelementptr inbounds [85196 x i8], ptr %95, i64 0, i64 0
  %97 = load ptr, ptr %5, align 8
  %98 = getelementptr inbounds %struct.tdefl_compressor, ptr %97, i32 0, i32 13
  store ptr %96, ptr %98, align 8
  %99 = load ptr, ptr %5, align 8
  %100 = getelementptr inbounds %struct.tdefl_compressor, ptr %99, i32 0, i32 27
  store i32 0, ptr %100, align 4
  %101 = load ptr, ptr %5, align 8
  %102 = getelementptr inbounds %struct.tdefl_compressor, ptr %101, i32 0, i32 21
  store i32 0, ptr %102, align 4
  %103 = load ptr, ptr %5, align 8
  %104 = getelementptr inbounds %struct.tdefl_compressor, ptr %103, i32 0, i32 20
  store i32 0, ptr %104, align 8
  %105 = load ptr, ptr %5, align 8
  %106 = getelementptr inbounds %struct.tdefl_compressor, ptr %105, i32 0, i32 19
  store i32 0, ptr %106, align 4
  %107 = load ptr, ptr %5, align 8
  %108 = getelementptr inbounds %struct.tdefl_compressor, ptr %107, i32 0, i32 5
  store i32 1, ptr %108, align 8
  %109 = load ptr, ptr %5, align 8
  %110 = getelementptr inbounds %struct.tdefl_compressor, ptr %109, i32 0, i32 6
  store i32 1, ptr %110, align 4
  %111 = load ptr, ptr %5, align 8
  %112 = getelementptr inbounds %struct.tdefl_compressor, ptr %111, i32 0, i32 28
  store ptr null, ptr %112, align 8
  %113 = load ptr, ptr %5, align 8
  %114 = getelementptr inbounds %struct.tdefl_compressor, ptr %113, i32 0, i32 29
  store ptr null, ptr %114, align 8
  %115 = load ptr, ptr %5, align 8
  %116 = getelementptr inbounds %struct.tdefl_compressor, ptr %115, i32 0, i32 30
  store ptr null, ptr %116, align 8
  %117 = load ptr, ptr %5, align 8
  %118 = getelementptr inbounds %struct.tdefl_compressor, ptr %117, i32 0, i32 31
  store ptr null, ptr %118, align 8
  %119 = load ptr, ptr %5, align 8
  %120 = getelementptr inbounds %struct.tdefl_compressor, ptr %119, i32 0, i32 32
  store i32 0, ptr %120, align 8
  %121 = load ptr, ptr %5, align 8
  %122 = getelementptr inbounds %struct.tdefl_compressor, ptr %121, i32 0, i32 33
  store ptr null, ptr %122, align 8
  %123 = load ptr, ptr %5, align 8
  %124 = getelementptr inbounds %struct.tdefl_compressor, ptr %123, i32 0, i32 34
  store i64 0, ptr %124, align 8
  %125 = load ptr, ptr %5, align 8
  %126 = getelementptr inbounds %struct.tdefl_compressor, ptr %125, i32 0, i32 35
  store i64 0, ptr %126, align 8
  %127 = load ptr, ptr %5, align 8
  %128 = getelementptr inbounds %struct.tdefl_compressor, ptr %127, i32 0, i32 37
  %129 = getelementptr inbounds [3 x [288 x i32]], ptr %128, i64 0, i64 0
  %130 = getelementptr inbounds [288 x i32], ptr %129, i64 0, i64 0
  %131 = load ptr, ptr %5, align 8
  %132 = getelementptr inbounds %struct.tdefl_compressor, ptr %131, i32 0, i32 37
  %133 = getelementptr inbounds [3 x [288 x i32]], ptr %132, i64 0, i64 0
  %134 = getelementptr inbounds [288 x i32], ptr %133, i64 0, i64 0
  %135 = call i64 @llvm.objectsize.i64.p0(ptr %134, i1 false, i1 true, i1 false)
  %136 = call ptr @__memset_chk(ptr noundef %130, i32 noundef 0, i64 noundef 576, i64 noundef %135) #12
  %137 = load ptr, ptr %5, align 8
  %138 = getelementptr inbounds %struct.tdefl_compressor, ptr %137, i32 0, i32 37
  %139 = getelementptr inbounds [3 x [288 x i32]], ptr %138, i64 0, i64 1
  %140 = getelementptr inbounds [288 x i32], ptr %139, i64 0, i64 0
  %141 = load ptr, ptr %5, align 8
  %142 = getelementptr inbounds %struct.tdefl_compressor, ptr %141, i32 0, i32 37
  %143 = getelementptr inbounds [3 x [288 x i32]], ptr %142, i64 0, i64 1
  %144 = getelementptr inbounds [288 x i32], ptr %143, i64 0, i64 0
  %145 = call i64 @llvm.objectsize.i64.p0(ptr %144, i1 false, i1 true, i1 false)
  %146 = call ptr @__memset_chk(ptr noundef %140, i32 noundef 0, i64 noundef 64, i64 noundef %145) #12
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_deflateEnd(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  store i32 -2, ptr %2, align 4
  br label %25

7:                                                ; preds = %1
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 7
  %10 = load ptr, ptr %9, align 8
  %11 = icmp ne ptr %10, null
  br i1 %11, label %12, label %24

12:                                               ; preds = %7
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 9
  %15 = load ptr, ptr %14, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.mz_stream_s, ptr %16, i32 0, i32 10
  %18 = load ptr, ptr %17, align 8
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.mz_stream_s, ptr %19, i32 0, i32 7
  %21 = load ptr, ptr %20, align 8
  call void %15(ptr noundef %18, ptr noundef %21)
  %22 = load ptr, ptr %3, align 8
  %23 = getelementptr inbounds %struct.mz_stream_s, ptr %22, i32 0, i32 7
  store ptr null, ptr %23, align 8
  br label %24

24:                                               ; preds = %12, %7
  store i32 0, ptr %2, align 4
  br label %25

25:                                               ; preds = %24, %6
  %26 = load i32, ptr %2, align 4
  ret i32 %26
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_deflateReset(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %6, label %21

6:                                                ; preds = %1
  %7 = load ptr, ptr %3, align 8
  %8 = getelementptr inbounds %struct.mz_stream_s, ptr %7, i32 0, i32 7
  %9 = load ptr, ptr %8, align 8
  %10 = icmp ne ptr %9, null
  br i1 %10, label %11, label %21

11:                                               ; preds = %6
  %12 = load ptr, ptr %3, align 8
  %13 = getelementptr inbounds %struct.mz_stream_s, ptr %12, i32 0, i32 8
  %14 = load ptr, ptr %13, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %16, label %21

16:                                               ; preds = %11
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.mz_stream_s, ptr %17, i32 0, i32 9
  %19 = load ptr, ptr %18, align 8
  %20 = icmp ne ptr %19, null
  br i1 %20, label %22, label %21

21:                                               ; preds = %16, %11, %6, %1
  store i32 -2, ptr %2, align 4
  br label %36

22:                                               ; preds = %16
  %23 = load ptr, ptr %3, align 8
  %24 = getelementptr inbounds %struct.mz_stream_s, ptr %23, i32 0, i32 5
  store i64 0, ptr %24, align 8
  %25 = load ptr, ptr %3, align 8
  %26 = getelementptr inbounds %struct.mz_stream_s, ptr %25, i32 0, i32 2
  store i64 0, ptr %26, align 8
  %27 = load ptr, ptr %3, align 8
  %28 = getelementptr inbounds %struct.mz_stream_s, ptr %27, i32 0, i32 7
  %29 = load ptr, ptr %28, align 8
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.mz_stream_s, ptr %30, i32 0, i32 7
  %32 = load ptr, ptr %31, align 8
  %33 = getelementptr inbounds %struct.tdefl_compressor, ptr %32, i32 0, i32 2
  %34 = load i32, ptr %33, align 8
  %35 = call i32 @tdefl_init(ptr noundef %29, ptr noundef null, ptr noundef null, i32 noundef %34)
  store i32 0, ptr %2, align 4
  br label %36

36:                                               ; preds = %22, %21
  %37 = load i32, ptr %2, align 4
  ret i32 %37
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_deflate(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 0, ptr %10, align 4
  %12 = load ptr, ptr %4, align 8
  %13 = icmp ne ptr %12, null
  br i1 %13, label %14, label %30

14:                                               ; preds = %2
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds %struct.mz_stream_s, ptr %15, i32 0, i32 7
  %17 = load ptr, ptr %16, align 8
  %18 = icmp ne ptr %17, null
  br i1 %18, label %19, label %30

19:                                               ; preds = %14
  %20 = load i32, ptr %5, align 4
  %21 = icmp slt i32 %20, 0
  br i1 %21, label %30, label %22

22:                                               ; preds = %19
  %23 = load i32, ptr %5, align 4
  %24 = icmp sgt i32 %23, 4
  br i1 %24, label %30, label %25

25:                                               ; preds = %22
  %26 = load ptr, ptr %4, align 8
  %27 = getelementptr inbounds %struct.mz_stream_s, ptr %26, i32 0, i32 3
  %28 = load ptr, ptr %27, align 8
  %29 = icmp ne ptr %28, null
  br i1 %29, label %31, label %30

30:                                               ; preds = %25, %22, %19, %14, %2
  store i32 -2, ptr %3, align 4
  br label %178

31:                                               ; preds = %25
  %32 = load ptr, ptr %4, align 8
  %33 = getelementptr inbounds %struct.mz_stream_s, ptr %32, i32 0, i32 4
  %34 = load i32, ptr %33, align 8
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %37, label %36

36:                                               ; preds = %31
  store i32 -5, ptr %3, align 4
  br label %178

37:                                               ; preds = %31
  %38 = load i32, ptr %5, align 4
  %39 = icmp eq i32 %38, 1
  br i1 %39, label %40, label %41

40:                                               ; preds = %37
  store i32 2, ptr %5, align 4
  br label %41

41:                                               ; preds = %40, %37
  %42 = load ptr, ptr %4, align 8
  %43 = getelementptr inbounds %struct.mz_stream_s, ptr %42, i32 0, i32 7
  %44 = load ptr, ptr %43, align 8
  %45 = getelementptr inbounds %struct.tdefl_compressor, ptr %44, i32 0, i32 27
  %46 = load i32, ptr %45, align 4
  %47 = icmp eq i32 %46, 1
  br i1 %47, label %48, label %53

48:                                               ; preds = %41
  %49 = load i32, ptr %5, align 4
  %50 = icmp eq i32 %49, 4
  %51 = zext i1 %50 to i64
  %52 = select i1 %50, i32 1, i32 -5
  store i32 %52, ptr %3, align 4
  br label %178

53:                                               ; preds = %41
  %54 = load ptr, ptr %4, align 8
  %55 = getelementptr inbounds %struct.mz_stream_s, ptr %54, i32 0, i32 2
  %56 = load i64, ptr %55, align 8
  store i64 %56, ptr %8, align 8
  %57 = load ptr, ptr %4, align 8
  %58 = getelementptr inbounds %struct.mz_stream_s, ptr %57, i32 0, i32 5
  %59 = load i64, ptr %58, align 8
  store i64 %59, ptr %9, align 8
  br label %60

60:                                               ; preds = %175, %53
  %61 = load ptr, ptr %4, align 8
  %62 = getelementptr inbounds %struct.mz_stream_s, ptr %61, i32 0, i32 1
  %63 = load i32, ptr %62, align 8
  %64 = zext i32 %63 to i64
  store i64 %64, ptr %6, align 8
  %65 = load ptr, ptr %4, align 8
  %66 = getelementptr inbounds %struct.mz_stream_s, ptr %65, i32 0, i32 4
  %67 = load i32, ptr %66, align 8
  %68 = zext i32 %67 to i64
  store i64 %68, ptr %7, align 8
  %69 = load ptr, ptr %4, align 8
  %70 = getelementptr inbounds %struct.mz_stream_s, ptr %69, i32 0, i32 7
  %71 = load ptr, ptr %70, align 8
  %72 = load ptr, ptr %4, align 8
  %73 = getelementptr inbounds %struct.mz_stream_s, ptr %72, i32 0, i32 0
  %74 = load ptr, ptr %73, align 8
  %75 = load ptr, ptr %4, align 8
  %76 = getelementptr inbounds %struct.mz_stream_s, ptr %75, i32 0, i32 3
  %77 = load ptr, ptr %76, align 8
  %78 = load i32, ptr %5, align 4
  %79 = call i32 @tdefl_compress(ptr noundef %71, ptr noundef %74, ptr noundef %6, ptr noundef %77, ptr noundef %7, i32 noundef %78)
  store i32 %79, ptr %11, align 4
  %80 = load i64, ptr %6, align 8
  %81 = trunc i64 %80 to i32
  %82 = load ptr, ptr %4, align 8
  %83 = getelementptr inbounds %struct.mz_stream_s, ptr %82, i32 0, i32 0
  %84 = load ptr, ptr %83, align 8
  %85 = zext i32 %81 to i64
  %86 = getelementptr inbounds i8, ptr %84, i64 %85
  store ptr %86, ptr %83, align 8
  %87 = load i64, ptr %6, align 8
  %88 = trunc i64 %87 to i32
  %89 = load ptr, ptr %4, align 8
  %90 = getelementptr inbounds %struct.mz_stream_s, ptr %89, i32 0, i32 1
  %91 = load i32, ptr %90, align 8
  %92 = sub i32 %91, %88
  store i32 %92, ptr %90, align 8
  %93 = load i64, ptr %6, align 8
  %94 = trunc i64 %93 to i32
  %95 = zext i32 %94 to i64
  %96 = load ptr, ptr %4, align 8
  %97 = getelementptr inbounds %struct.mz_stream_s, ptr %96, i32 0, i32 2
  %98 = load i64, ptr %97, align 8
  %99 = add i64 %98, %95
  store i64 %99, ptr %97, align 8
  %100 = load ptr, ptr %4, align 8
  %101 = getelementptr inbounds %struct.mz_stream_s, ptr %100, i32 0, i32 7
  %102 = load ptr, ptr %101, align 8
  %103 = call i32 @tdefl_get_adler32(ptr noundef %102)
  %104 = zext i32 %103 to i64
  %105 = load ptr, ptr %4, align 8
  %106 = getelementptr inbounds %struct.mz_stream_s, ptr %105, i32 0, i32 12
  store i64 %104, ptr %106, align 8
  %107 = load ptr, ptr %4, align 8
  %108 = getelementptr inbounds %struct.mz_stream_s, ptr %107, i32 0, i32 7
  %109 = load ptr, ptr %108, align 8
  %110 = call i32 @tdefl_get_crc32(ptr noundef %109)
  %111 = zext i32 %110 to i64
  %112 = load ptr, ptr %4, align 8
  %113 = getelementptr inbounds %struct.mz_stream_s, ptr %112, i32 0, i32 13
  store i64 %111, ptr %113, align 8
  %114 = load i64, ptr %7, align 8
  %115 = trunc i64 %114 to i32
  %116 = load ptr, ptr %4, align 8
  %117 = getelementptr inbounds %struct.mz_stream_s, ptr %116, i32 0, i32 3
  %118 = load ptr, ptr %117, align 8
  %119 = zext i32 %115 to i64
  %120 = getelementptr inbounds i8, ptr %118, i64 %119
  store ptr %120, ptr %117, align 8
  %121 = load i64, ptr %7, align 8
  %122 = trunc i64 %121 to i32
  %123 = load ptr, ptr %4, align 8
  %124 = getelementptr inbounds %struct.mz_stream_s, ptr %123, i32 0, i32 4
  %125 = load i32, ptr %124, align 8
  %126 = sub i32 %125, %122
  store i32 %126, ptr %124, align 8
  %127 = load i64, ptr %7, align 8
  %128 = trunc i64 %127 to i32
  %129 = zext i32 %128 to i64
  %130 = load ptr, ptr %4, align 8
  %131 = getelementptr inbounds %struct.mz_stream_s, ptr %130, i32 0, i32 5
  %132 = load i64, ptr %131, align 8
  %133 = add i64 %132, %129
  store i64 %133, ptr %131, align 8
  %134 = load i32, ptr %11, align 4
  %135 = icmp slt i32 %134, 0
  br i1 %135, label %136, label %137

136:                                              ; preds = %60
  store i32 -2, ptr %10, align 4
  br label %176

137:                                              ; preds = %60
  %138 = load i32, ptr %11, align 4
  %139 = icmp eq i32 %138, 1
  br i1 %139, label %140, label %141

140:                                              ; preds = %137
  store i32 1, ptr %10, align 4
  br label %176

141:                                              ; preds = %137
  %142 = load ptr, ptr %4, align 8
  %143 = getelementptr inbounds %struct.mz_stream_s, ptr %142, i32 0, i32 4
  %144 = load i32, ptr %143, align 8
  %145 = icmp ne i32 %144, 0
  br i1 %145, label %147, label %146

146:                                              ; preds = %141
  br label %176

147:                                              ; preds = %141
  %148 = load ptr, ptr %4, align 8
  %149 = getelementptr inbounds %struct.mz_stream_s, ptr %148, i32 0, i32 1
  %150 = load i32, ptr %149, align 8
  %151 = icmp ne i32 %150, 0
  br i1 %151, label %172, label %152

152:                                              ; preds = %147
  %153 = load i32, ptr %5, align 4
  %154 = icmp ne i32 %153, 4
  br i1 %154, label %155, label %172

155:                                              ; preds = %152
  %156 = load i32, ptr %5, align 4
  %157 = icmp ne i32 %156, 0
  br i1 %157, label %170, label %158

158:                                              ; preds = %155
  %159 = load ptr, ptr %4, align 8
  %160 = getelementptr inbounds %struct.mz_stream_s, ptr %159, i32 0, i32 2
  %161 = load i64, ptr %160, align 8
  %162 = load i64, ptr %8, align 8
  %163 = icmp ne i64 %161, %162
  br i1 %163, label %170, label %164

164:                                              ; preds = %158
  %165 = load ptr, ptr %4, align 8
  %166 = getelementptr inbounds %struct.mz_stream_s, ptr %165, i32 0, i32 5
  %167 = load i64, ptr %166, align 8
  %168 = load i64, ptr %9, align 8
  %169 = icmp ne i64 %167, %168
  br i1 %169, label %170, label %171

170:                                              ; preds = %164, %158, %155
  br label %176

171:                                              ; preds = %164
  store i32 -5, ptr %3, align 4
  br label %178

172:                                              ; preds = %152, %147
  br label %173

173:                                              ; preds = %172
  br label %174

174:                                              ; preds = %173
  br label %175

175:                                              ; preds = %174
  br label %60

176:                                              ; preds = %170, %146, %140, %136
  %177 = load i32, ptr %10, align 4
  store i32 %177, ptr %3, align 4
  br label %178

178:                                              ; preds = %176, %171, %48, %36, %30
  %179 = load i32, ptr %3, align 4
  ret i32 %179
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_compress(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, i32 noundef %5) #0 {
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  store ptr %0, ptr %8, align 8
  store ptr %1, ptr %9, align 8
  store ptr %2, ptr %10, align 8
  store ptr %3, ptr %11, align 8
  store ptr %4, ptr %12, align 8
  store i32 %5, ptr %13, align 4
  %14 = load ptr, ptr %8, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %27, label %16

16:                                               ; preds = %6
  %17 = load ptr, ptr %10, align 8
  %18 = icmp ne ptr %17, null
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = load ptr, ptr %10, align 8
  store i64 0, ptr %20, align 8
  br label %21

21:                                               ; preds = %19, %16
  %22 = load ptr, ptr %12, align 8
  %23 = icmp ne ptr %22, null
  br i1 %23, label %24, label %26

24:                                               ; preds = %21
  %25 = load ptr, ptr %12, align 8
  store i64 0, ptr %25, align 8
  br label %26

26:                                               ; preds = %24, %21
  store i32 -2, ptr %7, align 4
  br label %281

27:                                               ; preds = %6
  %28 = load ptr, ptr %9, align 8
  %29 = load ptr, ptr %8, align 8
  %30 = getelementptr inbounds %struct.tdefl_compressor, ptr %29, i32 0, i32 28
  store ptr %28, ptr %30, align 8
  %31 = load ptr, ptr %10, align 8
  %32 = load ptr, ptr %8, align 8
  %33 = getelementptr inbounds %struct.tdefl_compressor, ptr %32, i32 0, i32 30
  store ptr %31, ptr %33, align 8
  %34 = load ptr, ptr %11, align 8
  %35 = load ptr, ptr %8, align 8
  %36 = getelementptr inbounds %struct.tdefl_compressor, ptr %35, i32 0, i32 29
  store ptr %34, ptr %36, align 8
  %37 = load ptr, ptr %12, align 8
  %38 = load ptr, ptr %8, align 8
  %39 = getelementptr inbounds %struct.tdefl_compressor, ptr %38, i32 0, i32 31
  store ptr %37, ptr %39, align 8
  %40 = load ptr, ptr %9, align 8
  %41 = load ptr, ptr %8, align 8
  %42 = getelementptr inbounds %struct.tdefl_compressor, ptr %41, i32 0, i32 33
  store ptr %40, ptr %42, align 8
  %43 = load ptr, ptr %10, align 8
  %44 = icmp ne ptr %43, null
  br i1 %44, label %45, label %48

45:                                               ; preds = %27
  %46 = load ptr, ptr %10, align 8
  %47 = load i64, ptr %46, align 8
  br label %49

48:                                               ; preds = %27
  br label %49

49:                                               ; preds = %48, %45
  %50 = phi i64 [ %47, %45 ], [ 0, %48 ]
  %51 = load ptr, ptr %8, align 8
  %52 = getelementptr inbounds %struct.tdefl_compressor, ptr %51, i32 0, i32 34
  store i64 %50, ptr %52, align 8
  %53 = load ptr, ptr %8, align 8
  %54 = getelementptr inbounds %struct.tdefl_compressor, ptr %53, i32 0, i32 35
  store i64 0, ptr %54, align 8
  %55 = load i32, ptr %13, align 4
  %56 = load ptr, ptr %8, align 8
  %57 = getelementptr inbounds %struct.tdefl_compressor, ptr %56, i32 0, i32 32
  store i32 %55, ptr %57, align 8
  %58 = load ptr, ptr %8, align 8
  %59 = getelementptr inbounds %struct.tdefl_compressor, ptr %58, i32 0, i32 0
  %60 = load ptr, ptr %59, align 8
  %61 = icmp ne ptr %60, null
  %62 = zext i1 %61 to i32
  %63 = load ptr, ptr %11, align 8
  %64 = icmp ne ptr %63, null
  br i1 %64, label %68, label %65

65:                                               ; preds = %49
  %66 = load ptr, ptr %12, align 8
  %67 = icmp ne ptr %66, null
  br label %68

68:                                               ; preds = %65, %49
  %69 = phi i1 [ true, %49 ], [ %67, %65 ]
  %70 = zext i1 %69 to i32
  %71 = icmp eq i32 %62, %70
  br i1 %71, label %105, label %72

72:                                               ; preds = %68
  %73 = load ptr, ptr %8, align 8
  %74 = getelementptr inbounds %struct.tdefl_compressor, ptr %73, i32 0, i32 27
  %75 = load i32, ptr %74, align 4
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %105, label %77

77:                                               ; preds = %72
  %78 = load ptr, ptr %8, align 8
  %79 = getelementptr inbounds %struct.tdefl_compressor, ptr %78, i32 0, i32 26
  %80 = load i32, ptr %79, align 8
  %81 = icmp ne i32 %80, 0
  br i1 %81, label %82, label %85

82:                                               ; preds = %77
  %83 = load i32, ptr %13, align 4
  %84 = icmp ne i32 %83, 4
  br i1 %84, label %105, label %85

85:                                               ; preds = %82, %77
  %86 = load ptr, ptr %10, align 8
  %87 = icmp ne ptr %86, null
  br i1 %87, label %88, label %95

88:                                               ; preds = %85
  %89 = load ptr, ptr %10, align 8
  %90 = load i64, ptr %89, align 8
  %91 = icmp ne i64 %90, 0
  br i1 %91, label %92, label %95

92:                                               ; preds = %88
  %93 = load ptr, ptr %9, align 8
  %94 = icmp ne ptr %93, null
  br i1 %94, label %95, label %105

95:                                               ; preds = %92, %88, %85
  %96 = load ptr, ptr %12, align 8
  %97 = icmp ne ptr %96, null
  br i1 %97, label %98, label %118

98:                                               ; preds = %95
  %99 = load ptr, ptr %12, align 8
  %100 = load i64, ptr %99, align 8
  %101 = icmp ne i64 %100, 0
  br i1 %101, label %102, label %118

102:                                              ; preds = %98
  %103 = load ptr, ptr %11, align 8
  %104 = icmp ne ptr %103, null
  br i1 %104, label %118, label %105

105:                                              ; preds = %102, %92, %82, %72, %68
  %106 = load ptr, ptr %10, align 8
  %107 = icmp ne ptr %106, null
  br i1 %107, label %108, label %110

108:                                              ; preds = %105
  %109 = load ptr, ptr %10, align 8
  store i64 0, ptr %109, align 8
  br label %110

110:                                              ; preds = %108, %105
  %111 = load ptr, ptr %12, align 8
  %112 = icmp ne ptr %111, null
  br i1 %112, label %113, label %115

113:                                              ; preds = %110
  %114 = load ptr, ptr %12, align 8
  store i64 0, ptr %114, align 8
  br label %115

115:                                              ; preds = %113, %110
  %116 = load ptr, ptr %8, align 8
  %117 = getelementptr inbounds %struct.tdefl_compressor, ptr %116, i32 0, i32 27
  store i32 -2, ptr %117, align 4
  store i32 -2, ptr %7, align 4
  br label %281

118:                                              ; preds = %102, %98, %95
  %119 = load i32, ptr %13, align 4
  %120 = icmp eq i32 %119, 4
  %121 = zext i1 %120 to i32
  %122 = load ptr, ptr %8, align 8
  %123 = getelementptr inbounds %struct.tdefl_compressor, ptr %122, i32 0, i32 26
  %124 = load i32, ptr %123, align 8
  %125 = or i32 %124, %121
  store i32 %125, ptr %123, align 8
  %126 = load ptr, ptr %8, align 8
  %127 = getelementptr inbounds %struct.tdefl_compressor, ptr %126, i32 0, i32 23
  %128 = load i32, ptr %127, align 4
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %135, label %130

130:                                              ; preds = %118
  %131 = load ptr, ptr %8, align 8
  %132 = getelementptr inbounds %struct.tdefl_compressor, ptr %131, i32 0, i32 24
  %133 = load i32, ptr %132, align 8
  %134 = icmp ne i32 %133, 0
  br i1 %134, label %135, label %140

135:                                              ; preds = %130, %118
  %136 = load ptr, ptr %8, align 8
  %137 = call i32 @tdefl_flush_output_buffer(ptr noundef %136)
  %138 = load ptr, ptr %8, align 8
  %139 = getelementptr inbounds %struct.tdefl_compressor, ptr %138, i32 0, i32 27
  store i32 %137, ptr %139, align 4
  store i32 %137, ptr %7, align 4
  br label %281

140:                                              ; preds = %130
  %141 = load ptr, ptr %8, align 8
  %142 = getelementptr inbounds %struct.tdefl_compressor, ptr %141, i32 0, i32 2
  %143 = load i32, ptr %142, align 8
  %144 = and i32 %143, 4095
  %145 = icmp eq i32 %144, 1
  br i1 %145, label %146, label %167

146:                                              ; preds = %140
  %147 = load ptr, ptr %8, align 8
  %148 = getelementptr inbounds %struct.tdefl_compressor, ptr %147, i32 0, i32 2
  %149 = load i32, ptr %148, align 8
  %150 = and i32 %149, 32768
  %151 = icmp ne i32 %150, 0
  br i1 %151, label %152, label %167

152:                                              ; preds = %146
  %153 = load ptr, ptr %8, align 8
  %154 = getelementptr inbounds %struct.tdefl_compressor, ptr %153, i32 0, i32 2
  %155 = load i32, ptr %154, align 8
  %156 = and i32 %155, 1441792
  %157 = icmp eq i32 %156, 0
  br i1 %157, label %158, label %167

158:                                              ; preds = %152
  %159 = load ptr, ptr %8, align 8
  %160 = call i32 @tdefl_compress_fast(ptr noundef %159)
  %161 = icmp ne i32 %160, 0
  br i1 %161, label %166, label %162

162:                                              ; preds = %158
  %163 = load ptr, ptr %8, align 8
  %164 = getelementptr inbounds %struct.tdefl_compressor, ptr %163, i32 0, i32 27
  %165 = load i32, ptr %164, align 4
  store i32 %165, ptr %7, align 4
  br label %281

166:                                              ; preds = %158
  br label %176

167:                                              ; preds = %152, %146, %140
  %168 = load ptr, ptr %8, align 8
  %169 = call i32 @tdefl_compress_normal(ptr noundef %168)
  %170 = icmp ne i32 %169, 0
  br i1 %170, label %175, label %171

171:                                              ; preds = %167
  %172 = load ptr, ptr %8, align 8
  %173 = getelementptr inbounds %struct.tdefl_compressor, ptr %172, i32 0, i32 27
  %174 = load i32, ptr %173, align 4
  store i32 %174, ptr %7, align 4
  br label %281

175:                                              ; preds = %167
  br label %176

176:                                              ; preds = %175, %166
  %177 = load ptr, ptr %8, align 8
  %178 = getelementptr inbounds %struct.tdefl_compressor, ptr %177, i32 0, i32 2
  %179 = load i32, ptr %178, align 8
  %180 = and i32 %179, 12288
  %181 = icmp ne i32 %180, 0
  br i1 %181, label %182, label %202

182:                                              ; preds = %176
  %183 = load ptr, ptr %9, align 8
  %184 = icmp ne ptr %183, null
  br i1 %184, label %185, label %202

185:                                              ; preds = %182
  %186 = load ptr, ptr %8, align 8
  %187 = getelementptr inbounds %struct.tdefl_compressor, ptr %186, i32 0, i32 5
  %188 = load i32, ptr %187, align 8
  %189 = zext i32 %188 to i64
  %190 = load ptr, ptr %9, align 8
  %191 = load ptr, ptr %8, align 8
  %192 = getelementptr inbounds %struct.tdefl_compressor, ptr %191, i32 0, i32 33
  %193 = load ptr, ptr %192, align 8
  %194 = load ptr, ptr %9, align 8
  %195 = ptrtoint ptr %193 to i64
  %196 = ptrtoint ptr %194 to i64
  %197 = sub i64 %195, %196
  %198 = call i64 @mz_adler32(i64 noundef %189, ptr noundef %190, i64 noundef %197)
  %199 = trunc i64 %198 to i32
  %200 = load ptr, ptr %8, align 8
  %201 = getelementptr inbounds %struct.tdefl_compressor, ptr %200, i32 0, i32 5
  store i32 %199, ptr %201, align 8
  br label %202

202:                                              ; preds = %185, %182, %176
  %203 = load ptr, ptr %8, align 8
  %204 = getelementptr inbounds %struct.tdefl_compressor, ptr %203, i32 0, i32 2
  %205 = load i32, ptr %204, align 8
  %206 = and i32 %205, 16384
  %207 = icmp ne i32 %206, 0
  br i1 %207, label %208, label %225

208:                                              ; preds = %202
  %209 = load ptr, ptr %8, align 8
  %210 = getelementptr inbounds %struct.tdefl_compressor, ptr %209, i32 0, i32 6
  %211 = load i32, ptr %210, align 4
  %212 = zext i32 %211 to i64
  %213 = load ptr, ptr %9, align 8
  %214 = load ptr, ptr %8, align 8
  %215 = getelementptr inbounds %struct.tdefl_compressor, ptr %214, i32 0, i32 33
  %216 = load ptr, ptr %215, align 8
  %217 = load ptr, ptr %9, align 8
  %218 = ptrtoint ptr %216 to i64
  %219 = ptrtoint ptr %217 to i64
  %220 = sub i64 %218, %219
  %221 = call i64 @mz_crc32(i64 noundef %212, ptr noundef %213, i64 noundef %220)
  %222 = trunc i64 %221 to i32
  %223 = load ptr, ptr %8, align 8
  %224 = getelementptr inbounds %struct.tdefl_compressor, ptr %223, i32 0, i32 6
  store i32 %222, ptr %224, align 4
  br label %225

225:                                              ; preds = %208, %202
  %226 = load i32, ptr %13, align 4
  %227 = icmp ne i32 %226, 0
  br i1 %227, label %228, label %276

228:                                              ; preds = %225
  %229 = load ptr, ptr %8, align 8
  %230 = getelementptr inbounds %struct.tdefl_compressor, ptr %229, i32 0, i32 8
  %231 = load i32, ptr %230, align 4
  %232 = icmp ne i32 %231, 0
  br i1 %232, label %276, label %233

233:                                              ; preds = %228
  %234 = load ptr, ptr %8, align 8
  %235 = getelementptr inbounds %struct.tdefl_compressor, ptr %234, i32 0, i32 34
  %236 = load i64, ptr %235, align 8
  %237 = icmp ne i64 %236, 0
  br i1 %237, label %276, label %238

238:                                              ; preds = %233
  %239 = load ptr, ptr %8, align 8
  %240 = getelementptr inbounds %struct.tdefl_compressor, ptr %239, i32 0, i32 23
  %241 = load i32, ptr %240, align 4
  %242 = icmp ne i32 %241, 0
  br i1 %242, label %276, label %243

243:                                              ; preds = %238
  %244 = load ptr, ptr %8, align 8
  %245 = load i32, ptr %13, align 4
  %246 = call i32 @tdefl_flush_block(ptr noundef %244, i32 noundef %245)
  %247 = icmp slt i32 %246, 0
  br i1 %247, label %248, label %252

248:                                              ; preds = %243
  %249 = load ptr, ptr %8, align 8
  %250 = getelementptr inbounds %struct.tdefl_compressor, ptr %249, i32 0, i32 27
  %251 = load i32, ptr %250, align 4
  store i32 %251, ptr %7, align 4
  br label %281

252:                                              ; preds = %243
  %253 = load i32, ptr %13, align 4
  %254 = icmp eq i32 %253, 4
  %255 = zext i1 %254 to i32
  %256 = load ptr, ptr %8, align 8
  %257 = getelementptr inbounds %struct.tdefl_compressor, ptr %256, i32 0, i32 24
  store i32 %255, ptr %257, align 8
  %258 = load i32, ptr %13, align 4
  %259 = icmp eq i32 %258, 3
  br i1 %259, label %260, label %275

260:                                              ; preds = %252
  %261 = load ptr, ptr %8, align 8
  %262 = getelementptr inbounds %struct.tdefl_compressor, ptr %261, i32 0, i32 42
  %263 = load ptr, ptr %8, align 8
  %264 = getelementptr inbounds %struct.tdefl_compressor, ptr %263, i32 0, i32 42
  %265 = call i64 @llvm.objectsize.i64.p0(ptr %264, i1 false, i1 true, i1 false)
  %266 = call ptr @__memset_chk(ptr noundef %262, i32 noundef 0, i64 noundef 65536, i64 noundef %265) #12
  %267 = load ptr, ptr %8, align 8
  %268 = getelementptr inbounds %struct.tdefl_compressor, ptr %267, i32 0, i32 41
  %269 = load ptr, ptr %8, align 8
  %270 = getelementptr inbounds %struct.tdefl_compressor, ptr %269, i32 0, i32 41
  %271 = call i64 @llvm.objectsize.i64.p0(ptr %270, i1 false, i1 true, i1 false)
  %272 = call ptr @__memset_chk(ptr noundef %268, i32 noundef 0, i64 noundef 65536, i64 noundef %271) #12
  %273 = load ptr, ptr %8, align 8
  %274 = getelementptr inbounds %struct.tdefl_compressor, ptr %273, i32 0, i32 9
  store i32 0, ptr %274, align 8
  br label %275

275:                                              ; preds = %260, %252
  br label %276

276:                                              ; preds = %275, %238, %233, %228, %225
  %277 = load ptr, ptr %8, align 8
  %278 = call i32 @tdefl_flush_output_buffer(ptr noundef %277)
  %279 = load ptr, ptr %8, align 8
  %280 = getelementptr inbounds %struct.tdefl_compressor, ptr %279, i32 0, i32 27
  store i32 %278, ptr %280, align 4
  store i32 %278, ptr %7, align 4
  br label %281

281:                                              ; preds = %276, %248, %171, %162, %135, %115, %26
  %282 = load i32, ptr %7, align 4
  ret i32 %282
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_get_adler32(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.tdefl_compressor, ptr %3, i32 0, i32 5
  %5 = load i32, ptr %4, align 8
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_get_crc32(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.tdefl_compressor, ptr %3, i32 0, i32 6
  %5 = load i32, ptr %4, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @mz_deflateBound(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = load i64, ptr %4, align 8
  %7 = mul i64 %6, 110
  %8 = udiv i64 %7, 100
  %9 = add i64 128, %8
  %10 = load i64, ptr %4, align 8
  %11 = add i64 128, %10
  %12 = load i64, ptr %4, align 8
  %13 = udiv i64 %12, 31744
  %14 = add i64 %13, 1
  %15 = mul i64 %14, 5
  %16 = add i64 %11, %15
  %17 = icmp ugt i64 %9, %16
  br i1 %17, label %18, label %23

18:                                               ; preds = %2
  %19 = load i64, ptr %4, align 8
  %20 = mul i64 %19, 110
  %21 = udiv i64 %20, 100
  %22 = add i64 128, %21
  br label %31

23:                                               ; preds = %2
  %24 = load i64, ptr %4, align 8
  %25 = add i64 128, %24
  %26 = load i64, ptr %4, align 8
  %27 = udiv i64 %26, 31744
  %28 = add i64 %27, 1
  %29 = mul i64 %28, 5
  %30 = add i64 %25, %29
  br label %31

31:                                               ; preds = %23, %18
  %32 = phi i64 [ %22, %18 ], [ %30, %23 ]
  ret i64 %32
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_compress2(ptr noundef %0, ptr noundef %1, ptr noundef %2, i64 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.mz_stream_s, align 8
  store ptr %0, ptr %7, align 8
  store ptr %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store i64 %3, ptr %10, align 8
  store i32 %4, ptr %11, align 4
  call void @llvm.memset.p0.i64(ptr align 8 %13, i8 0, i64 120, i1 false)
  %14 = load i64, ptr %10, align 8
  %15 = load ptr, ptr %8, align 8
  %16 = load i64, ptr %15, align 8
  %17 = or i64 %14, %16
  %18 = icmp ugt i64 %17, 4294967295
  br i1 %18, label %19, label %20

19:                                               ; preds = %5
  store i32 -10000, ptr %6, align 4
  br label %56

20:                                               ; preds = %5
  %21 = load ptr, ptr %9, align 8
  %22 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 0
  store ptr %21, ptr %22, align 8
  %23 = load i64, ptr %10, align 8
  %24 = trunc i64 %23 to i32
  %25 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 1
  store i32 %24, ptr %25, align 8
  %26 = load ptr, ptr %7, align 8
  %27 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 3
  store ptr %26, ptr %27, align 8
  %28 = load ptr, ptr %8, align 8
  %29 = load i64, ptr %28, align 8
  %30 = trunc i64 %29 to i32
  %31 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 4
  store i32 %30, ptr %31, align 8
  %32 = load i32, ptr %11, align 4
  %33 = call i32 @mz_deflateInit(ptr noundef %13, i32 noundef %32)
  store i32 %33, ptr %12, align 4
  %34 = load i32, ptr %12, align 4
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %36, label %38

36:                                               ; preds = %20
  %37 = load i32, ptr %12, align 4
  store i32 %37, ptr %6, align 4
  br label %56

38:                                               ; preds = %20
  %39 = call i32 @mz_deflate(ptr noundef %13, i32 noundef 4)
  store i32 %39, ptr %12, align 4
  %40 = load i32, ptr %12, align 4
  %41 = icmp ne i32 %40, 1
  br i1 %41, label %42, label %51

42:                                               ; preds = %38
  %43 = call i32 @mz_deflateEnd(ptr noundef %13)
  %44 = load i32, ptr %12, align 4
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %46, label %47

46:                                               ; preds = %42
  br label %49

47:                                               ; preds = %42
  %48 = load i32, ptr %12, align 4
  br label %49

49:                                               ; preds = %47, %46
  %50 = phi i32 [ -5, %46 ], [ %48, %47 ]
  store i32 %50, ptr %6, align 4
  br label %56

51:                                               ; preds = %38
  %52 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 5
  %53 = load i64, ptr %52, align 8
  %54 = load ptr, ptr %8, align 8
  store i64 %53, ptr %54, align 8
  %55 = call i32 @mz_deflateEnd(ptr noundef %13)
  store i32 %55, ptr %6, align 4
  br label %56

56:                                               ; preds = %51, %49, %36, %19
  %57 = load i32, ptr %6, align 4
  ret i32 %57
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_compress(ptr noundef %0, ptr noundef %1, ptr noundef %2, i64 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  store i64 %3, ptr %8, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = load ptr, ptr %7, align 8
  %12 = load i64, ptr %8, align 8
  %13 = call i32 @mz_compress2(ptr noundef %9, ptr noundef %10, ptr noundef %11, i64 noundef %12, i32 noundef -1)
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @mz_compressBound(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %3 = load i64, ptr %2, align 8
  %4 = call i64 @mz_deflateBound(ptr noundef null, i64 noundef %3)
  ret i64 %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_inflateInit2(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  %7 = load ptr, ptr %4, align 8
  %8 = icmp ne ptr %7, null
  br i1 %8, label %10, label %9

9:                                                ; preds = %2
  store i32 -2, ptr %3, align 4
  br label %81

10:                                               ; preds = %2
  %11 = load i32, ptr %5, align 4
  %12 = icmp ne i32 %11, 15
  br i1 %12, label %13, label %18

13:                                               ; preds = %10
  %14 = load i32, ptr %5, align 4
  %15 = sub nsw i32 0, %14
  %16 = icmp ne i32 %15, 15
  br i1 %16, label %17, label %18

17:                                               ; preds = %13
  store i32 -10000, ptr %3, align 4
  br label %81

18:                                               ; preds = %13, %10
  %19 = load ptr, ptr %4, align 8
  %20 = getelementptr inbounds %struct.mz_stream_s, ptr %19, i32 0, i32 11
  store i32 0, ptr %20, align 8
  %21 = load ptr, ptr %4, align 8
  %22 = getelementptr inbounds %struct.mz_stream_s, ptr %21, i32 0, i32 12
  store i64 0, ptr %22, align 8
  %23 = load ptr, ptr %4, align 8
  %24 = getelementptr inbounds %struct.mz_stream_s, ptr %23, i32 0, i32 13
  store i64 0, ptr %24, align 8
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds %struct.mz_stream_s, ptr %25, i32 0, i32 6
  store ptr null, ptr %26, align 8
  %27 = load ptr, ptr %4, align 8
  %28 = getelementptr inbounds %struct.mz_stream_s, ptr %27, i32 0, i32 2
  store i64 0, ptr %28, align 8
  %29 = load ptr, ptr %4, align 8
  %30 = getelementptr inbounds %struct.mz_stream_s, ptr %29, i32 0, i32 5
  store i64 0, ptr %30, align 8
  %31 = load ptr, ptr %4, align 8
  %32 = getelementptr inbounds %struct.mz_stream_s, ptr %31, i32 0, i32 14
  store i64 0, ptr %32, align 8
  %33 = load ptr, ptr %4, align 8
  %34 = getelementptr inbounds %struct.mz_stream_s, ptr %33, i32 0, i32 8
  %35 = load ptr, ptr %34, align 8
  %36 = icmp ne ptr %35, null
  br i1 %36, label %40, label %37

37:                                               ; preds = %18
  %38 = load ptr, ptr %4, align 8
  %39 = getelementptr inbounds %struct.mz_stream_s, ptr %38, i32 0, i32 8
  store ptr @def_alloc_func, ptr %39, align 8
  br label %40

40:                                               ; preds = %37, %18
  %41 = load ptr, ptr %4, align 8
  %42 = getelementptr inbounds %struct.mz_stream_s, ptr %41, i32 0, i32 9
  %43 = load ptr, ptr %42, align 8
  %44 = icmp ne ptr %43, null
  br i1 %44, label %48, label %45

45:                                               ; preds = %40
  %46 = load ptr, ptr %4, align 8
  %47 = getelementptr inbounds %struct.mz_stream_s, ptr %46, i32 0, i32 9
  store ptr @def_free_func, ptr %47, align 8
  br label %48

48:                                               ; preds = %45, %40
  %49 = load ptr, ptr %4, align 8
  %50 = getelementptr inbounds %struct.mz_stream_s, ptr %49, i32 0, i32 8
  %51 = load ptr, ptr %50, align 8
  %52 = load ptr, ptr %4, align 8
  %53 = getelementptr inbounds %struct.mz_stream_s, ptr %52, i32 0, i32 10
  %54 = load ptr, ptr %53, align 8
  %55 = call ptr %51(ptr noundef %54, i64 noundef 1, i64 noundef 43800)
  store ptr %55, ptr %6, align 8
  %56 = load ptr, ptr %6, align 8
  %57 = icmp ne ptr %56, null
  br i1 %57, label %59, label %58

58:                                               ; preds = %48
  store i32 -4, ptr %3, align 4
  br label %81

59:                                               ; preds = %48
  %60 = load ptr, ptr %6, align 8
  %61 = load ptr, ptr %4, align 8
  %62 = getelementptr inbounds %struct.mz_stream_s, ptr %61, i32 0, i32 7
  store ptr %60, ptr %62, align 8
  br label %63

63:                                               ; preds = %59
  %64 = load ptr, ptr %6, align 8
  %65 = getelementptr inbounds %struct.inflate_state, ptr %64, i32 0, i32 0
  %66 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %65, i32 0, i32 0
  store i32 0, ptr %66, align 8
  br label %67

67:                                               ; preds = %63
  %68 = load ptr, ptr %6, align 8
  %69 = getelementptr inbounds %struct.inflate_state, ptr %68, i32 0, i32 1
  store i32 0, ptr %69, align 8
  %70 = load ptr, ptr %6, align 8
  %71 = getelementptr inbounds %struct.inflate_state, ptr %70, i32 0, i32 2
  store i32 0, ptr %71, align 4
  %72 = load ptr, ptr %6, align 8
  %73 = getelementptr inbounds %struct.inflate_state, ptr %72, i32 0, i32 7
  store i32 1, ptr %73, align 4
  %74 = load ptr, ptr %6, align 8
  %75 = getelementptr inbounds %struct.inflate_state, ptr %74, i32 0, i32 3
  store i32 1, ptr %75, align 8
  %76 = load ptr, ptr %6, align 8
  %77 = getelementptr inbounds %struct.inflate_state, ptr %76, i32 0, i32 4
  store i32 0, ptr %77, align 4
  %78 = load i32, ptr %5, align 4
  %79 = load ptr, ptr %6, align 8
  %80 = getelementptr inbounds %struct.inflate_state, ptr %79, i32 0, i32 5
  store i32 %78, ptr %80, align 8
  store i32 0, ptr %3, align 4
  br label %81

81:                                               ; preds = %67, %58, %17, %9
  %82 = load i32, ptr %3, align 4
  ret i32 %82
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_inflateInit(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @mz_inflateInit2(ptr noundef %3, i32 noundef 15)
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_inflate(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 8, ptr %9, align 4
  %14 = load ptr, ptr %4, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %16, label %21

16:                                               ; preds = %2
  %17 = load ptr, ptr %4, align 8
  %18 = getelementptr inbounds %struct.mz_stream_s, ptr %17, i32 0, i32 7
  %19 = load ptr, ptr %18, align 8
  %20 = icmp ne ptr %19, null
  br i1 %20, label %22, label %21

21:                                               ; preds = %16, %2
  store i32 -2, ptr %3, align 4
  br label %469

22:                                               ; preds = %16
  %23 = load i32, ptr %5, align 4
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %26

25:                                               ; preds = %22
  store i32 2, ptr %5, align 4
  br label %26

26:                                               ; preds = %25, %22
  %27 = load i32, ptr %5, align 4
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %36

29:                                               ; preds = %26
  %30 = load i32, ptr %5, align 4
  %31 = icmp ne i32 %30, 2
  br i1 %31, label %32, label %36

32:                                               ; preds = %29
  %33 = load i32, ptr %5, align 4
  %34 = icmp ne i32 %33, 4
  br i1 %34, label %35, label %36

35:                                               ; preds = %32
  store i32 -2, ptr %3, align 4
  br label %469

36:                                               ; preds = %32, %29, %26
  %37 = load ptr, ptr %4, align 8
  %38 = getelementptr inbounds %struct.mz_stream_s, ptr %37, i32 0, i32 7
  %39 = load ptr, ptr %38, align 8
  store ptr %39, ptr %6, align 8
  %40 = load ptr, ptr %6, align 8
  %41 = getelementptr inbounds %struct.inflate_state, ptr %40, i32 0, i32 5
  %42 = load i32, ptr %41, align 8
  %43 = icmp sgt i32 %42, 0
  br i1 %43, label %44, label %47

44:                                               ; preds = %36
  %45 = load i32, ptr %9, align 4
  %46 = or i32 %45, 1
  store i32 %46, ptr %9, align 4
  br label %47

47:                                               ; preds = %44, %36
  %48 = load ptr, ptr %4, align 8
  %49 = getelementptr inbounds %struct.mz_stream_s, ptr %48, i32 0, i32 1
  %50 = load i32, ptr %49, align 8
  %51 = zext i32 %50 to i64
  store i64 %51, ptr %12, align 8
  %52 = load ptr, ptr %6, align 8
  %53 = getelementptr inbounds %struct.inflate_state, ptr %52, i32 0, i32 3
  %54 = load i32, ptr %53, align 8
  store i32 %54, ptr %8, align 4
  %55 = load ptr, ptr %6, align 8
  %56 = getelementptr inbounds %struct.inflate_state, ptr %55, i32 0, i32 3
  store i32 0, ptr %56, align 8
  %57 = load ptr, ptr %6, align 8
  %58 = getelementptr inbounds %struct.inflate_state, ptr %57, i32 0, i32 7
  %59 = load i32, ptr %58, align 4
  %60 = icmp slt i32 %59, 0
  br i1 %60, label %61, label %62

61:                                               ; preds = %47
  store i32 -3, ptr %3, align 4
  br label %469

62:                                               ; preds = %47
  %63 = load ptr, ptr %6, align 8
  %64 = getelementptr inbounds %struct.inflate_state, ptr %63, i32 0, i32 4
  %65 = load i32, ptr %64, align 4
  %66 = icmp ne i32 %65, 0
  br i1 %66, label %67, label %71

67:                                               ; preds = %62
  %68 = load i32, ptr %5, align 4
  %69 = icmp ne i32 %68, 4
  br i1 %69, label %70, label %71

70:                                               ; preds = %67
  store i32 -2, ptr %3, align 4
  br label %469

71:                                               ; preds = %67, %62
  %72 = load i32, ptr %5, align 4
  %73 = icmp eq i32 %72, 4
  %74 = zext i1 %73 to i32
  %75 = load ptr, ptr %6, align 8
  %76 = getelementptr inbounds %struct.inflate_state, ptr %75, i32 0, i32 4
  %77 = load i32, ptr %76, align 4
  %78 = or i32 %77, %74
  store i32 %78, ptr %76, align 4
  %79 = load i32, ptr %5, align 4
  %80 = icmp eq i32 %79, 4
  br i1 %80, label %81, label %176

81:                                               ; preds = %71
  %82 = load i32, ptr %8, align 4
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %176

84:                                               ; preds = %81
  %85 = load i32, ptr %9, align 4
  %86 = or i32 %85, 4
  store i32 %86, ptr %9, align 4
  %87 = load ptr, ptr %4, align 8
  %88 = getelementptr inbounds %struct.mz_stream_s, ptr %87, i32 0, i32 1
  %89 = load i32, ptr %88, align 8
  %90 = zext i32 %89 to i64
  store i64 %90, ptr %10, align 8
  %91 = load ptr, ptr %4, align 8
  %92 = getelementptr inbounds %struct.mz_stream_s, ptr %91, i32 0, i32 4
  %93 = load i32, ptr %92, align 8
  %94 = zext i32 %93 to i64
  store i64 %94, ptr %11, align 8
  %95 = load ptr, ptr %6, align 8
  %96 = getelementptr inbounds %struct.inflate_state, ptr %95, i32 0, i32 0
  %97 = load ptr, ptr %4, align 8
  %98 = getelementptr inbounds %struct.mz_stream_s, ptr %97, i32 0, i32 0
  %99 = load ptr, ptr %98, align 8
  %100 = load ptr, ptr %4, align 8
  %101 = getelementptr inbounds %struct.mz_stream_s, ptr %100, i32 0, i32 3
  %102 = load ptr, ptr %101, align 8
  %103 = load ptr, ptr %4, align 8
  %104 = getelementptr inbounds %struct.mz_stream_s, ptr %103, i32 0, i32 3
  %105 = load ptr, ptr %104, align 8
  %106 = load i32, ptr %9, align 4
  %107 = call i32 @tinfl_decompress(ptr noundef %96, ptr noundef %99, ptr noundef %10, ptr noundef %102, ptr noundef %105, ptr noundef %11, i32 noundef %106)
  store i32 %107, ptr %13, align 4
  %108 = load i32, ptr %13, align 4
  %109 = load ptr, ptr %6, align 8
  %110 = getelementptr inbounds %struct.inflate_state, ptr %109, i32 0, i32 7
  store i32 %108, ptr %110, align 4
  %111 = load i64, ptr %10, align 8
  %112 = trunc i64 %111 to i32
  %113 = load ptr, ptr %4, align 8
  %114 = getelementptr inbounds %struct.mz_stream_s, ptr %113, i32 0, i32 0
  %115 = load ptr, ptr %114, align 8
  %116 = zext i32 %112 to i64
  %117 = getelementptr inbounds i8, ptr %115, i64 %116
  store ptr %117, ptr %114, align 8
  %118 = load i64, ptr %10, align 8
  %119 = trunc i64 %118 to i32
  %120 = load ptr, ptr %4, align 8
  %121 = getelementptr inbounds %struct.mz_stream_s, ptr %120, i32 0, i32 1
  %122 = load i32, ptr %121, align 8
  %123 = sub i32 %122, %119
  store i32 %123, ptr %121, align 8
  %124 = load i64, ptr %10, align 8
  %125 = trunc i64 %124 to i32
  %126 = zext i32 %125 to i64
  %127 = load ptr, ptr %4, align 8
  %128 = getelementptr inbounds %struct.mz_stream_s, ptr %127, i32 0, i32 2
  %129 = load i64, ptr %128, align 8
  %130 = add i64 %129, %126
  store i64 %130, ptr %128, align 8
  %131 = load ptr, ptr %6, align 8
  %132 = getelementptr inbounds %struct.inflate_state, ptr %131, i32 0, i32 0
  %133 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %132, i32 0, i32 8
  %134 = load i32, ptr %133, align 8
  %135 = zext i32 %134 to i64
  %136 = load ptr, ptr %4, align 8
  %137 = getelementptr inbounds %struct.mz_stream_s, ptr %136, i32 0, i32 12
  store i64 %135, ptr %137, align 8
  %138 = load ptr, ptr %6, align 8
  %139 = getelementptr inbounds %struct.inflate_state, ptr %138, i32 0, i32 0
  %140 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %139, i32 0, i32 9
  %141 = load i32, ptr %140, align 4
  %142 = zext i32 %141 to i64
  %143 = load ptr, ptr %4, align 8
  %144 = getelementptr inbounds %struct.mz_stream_s, ptr %143, i32 0, i32 13
  store i64 %142, ptr %144, align 8
  %145 = load i64, ptr %11, align 8
  %146 = trunc i64 %145 to i32
  %147 = load ptr, ptr %4, align 8
  %148 = getelementptr inbounds %struct.mz_stream_s, ptr %147, i32 0, i32 3
  %149 = load ptr, ptr %148, align 8
  %150 = zext i32 %146 to i64
  %151 = getelementptr inbounds i8, ptr %149, i64 %150
  store ptr %151, ptr %148, align 8
  %152 = load i64, ptr %11, align 8
  %153 = trunc i64 %152 to i32
  %154 = load ptr, ptr %4, align 8
  %155 = getelementptr inbounds %struct.mz_stream_s, ptr %154, i32 0, i32 4
  %156 = load i32, ptr %155, align 8
  %157 = sub i32 %156, %153
  store i32 %157, ptr %155, align 8
  %158 = load i64, ptr %11, align 8
  %159 = trunc i64 %158 to i32
  %160 = zext i32 %159 to i64
  %161 = load ptr, ptr %4, align 8
  %162 = getelementptr inbounds %struct.mz_stream_s, ptr %161, i32 0, i32 5
  %163 = load i64, ptr %162, align 8
  %164 = add i64 %163, %160
  store i64 %164, ptr %162, align 8
  %165 = load i32, ptr %13, align 4
  %166 = icmp slt i32 %165, 0
  br i1 %166, label %167, label %168

167:                                              ; preds = %84
  store i32 -3, ptr %3, align 4
  br label %469

168:                                              ; preds = %84
  %169 = load i32, ptr %13, align 4
  %170 = icmp ne i32 %169, 0
  br i1 %170, label %171, label %174

171:                                              ; preds = %168
  %172 = load ptr, ptr %6, align 8
  %173 = getelementptr inbounds %struct.inflate_state, ptr %172, i32 0, i32 7
  store i32 -1, ptr %173, align 4
  store i32 -5, ptr %3, align 4
  br label %469

174:                                              ; preds = %168
  br label %175

175:                                              ; preds = %174
  store i32 1, ptr %3, align 4
  br label %469

176:                                              ; preds = %81, %71
  %177 = load i32, ptr %5, align 4
  %178 = icmp ne i32 %177, 4
  br i1 %178, label %179, label %182

179:                                              ; preds = %176
  %180 = load i32, ptr %9, align 4
  %181 = or i32 %180, 2
  store i32 %181, ptr %9, align 4
  br label %182

182:                                              ; preds = %179, %176
  %183 = load ptr, ptr %6, align 8
  %184 = getelementptr inbounds %struct.inflate_state, ptr %183, i32 0, i32 2
  %185 = load i32, ptr %184, align 4
  %186 = icmp ne i32 %185, 0
  br i1 %186, label %187, label %267

187:                                              ; preds = %182
  %188 = load ptr, ptr %6, align 8
  %189 = getelementptr inbounds %struct.inflate_state, ptr %188, i32 0, i32 2
  %190 = load i32, ptr %189, align 4
  %191 = load ptr, ptr %4, align 8
  %192 = getelementptr inbounds %struct.mz_stream_s, ptr %191, i32 0, i32 4
  %193 = load i32, ptr %192, align 8
  %194 = icmp ult i32 %190, %193
  br i1 %194, label %195, label %199

195:                                              ; preds = %187
  %196 = load ptr, ptr %6, align 8
  %197 = getelementptr inbounds %struct.inflate_state, ptr %196, i32 0, i32 2
  %198 = load i32, ptr %197, align 4
  br label %203

199:                                              ; preds = %187
  %200 = load ptr, ptr %4, align 8
  %201 = getelementptr inbounds %struct.mz_stream_s, ptr %200, i32 0, i32 4
  %202 = load i32, ptr %201, align 8
  br label %203

203:                                              ; preds = %199, %195
  %204 = phi i32 [ %198, %195 ], [ %202, %199 ]
  store i32 %204, ptr %7, align 4
  %205 = load ptr, ptr %4, align 8
  %206 = getelementptr inbounds %struct.mz_stream_s, ptr %205, i32 0, i32 3
  %207 = load ptr, ptr %206, align 8
  %208 = load ptr, ptr %6, align 8
  %209 = getelementptr inbounds %struct.inflate_state, ptr %208, i32 0, i32 6
  %210 = getelementptr inbounds [32768 x i8], ptr %209, i64 0, i64 0
  %211 = load ptr, ptr %6, align 8
  %212 = getelementptr inbounds %struct.inflate_state, ptr %211, i32 0, i32 1
  %213 = load i32, ptr %212, align 8
  %214 = zext i32 %213 to i64
  %215 = getelementptr inbounds i8, ptr %210, i64 %214
  %216 = load i32, ptr %7, align 4
  %217 = zext i32 %216 to i64
  %218 = load ptr, ptr %4, align 8
  %219 = getelementptr inbounds %struct.mz_stream_s, ptr %218, i32 0, i32 3
  %220 = load ptr, ptr %219, align 8
  %221 = call i64 @llvm.objectsize.i64.p0(ptr %220, i1 false, i1 true, i1 false)
  %222 = call ptr @__memcpy_chk(ptr noundef %207, ptr noundef %215, i64 noundef %217, i64 noundef %221) #12
  %223 = load i32, ptr %7, align 4
  %224 = load ptr, ptr %4, align 8
  %225 = getelementptr inbounds %struct.mz_stream_s, ptr %224, i32 0, i32 3
  %226 = load ptr, ptr %225, align 8
  %227 = zext i32 %223 to i64
  %228 = getelementptr inbounds i8, ptr %226, i64 %227
  store ptr %228, ptr %225, align 8
  %229 = load i32, ptr %7, align 4
  %230 = load ptr, ptr %4, align 8
  %231 = getelementptr inbounds %struct.mz_stream_s, ptr %230, i32 0, i32 4
  %232 = load i32, ptr %231, align 8
  %233 = sub i32 %232, %229
  store i32 %233, ptr %231, align 8
  %234 = load i32, ptr %7, align 4
  %235 = zext i32 %234 to i64
  %236 = load ptr, ptr %4, align 8
  %237 = getelementptr inbounds %struct.mz_stream_s, ptr %236, i32 0, i32 5
  %238 = load i64, ptr %237, align 8
  %239 = add i64 %238, %235
  store i64 %239, ptr %237, align 8
  %240 = load i32, ptr %7, align 4
  %241 = load ptr, ptr %6, align 8
  %242 = getelementptr inbounds %struct.inflate_state, ptr %241, i32 0, i32 2
  %243 = load i32, ptr %242, align 4
  %244 = sub i32 %243, %240
  store i32 %244, ptr %242, align 4
  %245 = load ptr, ptr %6, align 8
  %246 = getelementptr inbounds %struct.inflate_state, ptr %245, i32 0, i32 1
  %247 = load i32, ptr %246, align 8
  %248 = load i32, ptr %7, align 4
  %249 = add i32 %247, %248
  %250 = and i32 %249, 32767
  %251 = load ptr, ptr %6, align 8
  %252 = getelementptr inbounds %struct.inflate_state, ptr %251, i32 0, i32 1
  store i32 %250, ptr %252, align 8
  %253 = load ptr, ptr %6, align 8
  %254 = getelementptr inbounds %struct.inflate_state, ptr %253, i32 0, i32 7
  %255 = load i32, ptr %254, align 4
  %256 = icmp eq i32 %255, 0
  br i1 %256, label %257, label %263

257:                                              ; preds = %203
  %258 = load ptr, ptr %6, align 8
  %259 = getelementptr inbounds %struct.inflate_state, ptr %258, i32 0, i32 2
  %260 = load i32, ptr %259, align 4
  %261 = icmp ne i32 %260, 0
  %262 = xor i1 %261, true
  br label %263

263:                                              ; preds = %257, %203
  %264 = phi i1 [ false, %203 ], [ %262, %257 ]
  %265 = zext i1 %264 to i64
  %266 = select i1 %264, i32 1, i32 0
  store i32 %266, ptr %3, align 4
  br label %469

267:                                              ; preds = %182
  br label %268

268:                                              ; preds = %455, %267
  %269 = load ptr, ptr %4, align 8
  %270 = getelementptr inbounds %struct.mz_stream_s, ptr %269, i32 0, i32 1
  %271 = load i32, ptr %270, align 8
  %272 = zext i32 %271 to i64
  store i64 %272, ptr %10, align 8
  %273 = load ptr, ptr %6, align 8
  %274 = getelementptr inbounds %struct.inflate_state, ptr %273, i32 0, i32 1
  %275 = load i32, ptr %274, align 8
  %276 = sub i32 32768, %275
  %277 = zext i32 %276 to i64
  store i64 %277, ptr %11, align 8
  %278 = load ptr, ptr %6, align 8
  %279 = getelementptr inbounds %struct.inflate_state, ptr %278, i32 0, i32 0
  %280 = load ptr, ptr %4, align 8
  %281 = getelementptr inbounds %struct.mz_stream_s, ptr %280, i32 0, i32 0
  %282 = load ptr, ptr %281, align 8
  %283 = load ptr, ptr %6, align 8
  %284 = getelementptr inbounds %struct.inflate_state, ptr %283, i32 0, i32 6
  %285 = getelementptr inbounds [32768 x i8], ptr %284, i64 0, i64 0
  %286 = load ptr, ptr %6, align 8
  %287 = getelementptr inbounds %struct.inflate_state, ptr %286, i32 0, i32 6
  %288 = getelementptr inbounds [32768 x i8], ptr %287, i64 0, i64 0
  %289 = load ptr, ptr %6, align 8
  %290 = getelementptr inbounds %struct.inflate_state, ptr %289, i32 0, i32 1
  %291 = load i32, ptr %290, align 8
  %292 = zext i32 %291 to i64
  %293 = getelementptr inbounds i8, ptr %288, i64 %292
  %294 = load i32, ptr %9, align 4
  %295 = call i32 @tinfl_decompress(ptr noundef %279, ptr noundef %282, ptr noundef %10, ptr noundef %285, ptr noundef %293, ptr noundef %11, i32 noundef %294)
  store i32 %295, ptr %13, align 4
  %296 = load i32, ptr %13, align 4
  %297 = load ptr, ptr %6, align 8
  %298 = getelementptr inbounds %struct.inflate_state, ptr %297, i32 0, i32 7
  store i32 %296, ptr %298, align 4
  %299 = load i64, ptr %10, align 8
  %300 = trunc i64 %299 to i32
  %301 = load ptr, ptr %4, align 8
  %302 = getelementptr inbounds %struct.mz_stream_s, ptr %301, i32 0, i32 0
  %303 = load ptr, ptr %302, align 8
  %304 = zext i32 %300 to i64
  %305 = getelementptr inbounds i8, ptr %303, i64 %304
  store ptr %305, ptr %302, align 8
  %306 = load i64, ptr %10, align 8
  %307 = trunc i64 %306 to i32
  %308 = load ptr, ptr %4, align 8
  %309 = getelementptr inbounds %struct.mz_stream_s, ptr %308, i32 0, i32 1
  %310 = load i32, ptr %309, align 8
  %311 = sub i32 %310, %307
  store i32 %311, ptr %309, align 8
  %312 = load i64, ptr %10, align 8
  %313 = trunc i64 %312 to i32
  %314 = zext i32 %313 to i64
  %315 = load ptr, ptr %4, align 8
  %316 = getelementptr inbounds %struct.mz_stream_s, ptr %315, i32 0, i32 2
  %317 = load i64, ptr %316, align 8
  %318 = add i64 %317, %314
  store i64 %318, ptr %316, align 8
  %319 = load ptr, ptr %6, align 8
  %320 = getelementptr inbounds %struct.inflate_state, ptr %319, i32 0, i32 0
  %321 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %320, i32 0, i32 8
  %322 = load i32, ptr %321, align 8
  %323 = zext i32 %322 to i64
  %324 = load ptr, ptr %4, align 8
  %325 = getelementptr inbounds %struct.mz_stream_s, ptr %324, i32 0, i32 12
  store i64 %323, ptr %325, align 8
  %326 = load ptr, ptr %6, align 8
  %327 = getelementptr inbounds %struct.inflate_state, ptr %326, i32 0, i32 0
  %328 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %327, i32 0, i32 9
  %329 = load i32, ptr %328, align 4
  %330 = zext i32 %329 to i64
  %331 = load ptr, ptr %4, align 8
  %332 = getelementptr inbounds %struct.mz_stream_s, ptr %331, i32 0, i32 13
  store i64 %330, ptr %332, align 8
  %333 = load i64, ptr %11, align 8
  %334 = trunc i64 %333 to i32
  %335 = load ptr, ptr %6, align 8
  %336 = getelementptr inbounds %struct.inflate_state, ptr %335, i32 0, i32 2
  store i32 %334, ptr %336, align 4
  %337 = load ptr, ptr %6, align 8
  %338 = getelementptr inbounds %struct.inflate_state, ptr %337, i32 0, i32 2
  %339 = load i32, ptr %338, align 4
  %340 = load ptr, ptr %4, align 8
  %341 = getelementptr inbounds %struct.mz_stream_s, ptr %340, i32 0, i32 4
  %342 = load i32, ptr %341, align 8
  %343 = icmp ult i32 %339, %342
  br i1 %343, label %344, label %348

344:                                              ; preds = %268
  %345 = load ptr, ptr %6, align 8
  %346 = getelementptr inbounds %struct.inflate_state, ptr %345, i32 0, i32 2
  %347 = load i32, ptr %346, align 4
  br label %352

348:                                              ; preds = %268
  %349 = load ptr, ptr %4, align 8
  %350 = getelementptr inbounds %struct.mz_stream_s, ptr %349, i32 0, i32 4
  %351 = load i32, ptr %350, align 8
  br label %352

352:                                              ; preds = %348, %344
  %353 = phi i32 [ %347, %344 ], [ %351, %348 ]
  store i32 %353, ptr %7, align 4
  %354 = load ptr, ptr %4, align 8
  %355 = getelementptr inbounds %struct.mz_stream_s, ptr %354, i32 0, i32 3
  %356 = load ptr, ptr %355, align 8
  %357 = load ptr, ptr %6, align 8
  %358 = getelementptr inbounds %struct.inflate_state, ptr %357, i32 0, i32 6
  %359 = getelementptr inbounds [32768 x i8], ptr %358, i64 0, i64 0
  %360 = load ptr, ptr %6, align 8
  %361 = getelementptr inbounds %struct.inflate_state, ptr %360, i32 0, i32 1
  %362 = load i32, ptr %361, align 8
  %363 = zext i32 %362 to i64
  %364 = getelementptr inbounds i8, ptr %359, i64 %363
  %365 = load i32, ptr %7, align 4
  %366 = zext i32 %365 to i64
  %367 = load ptr, ptr %4, align 8
  %368 = getelementptr inbounds %struct.mz_stream_s, ptr %367, i32 0, i32 3
  %369 = load ptr, ptr %368, align 8
  %370 = call i64 @llvm.objectsize.i64.p0(ptr %369, i1 false, i1 true, i1 false)
  %371 = call ptr @__memcpy_chk(ptr noundef %356, ptr noundef %364, i64 noundef %366, i64 noundef %370) #12
  %372 = load i32, ptr %7, align 4
  %373 = load ptr, ptr %4, align 8
  %374 = getelementptr inbounds %struct.mz_stream_s, ptr %373, i32 0, i32 3
  %375 = load ptr, ptr %374, align 8
  %376 = zext i32 %372 to i64
  %377 = getelementptr inbounds i8, ptr %375, i64 %376
  store ptr %377, ptr %374, align 8
  %378 = load i32, ptr %7, align 4
  %379 = load ptr, ptr %4, align 8
  %380 = getelementptr inbounds %struct.mz_stream_s, ptr %379, i32 0, i32 4
  %381 = load i32, ptr %380, align 8
  %382 = sub i32 %381, %378
  store i32 %382, ptr %380, align 8
  %383 = load i32, ptr %7, align 4
  %384 = zext i32 %383 to i64
  %385 = load ptr, ptr %4, align 8
  %386 = getelementptr inbounds %struct.mz_stream_s, ptr %385, i32 0, i32 5
  %387 = load i64, ptr %386, align 8
  %388 = add i64 %387, %384
  store i64 %388, ptr %386, align 8
  %389 = load i32, ptr %7, align 4
  %390 = load ptr, ptr %6, align 8
  %391 = getelementptr inbounds %struct.inflate_state, ptr %390, i32 0, i32 2
  %392 = load i32, ptr %391, align 4
  %393 = sub i32 %392, %389
  store i32 %393, ptr %391, align 4
  %394 = load ptr, ptr %6, align 8
  %395 = getelementptr inbounds %struct.inflate_state, ptr %394, i32 0, i32 1
  %396 = load i32, ptr %395, align 8
  %397 = load i32, ptr %7, align 4
  %398 = add i32 %396, %397
  %399 = and i32 %398, 32767
  %400 = load ptr, ptr %6, align 8
  %401 = getelementptr inbounds %struct.inflate_state, ptr %400, i32 0, i32 1
  store i32 %399, ptr %401, align 8
  %402 = load i32, ptr %13, align 4
  %403 = icmp slt i32 %402, 0
  br i1 %403, label %404, label %405

404:                                              ; preds = %352
  store i32 -3, ptr %3, align 4
  br label %469

405:                                              ; preds = %352
  %406 = load i32, ptr %13, align 4
  %407 = icmp eq i32 %406, 1
  br i1 %407, label %408, label %412

408:                                              ; preds = %405
  %409 = load i64, ptr %12, align 8
  %410 = icmp ne i64 %409, 0
  br i1 %410, label %412, label %411

411:                                              ; preds = %408
  store i32 -5, ptr %3, align 4
  br label %469

412:                                              ; preds = %408, %405
  %413 = load i32, ptr %5, align 4
  %414 = icmp eq i32 %413, 4
  br i1 %414, label %415, label %433

415:                                              ; preds = %412
  %416 = load i32, ptr %13, align 4
  %417 = icmp eq i32 %416, 0
  br i1 %417, label %418, label %425

418:                                              ; preds = %415
  %419 = load ptr, ptr %6, align 8
  %420 = getelementptr inbounds %struct.inflate_state, ptr %419, i32 0, i32 2
  %421 = load i32, ptr %420, align 4
  %422 = icmp ne i32 %421, 0
  %423 = zext i1 %422 to i64
  %424 = select i1 %422, i32 -5, i32 1
  store i32 %424, ptr %3, align 4
  br label %469

425:                                              ; preds = %415
  %426 = load ptr, ptr %4, align 8
  %427 = getelementptr inbounds %struct.mz_stream_s, ptr %426, i32 0, i32 4
  %428 = load i32, ptr %427, align 8
  %429 = icmp ne i32 %428, 0
  br i1 %429, label %431, label %430

430:                                              ; preds = %425
  store i32 -5, ptr %3, align 4
  br label %469

431:                                              ; preds = %425
  br label %432

432:                                              ; preds = %431
  br label %453

433:                                              ; preds = %412
  %434 = load i32, ptr %13, align 4
  %435 = icmp eq i32 %434, 0
  br i1 %435, label %451, label %436

436:                                              ; preds = %433
  %437 = load ptr, ptr %4, align 8
  %438 = getelementptr inbounds %struct.mz_stream_s, ptr %437, i32 0, i32 1
  %439 = load i32, ptr %438, align 8
  %440 = icmp ne i32 %439, 0
  br i1 %440, label %441, label %451

441:                                              ; preds = %436
  %442 = load ptr, ptr %4, align 8
  %443 = getelementptr inbounds %struct.mz_stream_s, ptr %442, i32 0, i32 4
  %444 = load i32, ptr %443, align 8
  %445 = icmp ne i32 %444, 0
  br i1 %445, label %446, label %451

446:                                              ; preds = %441
  %447 = load ptr, ptr %6, align 8
  %448 = getelementptr inbounds %struct.inflate_state, ptr %447, i32 0, i32 2
  %449 = load i32, ptr %448, align 4
  %450 = icmp ne i32 %449, 0
  br i1 %450, label %451, label %452

451:                                              ; preds = %446, %441, %436, %433
  br label %456

452:                                              ; preds = %446
  br label %453

453:                                              ; preds = %452, %432
  br label %454

454:                                              ; preds = %453
  br label %455

455:                                              ; preds = %454
  br label %268

456:                                              ; preds = %451
  %457 = load i32, ptr %13, align 4
  %458 = icmp eq i32 %457, 0
  br i1 %458, label %459, label %465

459:                                              ; preds = %456
  %460 = load ptr, ptr %6, align 8
  %461 = getelementptr inbounds %struct.inflate_state, ptr %460, i32 0, i32 2
  %462 = load i32, ptr %461, align 4
  %463 = icmp ne i32 %462, 0
  %464 = xor i1 %463, true
  br label %465

465:                                              ; preds = %459, %456
  %466 = phi i1 [ false, %456 ], [ %464, %459 ]
  %467 = zext i1 %466 to i64
  %468 = select i1 %466, i32 1, i32 0
  store i32 %468, ptr %3, align 4
  br label %469

469:                                              ; preds = %465, %430, %418, %411, %404, %263, %175, %171, %167, %70, %61, %35, %21
  %470 = load i32, ptr %3, align 4
  ret i32 %470
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tinfl_decompress(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, ptr noundef %4, ptr noundef %5, i32 noundef %6) #0 {
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i64, align 8
  %22 = alloca ptr, align 8
  %23 = alloca ptr, align 8
  %24 = alloca ptr, align 8
  %25 = alloca ptr, align 8
  %26 = alloca i64, align 8
  %27 = alloca i64, align 8
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i64, align 8
  %33 = alloca ptr, align 8
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca i32, align 4
  %40 = alloca ptr, align 8
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  %43 = alloca i32, align 4
  %44 = alloca i32, align 4
  %45 = alloca i32, align 4
  %46 = alloca [17 x i32], align 16
  %47 = alloca [16 x i32], align 16
  %48 = alloca i32, align 4
  %49 = alloca i32, align 4
  %50 = alloca i32, align 4
  %51 = alloca i32, align 4
  %52 = alloca i32, align 2
  %53 = alloca i32, align 4
  %54 = alloca i32, align 4
  %55 = alloca i32, align 4
  %56 = alloca i32, align 4
  %57 = alloca i32, align 4
  %58 = alloca ptr, align 8
  %59 = alloca i32, align 4
  %60 = alloca i32, align 4
  %61 = alloca i32, align 4
  %62 = alloca i32, align 4
  %63 = alloca i32, align 4
  %64 = alloca i32, align 4
  %65 = alloca i32, align 4
  %66 = alloca i32, align 4
  %67 = alloca i32, align 4
  %68 = alloca i32, align 4
  %69 = alloca i32, align 4
  %70 = alloca i32, align 4
  %71 = alloca ptr, align 8
  %72 = alloca i32, align 4
  %73 = alloca i32, align 4
  %74 = alloca i32, align 4
  %75 = alloca ptr, align 8
  %76 = alloca i64, align 8
  %77 = alloca i32, align 4
  %78 = alloca i32, align 4
  %79 = alloca i32, align 4
  %80 = alloca i64, align 8
  store ptr %0, ptr %9, align 8
  store ptr %1, ptr %10, align 8
  store ptr %2, ptr %11, align 8
  store ptr %3, ptr %12, align 8
  store ptr %4, ptr %13, align 8
  store ptr %5, ptr %14, align 8
  store i32 %6, ptr %15, align 4
  store i32 -1, ptr %16, align 4
  %81 = load ptr, ptr %10, align 8
  store ptr %81, ptr %22, align 8
  %82 = load ptr, ptr %10, align 8
  %83 = load ptr, ptr %11, align 8
  %84 = load i64, ptr %83, align 8
  %85 = getelementptr inbounds i8, ptr %82, i64 %84
  store ptr %85, ptr %23, align 8
  %86 = load ptr, ptr %13, align 8
  store ptr %86, ptr %24, align 8
  %87 = load ptr, ptr %13, align 8
  %88 = load ptr, ptr %14, align 8
  %89 = load i64, ptr %88, align 8
  %90 = getelementptr inbounds i8, ptr %87, i64 %89
  store ptr %90, ptr %25, align 8
  %91 = load i32, ptr %15, align 4
  %92 = and i32 %91, 4
  %93 = icmp ne i32 %92, 0
  br i1 %93, label %94, label %95

94:                                               ; preds = %7
  br label %105

95:                                               ; preds = %7
  %96 = load ptr, ptr %13, align 8
  %97 = load ptr, ptr %12, align 8
  %98 = ptrtoint ptr %96 to i64
  %99 = ptrtoint ptr %97 to i64
  %100 = sub i64 %98, %99
  %101 = load ptr, ptr %14, align 8
  %102 = load i64, ptr %101, align 8
  %103 = add i64 %100, %102
  %104 = sub i64 %103, 1
  br label %105

105:                                              ; preds = %95, %94
  %106 = phi i64 [ -1, %94 ], [ %104, %95 ]
  store i64 %106, ptr %26, align 8
  %107 = load i64, ptr %26, align 8
  %108 = add i64 %107, 1
  %109 = load i64, ptr %26, align 8
  %110 = and i64 %108, %109
  %111 = icmp ne i64 %110, 0
  br i1 %111, label %116, label %112

112:                                              ; preds = %105
  %113 = load ptr, ptr %13, align 8
  %114 = load ptr, ptr %12, align 8
  %115 = icmp ult ptr %113, %114
  br i1 %115, label %116, label %119

116:                                              ; preds = %112, %105
  %117 = load ptr, ptr %14, align 8
  store i64 0, ptr %117, align 8
  %118 = load ptr, ptr %11, align 8
  store i64 0, ptr %118, align 8
  store i32 -3, ptr %8, align 4
  br label %3096

119:                                              ; preds = %112
  %120 = load ptr, ptr %9, align 8
  %121 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %120, i32 0, i32 1
  %122 = load i32, ptr %121, align 4
  store i32 %122, ptr %17, align 4
  %123 = load ptr, ptr %9, align 8
  %124 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %123, i32 0, i32 14
  %125 = load i64, ptr %124, align 8
  store i64 %125, ptr %21, align 8
  %126 = load ptr, ptr %9, align 8
  %127 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %126, i32 0, i32 10
  %128 = load i32, ptr %127, align 8
  store i32 %128, ptr %18, align 4
  %129 = load ptr, ptr %9, align 8
  %130 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %129, i32 0, i32 11
  %131 = load i32, ptr %130, align 4
  store i32 %131, ptr %19, align 4
  %132 = load ptr, ptr %9, align 8
  %133 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %132, i32 0, i32 12
  %134 = load i32, ptr %133, align 8
  store i32 %134, ptr %20, align 4
  %135 = load ptr, ptr %9, align 8
  %136 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %135, i32 0, i32 15
  %137 = load i64, ptr %136, align 8
  store i64 %137, ptr %27, align 8
  %138 = load ptr, ptr %9, align 8
  %139 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %138, i32 0, i32 0
  %140 = load i32, ptr %139, align 8
  switch i32 %140, label %2904 [
    i32 0, label %141
    i32 1, label %167
    i32 2, label %207
    i32 36, label %295
    i32 3, label %319
    i32 5, label %395
    i32 6, label %467
    i32 7, label %529
    i32 39, label %600
    i32 51, label %631
    i32 52, label %682
    i32 9, label %704
    i32 38, label %719
    i32 40, label %727
    i32 10, label %819
    i32 11, label %919
    i32 14, label %1042
    i32 35, label %1194
    i32 16, label %1459
    i32 17, label %1589
    i32 18, label %1618
    i32 21, label %1728
    i32 23, label %1887
    i32 24, label %2006
    i32 25, label %2181
    i32 26, label %2322
    i32 27, label %2459
    i32 37, label %2533
    i32 53, label %2573
    i32 32, label %2732
    i32 41, label %2804
    i32 42, label %2861
    i32 34, label %2901
  ]

141:                                              ; preds = %119
  %142 = load ptr, ptr %9, align 8
  %143 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %142, i32 0, i32 3
  store i32 0, ptr %143, align 4
  %144 = load ptr, ptr %9, align 8
  %145 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %144, i32 0, i32 2
  store i32 0, ptr %145, align 8
  store i32 0, ptr %20, align 4
  store i32 0, ptr %19, align 4
  store i32 0, ptr %18, align 4
  store i32 0, ptr %17, align 4
  store i64 0, ptr %21, align 8
  %146 = load ptr, ptr %9, align 8
  %147 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %146, i32 0, i32 8
  store i32 1, ptr %147, align 8
  %148 = load ptr, ptr %9, align 8
  %149 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %148, i32 0, i32 4
  store i32 1, ptr %149, align 8
  %150 = load i32, ptr %15, align 4
  %151 = and i32 %150, 1
  %152 = icmp ne i32 %151, 0
  br i1 %152, label %153, label %299

153:                                              ; preds = %141
  br label %154

154:                                              ; preds = %153
  %155 = load ptr, ptr %22, align 8
  %156 = load ptr, ptr %23, align 8
  %157 = icmp uge ptr %155, %156
  br i1 %157, label %158, label %185

158:                                              ; preds = %154
  br label %159

159:                                              ; preds = %183, %158
  %160 = load i32, ptr %15, align 4
  %161 = and i32 %160, 2
  %162 = icmp ne i32 %161, 0
  br i1 %162, label %163, label %180

163:                                              ; preds = %159
  br label %164

164:                                              ; preds = %163
  store i32 1, ptr %16, align 4
  %165 = load ptr, ptr %9, align 8
  %166 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %165, i32 0, i32 0
  store i32 1, ptr %166, align 8
  br label %2905

167:                                              ; preds = %119
  br label %168

168:                                              ; preds = %167
  %169 = load ptr, ptr %22, align 8
  %170 = load ptr, ptr %23, align 8
  %171 = icmp ult ptr %169, %170
  br i1 %171, label %172, label %179

172:                                              ; preds = %168
  %173 = load ptr, ptr %22, align 8
  %174 = getelementptr inbounds i8, ptr %173, i32 1
  store ptr %174, ptr %22, align 8
  %175 = load i8, ptr %173, align 1
  %176 = zext i8 %175 to i32
  %177 = load ptr, ptr %9, align 8
  %178 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %177, i32 0, i32 2
  store i32 %176, ptr %178, align 8
  br label %184

179:                                              ; preds = %168
  br label %183

180:                                              ; preds = %159
  %181 = load ptr, ptr %9, align 8
  %182 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %181, i32 0, i32 2
  store i32 0, ptr %182, align 8
  br label %184

183:                                              ; preds = %179
  br label %159

184:                                              ; preds = %180, %172
  br label %192

185:                                              ; preds = %154
  %186 = load ptr, ptr %22, align 8
  %187 = getelementptr inbounds i8, ptr %186, i32 1
  store ptr %187, ptr %22, align 8
  %188 = load i8, ptr %186, align 1
  %189 = zext i8 %188 to i32
  %190 = load ptr, ptr %9, align 8
  %191 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %190, i32 0, i32 2
  store i32 %189, ptr %191, align 8
  br label %192

192:                                              ; preds = %185, %184
  br label %193

193:                                              ; preds = %192
  br label %194

194:                                              ; preds = %193
  %195 = load ptr, ptr %22, align 8
  %196 = load ptr, ptr %23, align 8
  %197 = icmp uge ptr %195, %196
  br i1 %197, label %198, label %225

198:                                              ; preds = %194
  br label %199

199:                                              ; preds = %223, %198
  %200 = load i32, ptr %15, align 4
  %201 = and i32 %200, 2
  %202 = icmp ne i32 %201, 0
  br i1 %202, label %203, label %220

203:                                              ; preds = %199
  br label %204

204:                                              ; preds = %203
  store i32 1, ptr %16, align 4
  %205 = load ptr, ptr %9, align 8
  %206 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %205, i32 0, i32 0
  store i32 2, ptr %206, align 8
  br label %2905

207:                                              ; preds = %119
  br label %208

208:                                              ; preds = %207
  %209 = load ptr, ptr %22, align 8
  %210 = load ptr, ptr %23, align 8
  %211 = icmp ult ptr %209, %210
  br i1 %211, label %212, label %219

212:                                              ; preds = %208
  %213 = load ptr, ptr %22, align 8
  %214 = getelementptr inbounds i8, ptr %213, i32 1
  store ptr %214, ptr %22, align 8
  %215 = load i8, ptr %213, align 1
  %216 = zext i8 %215 to i32
  %217 = load ptr, ptr %9, align 8
  %218 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %217, i32 0, i32 3
  store i32 %216, ptr %218, align 4
  br label %224

219:                                              ; preds = %208
  br label %223

220:                                              ; preds = %199
  %221 = load ptr, ptr %9, align 8
  %222 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %221, i32 0, i32 3
  store i32 0, ptr %222, align 4
  br label %224

223:                                              ; preds = %219
  br label %199

224:                                              ; preds = %220, %212
  br label %232

225:                                              ; preds = %194
  %226 = load ptr, ptr %22, align 8
  %227 = getelementptr inbounds i8, ptr %226, i32 1
  store ptr %227, ptr %22, align 8
  %228 = load i8, ptr %226, align 1
  %229 = zext i8 %228 to i32
  %230 = load ptr, ptr %9, align 8
  %231 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %230, i32 0, i32 3
  store i32 %229, ptr %231, align 4
  br label %232

232:                                              ; preds = %225, %224
  br label %233

233:                                              ; preds = %232
  %234 = load ptr, ptr %9, align 8
  %235 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %234, i32 0, i32 2
  %236 = load i32, ptr %235, align 8
  %237 = mul i32 %236, 256
  %238 = load ptr, ptr %9, align 8
  %239 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %238, i32 0, i32 3
  %240 = load i32, ptr %239, align 4
  %241 = add i32 %237, %240
  %242 = urem i32 %241, 31
  %243 = icmp ne i32 %242, 0
  br i1 %243, label %256, label %244

244:                                              ; preds = %233
  %245 = load ptr, ptr %9, align 8
  %246 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %245, i32 0, i32 3
  %247 = load i32, ptr %246, align 4
  %248 = and i32 %247, 32
  %249 = icmp ne i32 %248, 0
  br i1 %249, label %256, label %250

250:                                              ; preds = %244
  %251 = load ptr, ptr %9, align 8
  %252 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %251, i32 0, i32 2
  %253 = load i32, ptr %252, align 8
  %254 = and i32 %253, 15
  %255 = icmp ne i32 %254, 8
  br label %256

256:                                              ; preds = %250, %244, %233
  %257 = phi i1 [ true, %244 ], [ true, %233 ], [ %255, %250 ]
  %258 = zext i1 %257 to i32
  store i32 %258, ptr %19, align 4
  %259 = load i32, ptr %15, align 4
  %260 = and i32 %259, 4
  %261 = icmp ne i32 %260, 0
  br i1 %261, label %286, label %262

262:                                              ; preds = %256
  %263 = load ptr, ptr %9, align 8
  %264 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %263, i32 0, i32 2
  %265 = load i32, ptr %264, align 8
  %266 = lshr i32 %265, 4
  %267 = add i32 8, %266
  %268 = shl i32 1, %267
  %269 = icmp ugt i32 %268, 32768
  br i1 %269, label %281, label %270

270:                                              ; preds = %262
  %271 = load i64, ptr %26, align 8
  %272 = add i64 %271, 1
  %273 = load ptr, ptr %9, align 8
  %274 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %273, i32 0, i32 2
  %275 = load i32, ptr %274, align 8
  %276 = lshr i32 %275, 4
  %277 = add i32 8, %276
  %278 = shl i32 1, %277
  %279 = zext i32 %278 to i64
  %280 = icmp ult i64 %272, %279
  br label %281

281:                                              ; preds = %270, %262
  %282 = phi i1 [ true, %262 ], [ %280, %270 ]
  %283 = zext i1 %282 to i32
  %284 = load i32, ptr %19, align 4
  %285 = or i32 %284, %283
  store i32 %285, ptr %19, align 4
  br label %286

286:                                              ; preds = %281, %256
  %287 = load i32, ptr %19, align 4
  %288 = icmp ne i32 %287, 0
  br i1 %288, label %289, label %298

289:                                              ; preds = %286
  br label %290

290:                                              ; preds = %289
  br label %291

291:                                              ; preds = %296, %290
  br label %292

292:                                              ; preds = %291
  store i32 -1, ptr %16, align 4
  %293 = load ptr, ptr %9, align 8
  %294 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %293, i32 0, i32 0
  store i32 36, ptr %294, align 8
  br label %2905

295:                                              ; preds = %119
  br label %296

296:                                              ; preds = %295
  br label %291

297:                                              ; No predecessors!
  br label %298

298:                                              ; preds = %297, %286
  br label %299

299:                                              ; preds = %298, %141
  br label %300

300:                                              ; preds = %2700, %299
  br label %301

301:                                              ; preds = %300
  %302 = load i32, ptr %17, align 4
  %303 = icmp ult i32 %302, 3
  br i1 %303, label %304, label %353

304:                                              ; preds = %301
  br label %305

305:                                              ; preds = %349, %304
  br label %306

306:                                              ; preds = %305
  %307 = load ptr, ptr %22, align 8
  %308 = load ptr, ptr %23, align 8
  %309 = icmp uge ptr %307, %308
  br i1 %309, label %310, label %333

310:                                              ; preds = %306
  br label %311

311:                                              ; preds = %331, %310
  %312 = load i32, ptr %15, align 4
  %313 = and i32 %312, 2
  %314 = icmp ne i32 %313, 0
  br i1 %314, label %315, label %330

315:                                              ; preds = %311
  br label %316

316:                                              ; preds = %315
  store i32 1, ptr %16, align 4
  %317 = load ptr, ptr %9, align 8
  %318 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %317, i32 0, i32 0
  store i32 3, ptr %318, align 8
  br label %2905

319:                                              ; preds = %119
  br label %320

320:                                              ; preds = %319
  %321 = load ptr, ptr %22, align 8
  %322 = load ptr, ptr %23, align 8
  %323 = icmp ult ptr %321, %322
  br i1 %323, label %324, label %329

324:                                              ; preds = %320
  %325 = load ptr, ptr %22, align 8
  %326 = getelementptr inbounds i8, ptr %325, i32 1
  store ptr %326, ptr %22, align 8
  %327 = load i8, ptr %325, align 1
  %328 = zext i8 %327 to i32
  store i32 %328, ptr %28, align 4
  br label %332

329:                                              ; preds = %320
  br label %331

330:                                              ; preds = %311
  store i32 0, ptr %28, align 4
  br label %332

331:                                              ; preds = %329
  br label %311

332:                                              ; preds = %330, %324
  br label %338

333:                                              ; preds = %306
  %334 = load ptr, ptr %22, align 8
  %335 = getelementptr inbounds i8, ptr %334, i32 1
  store ptr %335, ptr %22, align 8
  %336 = load i8, ptr %334, align 1
  %337 = zext i8 %336 to i32
  store i32 %337, ptr %28, align 4
  br label %338

338:                                              ; preds = %333, %332
  br label %339

339:                                              ; preds = %338
  %340 = load i32, ptr %28, align 4
  %341 = zext i32 %340 to i64
  %342 = load i32, ptr %17, align 4
  %343 = zext i32 %342 to i64
  %344 = shl i64 %341, %343
  %345 = load i64, ptr %21, align 8
  %346 = or i64 %345, %344
  store i64 %346, ptr %21, align 8
  %347 = load i32, ptr %17, align 4
  %348 = add i32 %347, 8
  store i32 %348, ptr %17, align 4
  br label %349

349:                                              ; preds = %339
  %350 = load i32, ptr %17, align 4
  %351 = icmp ult i32 %350, 3
  br i1 %351, label %305, label %352, !llvm.loop !10

352:                                              ; preds = %349
  br label %353

353:                                              ; preds = %352, %301
  %354 = load i64, ptr %21, align 8
  %355 = and i64 %354, 7
  %356 = trunc i64 %355 to i32
  %357 = load ptr, ptr %9, align 8
  %358 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %357, i32 0, i32 6
  store i32 %356, ptr %358, align 8
  %359 = load i64, ptr %21, align 8
  %360 = lshr i64 %359, 3
  store i64 %360, ptr %21, align 8
  %361 = load i32, ptr %17, align 4
  %362 = sub i32 %361, 3
  store i32 %362, ptr %17, align 4
  br label %363

363:                                              ; preds = %353
  %364 = load ptr, ptr %9, align 8
  %365 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %364, i32 0, i32 6
  %366 = load i32, ptr %365, align 8
  %367 = lshr i32 %366, 1
  %368 = load ptr, ptr %9, align 8
  %369 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %368, i32 0, i32 7
  store i32 %367, ptr %369, align 4
  %370 = load ptr, ptr %9, align 8
  %371 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %370, i32 0, i32 7
  %372 = load i32, ptr %371, align 4
  %373 = icmp eq i32 %372, 0
  br i1 %373, label %374, label %808

374:                                              ; preds = %363
  br label %375

375:                                              ; preds = %374
  %376 = load i32, ptr %17, align 4
  %377 = load i32, ptr %17, align 4
  %378 = and i32 %377, 7
  %379 = icmp ult i32 %376, %378
  br i1 %379, label %380, label %431

380:                                              ; preds = %375
  br label %381

381:                                              ; preds = %425, %380
  br label %382

382:                                              ; preds = %381
  %383 = load ptr, ptr %22, align 8
  %384 = load ptr, ptr %23, align 8
  %385 = icmp uge ptr %383, %384
  br i1 %385, label %386, label %409

386:                                              ; preds = %382
  br label %387

387:                                              ; preds = %407, %386
  %388 = load i32, ptr %15, align 4
  %389 = and i32 %388, 2
  %390 = icmp ne i32 %389, 0
  br i1 %390, label %391, label %406

391:                                              ; preds = %387
  br label %392

392:                                              ; preds = %391
  store i32 1, ptr %16, align 4
  %393 = load ptr, ptr %9, align 8
  %394 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %393, i32 0, i32 0
  store i32 5, ptr %394, align 8
  br label %2905

395:                                              ; preds = %119
  br label %396

396:                                              ; preds = %395
  %397 = load ptr, ptr %22, align 8
  %398 = load ptr, ptr %23, align 8
  %399 = icmp ult ptr %397, %398
  br i1 %399, label %400, label %405

400:                                              ; preds = %396
  %401 = load ptr, ptr %22, align 8
  %402 = getelementptr inbounds i8, ptr %401, i32 1
  store ptr %402, ptr %22, align 8
  %403 = load i8, ptr %401, align 1
  %404 = zext i8 %403 to i32
  store i32 %404, ptr %29, align 4
  br label %408

405:                                              ; preds = %396
  br label %407

406:                                              ; preds = %387
  store i32 0, ptr %29, align 4
  br label %408

407:                                              ; preds = %405
  br label %387

408:                                              ; preds = %406, %400
  br label %414

409:                                              ; preds = %382
  %410 = load ptr, ptr %22, align 8
  %411 = getelementptr inbounds i8, ptr %410, i32 1
  store ptr %411, ptr %22, align 8
  %412 = load i8, ptr %410, align 1
  %413 = zext i8 %412 to i32
  store i32 %413, ptr %29, align 4
  br label %414

414:                                              ; preds = %409, %408
  br label %415

415:                                              ; preds = %414
  %416 = load i32, ptr %29, align 4
  %417 = zext i32 %416 to i64
  %418 = load i32, ptr %17, align 4
  %419 = zext i32 %418 to i64
  %420 = shl i64 %417, %419
  %421 = load i64, ptr %21, align 8
  %422 = or i64 %421, %420
  store i64 %422, ptr %21, align 8
  %423 = load i32, ptr %17, align 4
  %424 = add i32 %423, 8
  store i32 %424, ptr %17, align 4
  br label %425

425:                                              ; preds = %415
  %426 = load i32, ptr %17, align 4
  %427 = load i32, ptr %17, align 4
  %428 = and i32 %427, 7
  %429 = icmp ult i32 %426, %428
  br i1 %429, label %381, label %430, !llvm.loop !11

430:                                              ; preds = %425
  br label %431

431:                                              ; preds = %430, %375
  %432 = load i32, ptr %17, align 4
  %433 = and i32 %432, 7
  %434 = load i64, ptr %21, align 8
  %435 = zext i32 %433 to i64
  %436 = lshr i64 %434, %435
  store i64 %436, ptr %21, align 8
  %437 = load i32, ptr %17, align 4
  %438 = and i32 %437, 7
  %439 = load i32, ptr %17, align 4
  %440 = sub i32 %439, %438
  store i32 %440, ptr %17, align 4
  br label %441

441:                                              ; preds = %431
  store i32 0, ptr %19, align 4
  br label %442

442:                                              ; preds = %564, %441
  %443 = load i32, ptr %19, align 4
  %444 = icmp ult i32 %443, 4
  br i1 %444, label %445, label %567

445:                                              ; preds = %442
  %446 = load i32, ptr %17, align 4
  %447 = icmp ne i32 %446, 0
  br i1 %447, label %448, label %515

448:                                              ; preds = %445
  br label %449

449:                                              ; preds = %448
  %450 = load i32, ptr %17, align 4
  %451 = icmp ult i32 %450, 8
  br i1 %451, label %452, label %501

452:                                              ; preds = %449
  br label %453

453:                                              ; preds = %497, %452
  br label %454

454:                                              ; preds = %453
  %455 = load ptr, ptr %22, align 8
  %456 = load ptr, ptr %23, align 8
  %457 = icmp uge ptr %455, %456
  br i1 %457, label %458, label %481

458:                                              ; preds = %454
  br label %459

459:                                              ; preds = %479, %458
  %460 = load i32, ptr %15, align 4
  %461 = and i32 %460, 2
  %462 = icmp ne i32 %461, 0
  br i1 %462, label %463, label %478

463:                                              ; preds = %459
  br label %464

464:                                              ; preds = %463
  store i32 1, ptr %16, align 4
  %465 = load ptr, ptr %9, align 8
  %466 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %465, i32 0, i32 0
  store i32 6, ptr %466, align 8
  br label %2905

467:                                              ; preds = %119
  br label %468

468:                                              ; preds = %467
  %469 = load ptr, ptr %22, align 8
  %470 = load ptr, ptr %23, align 8
  %471 = icmp ult ptr %469, %470
  br i1 %471, label %472, label %477

472:                                              ; preds = %468
  %473 = load ptr, ptr %22, align 8
  %474 = getelementptr inbounds i8, ptr %473, i32 1
  store ptr %474, ptr %22, align 8
  %475 = load i8, ptr %473, align 1
  %476 = zext i8 %475 to i32
  store i32 %476, ptr %30, align 4
  br label %480

477:                                              ; preds = %468
  br label %479

478:                                              ; preds = %459
  store i32 0, ptr %30, align 4
  br label %480

479:                                              ; preds = %477
  br label %459

480:                                              ; preds = %478, %472
  br label %486

481:                                              ; preds = %454
  %482 = load ptr, ptr %22, align 8
  %483 = getelementptr inbounds i8, ptr %482, i32 1
  store ptr %483, ptr %22, align 8
  %484 = load i8, ptr %482, align 1
  %485 = zext i8 %484 to i32
  store i32 %485, ptr %30, align 4
  br label %486

486:                                              ; preds = %481, %480
  br label %487

487:                                              ; preds = %486
  %488 = load i32, ptr %30, align 4
  %489 = zext i32 %488 to i64
  %490 = load i32, ptr %17, align 4
  %491 = zext i32 %490 to i64
  %492 = shl i64 %489, %491
  %493 = load i64, ptr %21, align 8
  %494 = or i64 %493, %492
  store i64 %494, ptr %21, align 8
  %495 = load i32, ptr %17, align 4
  %496 = add i32 %495, 8
  store i32 %496, ptr %17, align 4
  br label %497

497:                                              ; preds = %487
  %498 = load i32, ptr %17, align 4
  %499 = icmp ult i32 %498, 8
  br i1 %499, label %453, label %500, !llvm.loop !12

500:                                              ; preds = %497
  br label %501

501:                                              ; preds = %500, %449
  %502 = load i64, ptr %21, align 8
  %503 = and i64 %502, 255
  %504 = trunc i64 %503 to i8
  %505 = load ptr, ptr %9, align 8
  %506 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %505, i32 0, i32 17
  %507 = load i32, ptr %19, align 4
  %508 = zext i32 %507 to i64
  %509 = getelementptr inbounds [4 x i8], ptr %506, i64 0, i64 %508
  store i8 %504, ptr %509, align 1
  %510 = load i64, ptr %21, align 8
  %511 = lshr i64 %510, 8
  store i64 %511, ptr %21, align 8
  %512 = load i32, ptr %17, align 4
  %513 = sub i32 %512, 8
  store i32 %513, ptr %17, align 4
  br label %514

514:                                              ; preds = %501
  br label %563

515:                                              ; preds = %445
  br label %516

516:                                              ; preds = %515
  %517 = load ptr, ptr %22, align 8
  %518 = load ptr, ptr %23, align 8
  %519 = icmp uge ptr %517, %518
  br i1 %519, label %520, label %552

520:                                              ; preds = %516
  br label %521

521:                                              ; preds = %550, %520
  %522 = load i32, ptr %15, align 4
  %523 = and i32 %522, 2
  %524 = icmp ne i32 %523, 0
  br i1 %524, label %525, label %544

525:                                              ; preds = %521
  br label %526

526:                                              ; preds = %525
  store i32 1, ptr %16, align 4
  %527 = load ptr, ptr %9, align 8
  %528 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %527, i32 0, i32 0
  store i32 7, ptr %528, align 8
  br label %2905

529:                                              ; preds = %119
  br label %530

530:                                              ; preds = %529
  %531 = load ptr, ptr %22, align 8
  %532 = load ptr, ptr %23, align 8
  %533 = icmp ult ptr %531, %532
  br i1 %533, label %534, label %543

534:                                              ; preds = %530
  %535 = load ptr, ptr %22, align 8
  %536 = getelementptr inbounds i8, ptr %535, i32 1
  store ptr %536, ptr %22, align 8
  %537 = load i8, ptr %535, align 1
  %538 = load ptr, ptr %9, align 8
  %539 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %538, i32 0, i32 17
  %540 = load i32, ptr %19, align 4
  %541 = zext i32 %540 to i64
  %542 = getelementptr inbounds [4 x i8], ptr %539, i64 0, i64 %541
  store i8 %537, ptr %542, align 1
  br label %551

543:                                              ; preds = %530
  br label %550

544:                                              ; preds = %521
  %545 = load ptr, ptr %9, align 8
  %546 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %545, i32 0, i32 17
  %547 = load i32, ptr %19, align 4
  %548 = zext i32 %547 to i64
  %549 = getelementptr inbounds [4 x i8], ptr %546, i64 0, i64 %548
  store i8 0, ptr %549, align 1
  br label %551

550:                                              ; preds = %543
  br label %521

551:                                              ; preds = %544, %534
  br label %561

552:                                              ; preds = %516
  %553 = load ptr, ptr %22, align 8
  %554 = getelementptr inbounds i8, ptr %553, i32 1
  store ptr %554, ptr %22, align 8
  %555 = load i8, ptr %553, align 1
  %556 = load ptr, ptr %9, align 8
  %557 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %556, i32 0, i32 17
  %558 = load i32, ptr %19, align 4
  %559 = zext i32 %558 to i64
  %560 = getelementptr inbounds [4 x i8], ptr %557, i64 0, i64 %559
  store i8 %555, ptr %560, align 1
  br label %561

561:                                              ; preds = %552, %551
  br label %562

562:                                              ; preds = %561
  br label %563

563:                                              ; preds = %562, %514
  br label %564

564:                                              ; preds = %563
  %565 = load i32, ptr %19, align 4
  %566 = add i32 %565, 1
  store i32 %566, ptr %19, align 4
  br label %442, !llvm.loop !13

567:                                              ; preds = %442
  %568 = load ptr, ptr %9, align 8
  %569 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %568, i32 0, i32 17
  %570 = getelementptr inbounds [4 x i8], ptr %569, i64 0, i64 0
  %571 = load i8, ptr %570, align 8
  %572 = zext i8 %571 to i32
  %573 = load ptr, ptr %9, align 8
  %574 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %573, i32 0, i32 17
  %575 = getelementptr inbounds [4 x i8], ptr %574, i64 0, i64 1
  %576 = load i8, ptr %575, align 1
  %577 = zext i8 %576 to i32
  %578 = shl i32 %577, 8
  %579 = or i32 %572, %578
  store i32 %579, ptr %19, align 4
  %580 = load ptr, ptr %9, align 8
  %581 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %580, i32 0, i32 17
  %582 = getelementptr inbounds [4 x i8], ptr %581, i64 0, i64 2
  %583 = load i8, ptr %582, align 2
  %584 = zext i8 %583 to i32
  %585 = load ptr, ptr %9, align 8
  %586 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %585, i32 0, i32 17
  %587 = getelementptr inbounds [4 x i8], ptr %586, i64 0, i64 3
  %588 = load i8, ptr %587, align 1
  %589 = zext i8 %588 to i32
  %590 = shl i32 %589, 8
  %591 = or i32 %584, %590
  %592 = xor i32 65535, %591
  %593 = icmp ne i32 %579, %592
  br i1 %593, label %594, label %603

594:                                              ; preds = %567
  br label %595

595:                                              ; preds = %594
  br label %596

596:                                              ; preds = %601, %595
  br label %597

597:                                              ; preds = %596
  store i32 -1, ptr %16, align 4
  %598 = load ptr, ptr %9, align 8
  %599 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %598, i32 0, i32 0
  store i32 39, ptr %599, align 8
  br label %2905

600:                                              ; preds = %119
  br label %601

601:                                              ; preds = %600
  br label %596

602:                                              ; No predecessors!
  br label %603

603:                                              ; preds = %602, %567
  br label %604

604:                                              ; preds = %684, %603
  %605 = load i32, ptr %19, align 4
  %606 = icmp ne i32 %605, 0
  br i1 %606, label %607, label %610

607:                                              ; preds = %604
  %608 = load i32, ptr %17, align 4
  %609 = icmp ne i32 %608, 0
  br label %610

610:                                              ; preds = %607, %604
  %611 = phi i1 [ false, %604 ], [ %609, %607 ]
  br i1 %611, label %612, label %691

612:                                              ; preds = %610
  br label %613

613:                                              ; preds = %612
  %614 = load i32, ptr %17, align 4
  %615 = icmp ult i32 %614, 8
  br i1 %615, label %616, label %665

616:                                              ; preds = %613
  br label %617

617:                                              ; preds = %661, %616
  br label %618

618:                                              ; preds = %617
  %619 = load ptr, ptr %22, align 8
  %620 = load ptr, ptr %23, align 8
  %621 = icmp uge ptr %619, %620
  br i1 %621, label %622, label %645

622:                                              ; preds = %618
  br label %623

623:                                              ; preds = %643, %622
  %624 = load i32, ptr %15, align 4
  %625 = and i32 %624, 2
  %626 = icmp ne i32 %625, 0
  br i1 %626, label %627, label %642

627:                                              ; preds = %623
  br label %628

628:                                              ; preds = %627
  store i32 1, ptr %16, align 4
  %629 = load ptr, ptr %9, align 8
  %630 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %629, i32 0, i32 0
  store i32 51, ptr %630, align 8
  br label %2905

631:                                              ; preds = %119
  br label %632

632:                                              ; preds = %631
  %633 = load ptr, ptr %22, align 8
  %634 = load ptr, ptr %23, align 8
  %635 = icmp ult ptr %633, %634
  br i1 %635, label %636, label %641

636:                                              ; preds = %632
  %637 = load ptr, ptr %22, align 8
  %638 = getelementptr inbounds i8, ptr %637, i32 1
  store ptr %638, ptr %22, align 8
  %639 = load i8, ptr %637, align 1
  %640 = zext i8 %639 to i32
  store i32 %640, ptr %31, align 4
  br label %644

641:                                              ; preds = %632
  br label %643

642:                                              ; preds = %623
  store i32 0, ptr %31, align 4
  br label %644

643:                                              ; preds = %641
  br label %623

644:                                              ; preds = %642, %636
  br label %650

645:                                              ; preds = %618
  %646 = load ptr, ptr %22, align 8
  %647 = getelementptr inbounds i8, ptr %646, i32 1
  store ptr %647, ptr %22, align 8
  %648 = load i8, ptr %646, align 1
  %649 = zext i8 %648 to i32
  store i32 %649, ptr %31, align 4
  br label %650

650:                                              ; preds = %645, %644
  br label %651

651:                                              ; preds = %650
  %652 = load i32, ptr %31, align 4
  %653 = zext i32 %652 to i64
  %654 = load i32, ptr %17, align 4
  %655 = zext i32 %654 to i64
  %656 = shl i64 %653, %655
  %657 = load i64, ptr %21, align 8
  %658 = or i64 %657, %656
  store i64 %658, ptr %21, align 8
  %659 = load i32, ptr %17, align 4
  %660 = add i32 %659, 8
  store i32 %660, ptr %17, align 4
  br label %661

661:                                              ; preds = %651
  %662 = load i32, ptr %17, align 4
  %663 = icmp ult i32 %662, 8
  br i1 %663, label %617, label %664, !llvm.loop !14

664:                                              ; preds = %661
  br label %665

665:                                              ; preds = %664, %613
  %666 = load i64, ptr %21, align 8
  %667 = and i64 %666, 255
  %668 = trunc i64 %667 to i32
  store i32 %668, ptr %18, align 4
  %669 = load i64, ptr %21, align 8
  %670 = lshr i64 %669, 8
  store i64 %670, ptr %21, align 8
  %671 = load i32, ptr %17, align 4
  %672 = sub i32 %671, 8
  store i32 %672, ptr %17, align 4
  br label %673

673:                                              ; preds = %665
  br label %674

674:                                              ; preds = %683, %673
  %675 = load ptr, ptr %24, align 8
  %676 = load ptr, ptr %25, align 8
  %677 = icmp uge ptr %675, %676
  br i1 %677, label %678, label %684

678:                                              ; preds = %674
  br label %679

679:                                              ; preds = %678
  store i32 2, ptr %16, align 4
  %680 = load ptr, ptr %9, align 8
  %681 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %680, i32 0, i32 0
  store i32 52, ptr %681, align 8
  br label %2905

682:                                              ; preds = %119
  br label %683

683:                                              ; preds = %682
  br label %674, !llvm.loop !15

684:                                              ; preds = %674
  %685 = load i32, ptr %18, align 4
  %686 = trunc i32 %685 to i8
  %687 = load ptr, ptr %24, align 8
  %688 = getelementptr inbounds i8, ptr %687, i32 1
  store ptr %688, ptr %24, align 8
  store i8 %686, ptr %687, align 1
  %689 = load i32, ptr %19, align 4
  %690 = add i32 %689, -1
  store i32 %690, ptr %19, align 4
  br label %604, !llvm.loop !16

691:                                              ; preds = %610
  br label %692

692:                                              ; preds = %789, %691
  %693 = load i32, ptr %19, align 4
  %694 = icmp ne i32 %693, 0
  br i1 %694, label %695, label %807

695:                                              ; preds = %692
  br label %696

696:                                              ; preds = %705, %695
  %697 = load ptr, ptr %24, align 8
  %698 = load ptr, ptr %25, align 8
  %699 = icmp uge ptr %697, %698
  br i1 %699, label %700, label %706

700:                                              ; preds = %696
  br label %701

701:                                              ; preds = %700
  store i32 2, ptr %16, align 4
  %702 = load ptr, ptr %9, align 8
  %703 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %702, i32 0, i32 0
  store i32 9, ptr %703, align 8
  br label %2905

704:                                              ; preds = %119
  br label %705

705:                                              ; preds = %704
  br label %696, !llvm.loop !17

706:                                              ; preds = %696
  br label %707

707:                                              ; preds = %730, %706
  %708 = load ptr, ptr %22, align 8
  %709 = load ptr, ptr %23, align 8
  %710 = icmp uge ptr %708, %709
  br i1 %710, label %711, label %731

711:                                              ; preds = %707
  %712 = load i32, ptr %15, align 4
  %713 = and i32 %712, 2
  %714 = icmp ne i32 %713, 0
  br i1 %714, label %715, label %721

715:                                              ; preds = %711
  br label %716

716:                                              ; preds = %715
  store i32 1, ptr %16, align 4
  %717 = load ptr, ptr %9, align 8
  %718 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %717, i32 0, i32 0
  store i32 38, ptr %718, align 8
  br label %2905

719:                                              ; preds = %119
  br label %720

720:                                              ; preds = %719
  br label %730

721:                                              ; preds = %711
  br label %722

722:                                              ; preds = %721
  br label %723

723:                                              ; preds = %728, %722
  br label %724

724:                                              ; preds = %723
  store i32 -1, ptr %16, align 4
  %725 = load ptr, ptr %9, align 8
  %726 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %725, i32 0, i32 0
  store i32 40, ptr %726, align 8
  br label %2905

727:                                              ; preds = %119
  br label %728

728:                                              ; preds = %727
  br label %723

729:                                              ; No predecessors!
  br label %730

730:                                              ; preds = %729, %720
  br label %707, !llvm.loop !18

731:                                              ; preds = %707
  %732 = load ptr, ptr %25, align 8
  %733 = load ptr, ptr %24, align 8
  %734 = ptrtoint ptr %732 to i64
  %735 = ptrtoint ptr %733 to i64
  %736 = sub i64 %734, %735
  %737 = load ptr, ptr %23, align 8
  %738 = load ptr, ptr %22, align 8
  %739 = ptrtoint ptr %737 to i64
  %740 = ptrtoint ptr %738 to i64
  %741 = sub i64 %739, %740
  %742 = icmp ult i64 %736, %741
  br i1 %742, label %743, label %749

743:                                              ; preds = %731
  %744 = load ptr, ptr %25, align 8
  %745 = load ptr, ptr %24, align 8
  %746 = ptrtoint ptr %744 to i64
  %747 = ptrtoint ptr %745 to i64
  %748 = sub i64 %746, %747
  br label %755

749:                                              ; preds = %731
  %750 = load ptr, ptr %23, align 8
  %751 = load ptr, ptr %22, align 8
  %752 = ptrtoint ptr %750 to i64
  %753 = ptrtoint ptr %751 to i64
  %754 = sub i64 %752, %753
  br label %755

755:                                              ; preds = %749, %743
  %756 = phi i64 [ %748, %743 ], [ %754, %749 ]
  %757 = load i32, ptr %19, align 4
  %758 = zext i32 %757 to i64
  %759 = icmp ult i64 %756, %758
  br i1 %759, label %760, label %786

760:                                              ; preds = %755
  %761 = load ptr, ptr %25, align 8
  %762 = load ptr, ptr %24, align 8
  %763 = ptrtoint ptr %761 to i64
  %764 = ptrtoint ptr %762 to i64
  %765 = sub i64 %763, %764
  %766 = load ptr, ptr %23, align 8
  %767 = load ptr, ptr %22, align 8
  %768 = ptrtoint ptr %766 to i64
  %769 = ptrtoint ptr %767 to i64
  %770 = sub i64 %768, %769
  %771 = icmp ult i64 %765, %770
  br i1 %771, label %772, label %778

772:                                              ; preds = %760
  %773 = load ptr, ptr %25, align 8
  %774 = load ptr, ptr %24, align 8
  %775 = ptrtoint ptr %773 to i64
  %776 = ptrtoint ptr %774 to i64
  %777 = sub i64 %775, %776
  br label %784

778:                                              ; preds = %760
  %779 = load ptr, ptr %23, align 8
  %780 = load ptr, ptr %22, align 8
  %781 = ptrtoint ptr %779 to i64
  %782 = ptrtoint ptr %780 to i64
  %783 = sub i64 %781, %782
  br label %784

784:                                              ; preds = %778, %772
  %785 = phi i64 [ %777, %772 ], [ %783, %778 ]
  br label %789

786:                                              ; preds = %755
  %787 = load i32, ptr %19, align 4
  %788 = zext i32 %787 to i64
  br label %789

789:                                              ; preds = %786, %784
  %790 = phi i64 [ %785, %784 ], [ %788, %786 ]
  store i64 %790, ptr %32, align 8
  %791 = load ptr, ptr %24, align 8
  %792 = load ptr, ptr %22, align 8
  %793 = load i64, ptr %32, align 8
  %794 = load ptr, ptr %24, align 8
  %795 = call i64 @llvm.objectsize.i64.p0(ptr %794, i1 false, i1 true, i1 false)
  %796 = call ptr @__memcpy_chk(ptr noundef %791, ptr noundef %792, i64 noundef %793, i64 noundef %795) #12
  %797 = load i64, ptr %32, align 8
  %798 = load ptr, ptr %22, align 8
  %799 = getelementptr inbounds i8, ptr %798, i64 %797
  store ptr %799, ptr %22, align 8
  %800 = load i64, ptr %32, align 8
  %801 = load ptr, ptr %24, align 8
  %802 = getelementptr inbounds i8, ptr %801, i64 %800
  store ptr %802, ptr %24, align 8
  %803 = load i64, ptr %32, align 8
  %804 = trunc i64 %803 to i32
  %805 = load i32, ptr %19, align 4
  %806 = sub i32 %805, %804
  store i32 %806, ptr %19, align 4
  br label %692, !llvm.loop !19

807:                                              ; preds = %692
  br label %2699

808:                                              ; preds = %363
  %809 = load ptr, ptr %9, align 8
  %810 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %809, i32 0, i32 7
  %811 = load i32, ptr %810, align 4
  %812 = icmp eq i32 %811, 3
  br i1 %812, label %813, label %822

813:                                              ; preds = %808
  br label %814

814:                                              ; preds = %813
  br label %815

815:                                              ; preds = %820, %814
  br label %816

816:                                              ; preds = %815
  store i32 -1, ptr %16, align 4
  %817 = load ptr, ptr %9, align 8
  %818 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %817, i32 0, i32 0
  store i32 10, ptr %818, align 8
  br label %2905

819:                                              ; preds = %119
  br label %820

820:                                              ; preds = %819
  br label %815

821:                                              ; No predecessors!
  br label %2698

822:                                              ; preds = %808
  %823 = load ptr, ptr %9, align 8
  %824 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %823, i32 0, i32 7
  %825 = load i32, ptr %824, align 4
  %826 = icmp eq i32 %825, 1
  br i1 %826, label %827, label %891

827:                                              ; preds = %822
  %828 = load ptr, ptr %9, align 8
  %829 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %828, i32 0, i32 16
  %830 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %829, i64 0, i64 0
  %831 = getelementptr inbounds %struct.tinfl_huff_table, ptr %830, i32 0, i32 0
  %832 = getelementptr inbounds [288 x i8], ptr %831, i64 0, i64 0
  store ptr %832, ptr %33, align 8
  %833 = load ptr, ptr %9, align 8
  %834 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %833, i32 0, i32 13
  %835 = getelementptr inbounds [3 x i32], ptr %834, i64 0, i64 0
  store i32 288, ptr %835, align 4
  %836 = load ptr, ptr %9, align 8
  %837 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %836, i32 0, i32 13
  %838 = getelementptr inbounds [3 x i32], ptr %837, i64 0, i64 1
  store i32 32, ptr %838, align 4
  %839 = load ptr, ptr %9, align 8
  %840 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %839, i32 0, i32 16
  %841 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %840, i64 0, i64 1
  %842 = getelementptr inbounds %struct.tinfl_huff_table, ptr %841, i32 0, i32 0
  %843 = getelementptr inbounds [288 x i8], ptr %842, i64 0, i64 0
  %844 = load ptr, ptr %9, align 8
  %845 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %844, i32 0, i32 16
  %846 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %845, i64 0, i64 1
  %847 = getelementptr inbounds %struct.tinfl_huff_table, ptr %846, i32 0, i32 0
  %848 = getelementptr inbounds [288 x i8], ptr %847, i64 0, i64 0
  %849 = call i64 @llvm.objectsize.i64.p0(ptr %848, i1 false, i1 true, i1 false)
  %850 = call ptr @__memset_chk(ptr noundef %843, i32 noundef 5, i64 noundef 32, i64 noundef %849) #12
  store i32 0, ptr %34, align 4
  br label %851

851:                                              ; preds = %857, %827
  %852 = load i32, ptr %34, align 4
  %853 = icmp ule i32 %852, 143
  br i1 %853, label %854, label %860

854:                                              ; preds = %851
  %855 = load ptr, ptr %33, align 8
  %856 = getelementptr inbounds i8, ptr %855, i32 1
  store ptr %856, ptr %33, align 8
  store i8 8, ptr %855, align 1
  br label %857

857:                                              ; preds = %854
  %858 = load i32, ptr %34, align 4
  %859 = add i32 %858, 1
  store i32 %859, ptr %34, align 4
  br label %851, !llvm.loop !20

860:                                              ; preds = %851
  br label %861

861:                                              ; preds = %867, %860
  %862 = load i32, ptr %34, align 4
  %863 = icmp ule i32 %862, 255
  br i1 %863, label %864, label %870

864:                                              ; preds = %861
  %865 = load ptr, ptr %33, align 8
  %866 = getelementptr inbounds i8, ptr %865, i32 1
  store ptr %866, ptr %33, align 8
  store i8 9, ptr %865, align 1
  br label %867

867:                                              ; preds = %864
  %868 = load i32, ptr %34, align 4
  %869 = add i32 %868, 1
  store i32 %869, ptr %34, align 4
  br label %861, !llvm.loop !21

870:                                              ; preds = %861
  br label %871

871:                                              ; preds = %877, %870
  %872 = load i32, ptr %34, align 4
  %873 = icmp ule i32 %872, 279
  br i1 %873, label %874, label %880

874:                                              ; preds = %871
  %875 = load ptr, ptr %33, align 8
  %876 = getelementptr inbounds i8, ptr %875, i32 1
  store ptr %876, ptr %33, align 8
  store i8 7, ptr %875, align 1
  br label %877

877:                                              ; preds = %874
  %878 = load i32, ptr %34, align 4
  %879 = add i32 %878, 1
  store i32 %879, ptr %34, align 4
  br label %871, !llvm.loop !22

880:                                              ; preds = %871
  br label %881

881:                                              ; preds = %887, %880
  %882 = load i32, ptr %34, align 4
  %883 = icmp ule i32 %882, 287
  br i1 %883, label %884, label %890

884:                                              ; preds = %881
  %885 = load ptr, ptr %33, align 8
  %886 = getelementptr inbounds i8, ptr %885, i32 1
  store ptr %886, ptr %33, align 8
  store i8 8, ptr %885, align 1
  br label %887

887:                                              ; preds = %884
  %888 = load i32, ptr %34, align 4
  %889 = add i32 %888, 1
  store i32 %889, ptr %34, align 4
  br label %881, !llvm.loop !23

890:                                              ; preds = %881
  br label %1104

891:                                              ; preds = %822
  store i32 0, ptr %19, align 4
  br label %892

892:                                              ; preds = %1002, %891
  %893 = load i32, ptr %19, align 4
  %894 = icmp ult i32 %893, 3
  br i1 %894, label %895, label %1005

895:                                              ; preds = %892
  br label %896

896:                                              ; preds = %895
  %897 = load i32, ptr %17, align 4
  %898 = load i32, ptr %19, align 4
  %899 = zext i32 %898 to i64
  %900 = getelementptr inbounds [4 x i8], ptr @.str.11, i64 0, i64 %899
  %901 = load i8, ptr %900, align 1
  %902 = sext i8 %901 to i32
  %903 = icmp ult i32 %897, %902
  br i1 %903, label %904, label %958

904:                                              ; preds = %896
  br label %905

905:                                              ; preds = %949, %904
  br label %906

906:                                              ; preds = %905
  %907 = load ptr, ptr %22, align 8
  %908 = load ptr, ptr %23, align 8
  %909 = icmp uge ptr %907, %908
  br i1 %909, label %910, label %933

910:                                              ; preds = %906
  br label %911

911:                                              ; preds = %931, %910
  %912 = load i32, ptr %15, align 4
  %913 = and i32 %912, 2
  %914 = icmp ne i32 %913, 0
  br i1 %914, label %915, label %930

915:                                              ; preds = %911
  br label %916

916:                                              ; preds = %915
  store i32 1, ptr %16, align 4
  %917 = load ptr, ptr %9, align 8
  %918 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %917, i32 0, i32 0
  store i32 11, ptr %918, align 8
  br label %2905

919:                                              ; preds = %119
  br label %920

920:                                              ; preds = %919
  %921 = load ptr, ptr %22, align 8
  %922 = load ptr, ptr %23, align 8
  %923 = icmp ult ptr %921, %922
  br i1 %923, label %924, label %929

924:                                              ; preds = %920
  %925 = load ptr, ptr %22, align 8
  %926 = getelementptr inbounds i8, ptr %925, i32 1
  store ptr %926, ptr %22, align 8
  %927 = load i8, ptr %925, align 1
  %928 = zext i8 %927 to i32
  store i32 %928, ptr %35, align 4
  br label %932

929:                                              ; preds = %920
  br label %931

930:                                              ; preds = %911
  store i32 0, ptr %35, align 4
  br label %932

931:                                              ; preds = %929
  br label %911

932:                                              ; preds = %930, %924
  br label %938

933:                                              ; preds = %906
  %934 = load ptr, ptr %22, align 8
  %935 = getelementptr inbounds i8, ptr %934, i32 1
  store ptr %935, ptr %22, align 8
  %936 = load i8, ptr %934, align 1
  %937 = zext i8 %936 to i32
  store i32 %937, ptr %35, align 4
  br label %938

938:                                              ; preds = %933, %932
  br label %939

939:                                              ; preds = %938
  %940 = load i32, ptr %35, align 4
  %941 = zext i32 %940 to i64
  %942 = load i32, ptr %17, align 4
  %943 = zext i32 %942 to i64
  %944 = shl i64 %941, %943
  %945 = load i64, ptr %21, align 8
  %946 = or i64 %945, %944
  store i64 %946, ptr %21, align 8
  %947 = load i32, ptr %17, align 4
  %948 = add i32 %947, 8
  store i32 %948, ptr %17, align 4
  br label %949

949:                                              ; preds = %939
  %950 = load i32, ptr %17, align 4
  %951 = load i32, ptr %19, align 4
  %952 = zext i32 %951 to i64
  %953 = getelementptr inbounds [4 x i8], ptr @.str.11, i64 0, i64 %952
  %954 = load i8, ptr %953, align 1
  %955 = sext i8 %954 to i32
  %956 = icmp ult i32 %950, %955
  br i1 %956, label %905, label %957, !llvm.loop !24

957:                                              ; preds = %949
  br label %958

958:                                              ; preds = %957, %896
  %959 = load i64, ptr %21, align 8
  %960 = load i32, ptr %19, align 4
  %961 = zext i32 %960 to i64
  %962 = getelementptr inbounds [4 x i8], ptr @.str.11, i64 0, i64 %961
  %963 = load i8, ptr %962, align 1
  %964 = sext i8 %963 to i32
  %965 = shl i32 1, %964
  %966 = sub nsw i32 %965, 1
  %967 = sext i32 %966 to i64
  %968 = and i64 %959, %967
  %969 = trunc i64 %968 to i32
  %970 = load ptr, ptr %9, align 8
  %971 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %970, i32 0, i32 13
  %972 = load i32, ptr %19, align 4
  %973 = zext i32 %972 to i64
  %974 = getelementptr inbounds [3 x i32], ptr %971, i64 0, i64 %973
  store i32 %969, ptr %974, align 4
  %975 = load i32, ptr %19, align 4
  %976 = zext i32 %975 to i64
  %977 = getelementptr inbounds [4 x i8], ptr @.str.11, i64 0, i64 %976
  %978 = load i8, ptr %977, align 1
  %979 = sext i8 %978 to i32
  %980 = load i64, ptr %21, align 8
  %981 = zext i32 %979 to i64
  %982 = lshr i64 %980, %981
  store i64 %982, ptr %21, align 8
  %983 = load i32, ptr %19, align 4
  %984 = zext i32 %983 to i64
  %985 = getelementptr inbounds [4 x i8], ptr @.str.11, i64 0, i64 %984
  %986 = load i8, ptr %985, align 1
  %987 = sext i8 %986 to i32
  %988 = load i32, ptr %17, align 4
  %989 = sub i32 %988, %987
  store i32 %989, ptr %17, align 4
  br label %990

990:                                              ; preds = %958
  %991 = load i32, ptr %19, align 4
  %992 = zext i32 %991 to i64
  %993 = getelementptr inbounds [3 x i32], ptr @tinfl_decompress.s_min_table_sizes, i64 0, i64 %992
  %994 = load i32, ptr %993, align 4
  %995 = load ptr, ptr %9, align 8
  %996 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %995, i32 0, i32 13
  %997 = load i32, ptr %19, align 4
  %998 = zext i32 %997 to i64
  %999 = getelementptr inbounds [3 x i32], ptr %996, i64 0, i64 %998
  %1000 = load i32, ptr %999, align 4
  %1001 = add i32 %1000, %994
  store i32 %1001, ptr %999, align 4
  br label %1002

1002:                                             ; preds = %990
  %1003 = load i32, ptr %19, align 4
  %1004 = add i32 %1003, 1
  store i32 %1004, ptr %19, align 4
  br label %892, !llvm.loop !25

1005:                                             ; preds = %892
  %1006 = load ptr, ptr %9, align 8
  %1007 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1006, i32 0, i32 16
  %1008 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1007, i64 0, i64 2
  %1009 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1008, i32 0, i32 0
  %1010 = load ptr, ptr %9, align 8
  %1011 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1010, i32 0, i32 16
  %1012 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1011, i64 0, i64 2
  %1013 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1012, i32 0, i32 0
  %1014 = call i64 @llvm.objectsize.i64.p0(ptr %1013, i1 false, i1 true, i1 false)
  %1015 = call ptr @__memset_chk(ptr noundef %1009, i32 noundef 0, i64 noundef 288, i64 noundef %1014) #12
  store i32 0, ptr %19, align 4
  br label %1016

1016:                                             ; preds = %1097, %1005
  %1017 = load i32, ptr %19, align 4
  %1018 = load ptr, ptr %9, align 8
  %1019 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1018, i32 0, i32 13
  %1020 = getelementptr inbounds [3 x i32], ptr %1019, i64 0, i64 2
  %1021 = load i32, ptr %1020, align 4
  %1022 = icmp ult i32 %1017, %1021
  br i1 %1022, label %1023, label %1100

1023:                                             ; preds = %1016
  br label %1024

1024:                                             ; preds = %1023
  %1025 = load i32, ptr %17, align 4
  %1026 = icmp ult i32 %1025, 3
  br i1 %1026, label %1027, label %1076

1027:                                             ; preds = %1024
  br label %1028

1028:                                             ; preds = %1072, %1027
  br label %1029

1029:                                             ; preds = %1028
  %1030 = load ptr, ptr %22, align 8
  %1031 = load ptr, ptr %23, align 8
  %1032 = icmp uge ptr %1030, %1031
  br i1 %1032, label %1033, label %1056

1033:                                             ; preds = %1029
  br label %1034

1034:                                             ; preds = %1054, %1033
  %1035 = load i32, ptr %15, align 4
  %1036 = and i32 %1035, 2
  %1037 = icmp ne i32 %1036, 0
  br i1 %1037, label %1038, label %1053

1038:                                             ; preds = %1034
  br label %1039

1039:                                             ; preds = %1038
  store i32 1, ptr %16, align 4
  %1040 = load ptr, ptr %9, align 8
  %1041 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1040, i32 0, i32 0
  store i32 14, ptr %1041, align 8
  br label %2905

1042:                                             ; preds = %119
  br label %1043

1043:                                             ; preds = %1042
  %1044 = load ptr, ptr %22, align 8
  %1045 = load ptr, ptr %23, align 8
  %1046 = icmp ult ptr %1044, %1045
  br i1 %1046, label %1047, label %1052

1047:                                             ; preds = %1043
  %1048 = load ptr, ptr %22, align 8
  %1049 = getelementptr inbounds i8, ptr %1048, i32 1
  store ptr %1049, ptr %22, align 8
  %1050 = load i8, ptr %1048, align 1
  %1051 = zext i8 %1050 to i32
  store i32 %1051, ptr %37, align 4
  br label %1055

1052:                                             ; preds = %1043
  br label %1054

1053:                                             ; preds = %1034
  store i32 0, ptr %37, align 4
  br label %1055

1054:                                             ; preds = %1052
  br label %1034

1055:                                             ; preds = %1053, %1047
  br label %1061

1056:                                             ; preds = %1029
  %1057 = load ptr, ptr %22, align 8
  %1058 = getelementptr inbounds i8, ptr %1057, i32 1
  store ptr %1058, ptr %22, align 8
  %1059 = load i8, ptr %1057, align 1
  %1060 = zext i8 %1059 to i32
  store i32 %1060, ptr %37, align 4
  br label %1061

1061:                                             ; preds = %1056, %1055
  br label %1062

1062:                                             ; preds = %1061
  %1063 = load i32, ptr %37, align 4
  %1064 = zext i32 %1063 to i64
  %1065 = load i32, ptr %17, align 4
  %1066 = zext i32 %1065 to i64
  %1067 = shl i64 %1064, %1066
  %1068 = load i64, ptr %21, align 8
  %1069 = or i64 %1068, %1067
  store i64 %1069, ptr %21, align 8
  %1070 = load i32, ptr %17, align 4
  %1071 = add i32 %1070, 8
  store i32 %1071, ptr %17, align 4
  br label %1072

1072:                                             ; preds = %1062
  %1073 = load i32, ptr %17, align 4
  %1074 = icmp ult i32 %1073, 3
  br i1 %1074, label %1028, label %1075, !llvm.loop !26

1075:                                             ; preds = %1072
  br label %1076

1076:                                             ; preds = %1075, %1024
  %1077 = load i64, ptr %21, align 8
  %1078 = and i64 %1077, 7
  %1079 = trunc i64 %1078 to i32
  store i32 %1079, ptr %36, align 4
  %1080 = load i64, ptr %21, align 8
  %1081 = lshr i64 %1080, 3
  store i64 %1081, ptr %21, align 8
  %1082 = load i32, ptr %17, align 4
  %1083 = sub i32 %1082, 3
  store i32 %1083, ptr %17, align 4
  br label %1084

1084:                                             ; preds = %1076
  %1085 = load i32, ptr %36, align 4
  %1086 = trunc i32 %1085 to i8
  %1087 = load ptr, ptr %9, align 8
  %1088 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1087, i32 0, i32 16
  %1089 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1088, i64 0, i64 2
  %1090 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1089, i32 0, i32 0
  %1091 = load i32, ptr %19, align 4
  %1092 = zext i32 %1091 to i64
  %1093 = getelementptr inbounds [19 x i8], ptr @tinfl_decompress.s_length_dezigzag, i64 0, i64 %1092
  %1094 = load i8, ptr %1093, align 1
  %1095 = zext i8 %1094 to i64
  %1096 = getelementptr inbounds [288 x i8], ptr %1090, i64 0, i64 %1095
  store i8 %1086, ptr %1096, align 1
  br label %1097

1097:                                             ; preds = %1084
  %1098 = load i32, ptr %19, align 4
  %1099 = add i32 %1098, 1
  store i32 %1099, ptr %19, align 4
  br label %1016, !llvm.loop !27

1100:                                             ; preds = %1016
  %1101 = load ptr, ptr %9, align 8
  %1102 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1101, i32 0, i32 13
  %1103 = getelementptr inbounds [3 x i32], ptr %1102, i64 0, i64 2
  store i32 19, ptr %1103, align 4
  br label %1104

1104:                                             ; preds = %1100, %890
  br label %1105

1105:                                             ; preds = %1779, %1104
  %1106 = load ptr, ptr %9, align 8
  %1107 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1106, i32 0, i32 7
  %1108 = load i32, ptr %1107, align 4
  %1109 = icmp sge i32 %1108, 0
  br i1 %1109, label %1110, label %1784

1110:                                             ; preds = %1105
  %1111 = load ptr, ptr %9, align 8
  %1112 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1111, i32 0, i32 16
  %1113 = load ptr, ptr %9, align 8
  %1114 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1113, i32 0, i32 7
  %1115 = load i32, ptr %1114, align 4
  %1116 = zext i32 %1115 to i64
  %1117 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1112, i64 0, i64 %1116
  store ptr %1117, ptr %40, align 8
  call void @llvm.memset.p0.i64(ptr align 16 %47, i8 0, i64 64, i1 false)
  %1118 = load ptr, ptr %40, align 8
  %1119 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1118, i32 0, i32 1
  %1120 = load ptr, ptr %40, align 8
  %1121 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1120, i32 0, i32 1
  %1122 = call i64 @llvm.objectsize.i64.p0(ptr %1121, i1 false, i1 true, i1 false)
  %1123 = call ptr @__memset_chk(ptr noundef %1119, i32 noundef 0, i64 noundef 2048, i64 noundef %1122) #12
  %1124 = load ptr, ptr %40, align 8
  %1125 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1124, i32 0, i32 2
  %1126 = load ptr, ptr %40, align 8
  %1127 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1126, i32 0, i32 2
  %1128 = call i64 @llvm.objectsize.i64.p0(ptr %1127, i1 false, i1 true, i1 false)
  %1129 = call ptr @__memset_chk(ptr noundef %1125, i32 noundef 0, i64 noundef 1152, i64 noundef %1128) #12
  store i32 0, ptr %41, align 4
  br label %1130

1130:                                             ; preds = %1152, %1110
  %1131 = load i32, ptr %41, align 4
  %1132 = load ptr, ptr %9, align 8
  %1133 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1132, i32 0, i32 13
  %1134 = load ptr, ptr %9, align 8
  %1135 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1134, i32 0, i32 7
  %1136 = load i32, ptr %1135, align 4
  %1137 = zext i32 %1136 to i64
  %1138 = getelementptr inbounds [3 x i32], ptr %1133, i64 0, i64 %1137
  %1139 = load i32, ptr %1138, align 4
  %1140 = icmp ult i32 %1131, %1139
  br i1 %1140, label %1141, label %1155

1141:                                             ; preds = %1130
  %1142 = load ptr, ptr %40, align 8
  %1143 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1142, i32 0, i32 0
  %1144 = load i32, ptr %41, align 4
  %1145 = zext i32 %1144 to i64
  %1146 = getelementptr inbounds [288 x i8], ptr %1143, i64 0, i64 %1145
  %1147 = load i8, ptr %1146, align 1
  %1148 = zext i8 %1147 to i64
  %1149 = getelementptr inbounds [16 x i32], ptr %47, i64 0, i64 %1148
  %1150 = load i32, ptr %1149, align 4
  %1151 = add i32 %1150, 1
  store i32 %1151, ptr %1149, align 4
  br label %1152

1152:                                             ; preds = %1141
  %1153 = load i32, ptr %41, align 4
  %1154 = add i32 %1153, 1
  store i32 %1154, ptr %41, align 4
  br label %1130, !llvm.loop !28

1155:                                             ; preds = %1130
  store i32 0, ptr %43, align 4
  store i32 0, ptr %44, align 4
  %1156 = getelementptr inbounds [17 x i32], ptr %46, i64 0, i64 1
  store i32 0, ptr %1156, align 4
  %1157 = getelementptr inbounds [17 x i32], ptr %46, i64 0, i64 0
  store i32 0, ptr %1157, align 16
  store i32 1, ptr %41, align 4
  br label %1158

1158:                                             ; preds = %1179, %1155
  %1159 = load i32, ptr %41, align 4
  %1160 = icmp ule i32 %1159, 15
  br i1 %1160, label %1161, label %1182

1161:                                             ; preds = %1158
  %1162 = load i32, ptr %41, align 4
  %1163 = zext i32 %1162 to i64
  %1164 = getelementptr inbounds [16 x i32], ptr %47, i64 0, i64 %1163
  %1165 = load i32, ptr %1164, align 4
  %1166 = load i32, ptr %43, align 4
  %1167 = add i32 %1166, %1165
  store i32 %1167, ptr %43, align 4
  %1168 = load i32, ptr %44, align 4
  %1169 = load i32, ptr %41, align 4
  %1170 = zext i32 %1169 to i64
  %1171 = getelementptr inbounds [16 x i32], ptr %47, i64 0, i64 %1170
  %1172 = load i32, ptr %1171, align 4
  %1173 = add i32 %1168, %1172
  %1174 = shl i32 %1173, 1
  store i32 %1174, ptr %44, align 4
  %1175 = load i32, ptr %41, align 4
  %1176 = add i32 %1175, 1
  %1177 = zext i32 %1176 to i64
  %1178 = getelementptr inbounds [17 x i32], ptr %46, i64 0, i64 %1177
  store i32 %1174, ptr %1178, align 4
  br label %1179

1179:                                             ; preds = %1161
  %1180 = load i32, ptr %41, align 4
  %1181 = add i32 %1180, 1
  store i32 %1181, ptr %41, align 4
  br label %1158, !llvm.loop !29

1182:                                             ; preds = %1158
  %1183 = load i32, ptr %44, align 4
  %1184 = icmp ne i32 65536, %1183
  br i1 %1184, label %1185, label %1197

1185:                                             ; preds = %1182
  %1186 = load i32, ptr %43, align 4
  %1187 = icmp ugt i32 %1186, 1
  br i1 %1187, label %1188, label %1197

1188:                                             ; preds = %1185
  br label %1189

1189:                                             ; preds = %1188
  br label %1190

1190:                                             ; preds = %1195, %1189
  br label %1191

1191:                                             ; preds = %1190
  store i32 -1, ptr %16, align 4
  %1192 = load ptr, ptr %9, align 8
  %1193 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1192, i32 0, i32 0
  store i32 35, ptr %1193, align 8
  br label %2905

1194:                                             ; preds = %119
  br label %1195

1195:                                             ; preds = %1194
  br label %1190

1196:                                             ; No predecessors!
  br label %1197

1197:                                             ; preds = %1196, %1185, %1182
  store i32 -1, ptr %38, align 4
  store i32 0, ptr %45, align 4
  br label %1198

1198:                                             ; preds = %1351, %1197
  %1199 = load i32, ptr %45, align 4
  %1200 = load ptr, ptr %9, align 8
  %1201 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1200, i32 0, i32 13
  %1202 = load ptr, ptr %9, align 8
  %1203 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1202, i32 0, i32 7
  %1204 = load i32, ptr %1203, align 4
  %1205 = zext i32 %1204 to i64
  %1206 = getelementptr inbounds [3 x i32], ptr %1201, i64 0, i64 %1205
  %1207 = load i32, ptr %1206, align 4
  %1208 = icmp ult i32 %1199, %1207
  br i1 %1208, label %1209, label %1354

1209:                                             ; preds = %1198
  store i32 0, ptr %48, align 4
  %1210 = load ptr, ptr %40, align 8
  %1211 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1210, i32 0, i32 0
  %1212 = load i32, ptr %45, align 4
  %1213 = zext i32 %1212 to i64
  %1214 = getelementptr inbounds [288 x i8], ptr %1211, i64 0, i64 %1213
  %1215 = load i8, ptr %1214, align 1
  %1216 = zext i8 %1215 to i32
  store i32 %1216, ptr %51, align 4
  %1217 = load i32, ptr %51, align 4
  %1218 = icmp ne i32 %1217, 0
  br i1 %1218, label %1220, label %1219

1219:                                             ; preds = %1209
  br label %1351

1220:                                             ; preds = %1209
  %1221 = load i32, ptr %51, align 4
  %1222 = zext i32 %1221 to i64
  %1223 = getelementptr inbounds [17 x i32], ptr %46, i64 0, i64 %1222
  %1224 = load i32, ptr %1223, align 4
  %1225 = add i32 %1224, 1
  store i32 %1225, ptr %1223, align 4
  store i32 %1224, ptr %50, align 4
  %1226 = load i32, ptr %51, align 4
  store i32 %1226, ptr %49, align 4
  br label %1227

1227:                                             ; preds = %1236, %1220
  %1228 = load i32, ptr %49, align 4
  %1229 = icmp ugt i32 %1228, 0
  br i1 %1229, label %1230, label %1241

1230:                                             ; preds = %1227
  %1231 = load i32, ptr %48, align 4
  %1232 = shl i32 %1231, 1
  %1233 = load i32, ptr %50, align 4
  %1234 = and i32 %1233, 1
  %1235 = or i32 %1232, %1234
  store i32 %1235, ptr %48, align 4
  br label %1236

1236:                                             ; preds = %1230
  %1237 = load i32, ptr %49, align 4
  %1238 = add i32 %1237, -1
  store i32 %1238, ptr %49, align 4
  %1239 = load i32, ptr %50, align 4
  %1240 = lshr i32 %1239, 1
  store i32 %1240, ptr %50, align 4
  br label %1227, !llvm.loop !30

1241:                                             ; preds = %1227
  %1242 = load i32, ptr %51, align 4
  %1243 = icmp ule i32 %1242, 10
  br i1 %1243, label %1244, label %1265

1244:                                             ; preds = %1241
  %1245 = load i32, ptr %51, align 4
  %1246 = shl i32 %1245, 9
  %1247 = load i32, ptr %45, align 4
  %1248 = or i32 %1246, %1247
  %1249 = add i32 %1248, 0
  store i32 %1249, ptr %52, align 2
  br label %1250

1250:                                             ; preds = %1253, %1244
  %1251 = load i32, ptr %48, align 4
  %1252 = icmp ult i32 %1251, 1024
  br i1 %1252, label %1253, label %1264

1253:                                             ; preds = %1250
  %1254 = load i32, ptr %52, align 2
  %1255 = load ptr, ptr %40, align 8
  %1256 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1255, i32 0, i32 1
  %1257 = load i32, ptr %48, align 4
  %1258 = zext i32 %1257 to i64
  %1259 = getelementptr inbounds [1024 x i32], ptr %1256, i64 0, i64 %1258
  store i32 %1254, ptr %1259, align 2
  %1260 = load i32, ptr %51, align 4
  %1261 = shl i32 1, %1260
  %1262 = load i32, ptr %48, align 4
  %1263 = add i32 %1262, %1261
  store i32 %1263, ptr %48, align 4
  br label %1250, !llvm.loop !31

1264:                                             ; preds = %1250
  br label %1351

1265:                                             ; preds = %1241
  %1266 = load ptr, ptr %40, align 8
  %1267 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1266, i32 0, i32 1
  %1268 = load i32, ptr %48, align 4
  %1269 = and i32 %1268, 1023
  %1270 = zext i32 %1269 to i64
  %1271 = getelementptr inbounds [1024 x i32], ptr %1267, i64 0, i64 %1270
  %1272 = load i32, ptr %1271, align 2
  %1273 = add i32 %1272, 0
  store i32 %1273, ptr %39, align 4
  %1274 = icmp eq i32 0, %1273
  br i1 %1274, label %1275, label %1287

1275:                                             ; preds = %1265
  %1276 = load i32, ptr %38, align 4
  %1277 = add i32 %1276, 0
  %1278 = load ptr, ptr %40, align 8
  %1279 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1278, i32 0, i32 1
  %1280 = load i32, ptr %48, align 4
  %1281 = and i32 %1280, 1023
  %1282 = zext i32 %1281 to i64
  %1283 = getelementptr inbounds [1024 x i32], ptr %1279, i64 0, i64 %1282
  store i32 %1277, ptr %1283, align 2
  %1284 = load i32, ptr %38, align 4
  store i32 %1284, ptr %39, align 4
  %1285 = load i32, ptr %38, align 4
  %1286 = sub nsw i32 %1285, 2
  store i32 %1286, ptr %38, align 4
  br label %1287

1287:                                             ; preds = %1275, %1265
  %1288 = load i32, ptr %48, align 4
  %1289 = lshr i32 %1288, 9
  store i32 %1289, ptr %48, align 4
  %1290 = load i32, ptr %51, align 4
  store i32 %1290, ptr %42, align 4
  br label %1291

1291:                                             ; preds = %1333, %1287
  %1292 = load i32, ptr %42, align 4
  %1293 = icmp ugt i32 %1292, 11
  br i1 %1293, label %1294, label %1336

1294:                                             ; preds = %1291
  %1295 = load i32, ptr %48, align 4
  %1296 = lshr i32 %1295, 1
  store i32 %1296, ptr %48, align 4
  %1297 = and i32 %1296, 1
  %1298 = load i32, ptr %39, align 4
  %1299 = sub i32 %1298, %1297
  store i32 %1299, ptr %39, align 4
  %1300 = load ptr, ptr %40, align 8
  %1301 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1300, i32 0, i32 2
  %1302 = load i32, ptr %39, align 4
  %1303 = sub nsw i32 0, %1302
  %1304 = sub nsw i32 %1303, 1
  %1305 = sext i32 %1304 to i64
  %1306 = getelementptr inbounds [576 x i32], ptr %1301, i64 0, i64 %1305
  %1307 = load i32, ptr %1306, align 2
  %1308 = icmp ne i32 %1307, 0
  br i1 %1308, label %1322, label %1309

1309:                                             ; preds = %1294
  %1310 = load i32, ptr %38, align 4
  %1311 = add i32 %1310, 0
  %1312 = load ptr, ptr %40, align 8
  %1313 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1312, i32 0, i32 2
  %1314 = load i32, ptr %39, align 4
  %1315 = sub nsw i32 0, %1314
  %1316 = sub nsw i32 %1315, 1
  %1317 = sext i32 %1316 to i64
  %1318 = getelementptr inbounds [576 x i32], ptr %1313, i64 0, i64 %1317
  store i32 %1311, ptr %1318, align 2
  %1319 = load i32, ptr %38, align 4
  store i32 %1319, ptr %39, align 4
  %1320 = load i32, ptr %38, align 4
  %1321 = sub nsw i32 %1320, 2
  store i32 %1321, ptr %38, align 4
  br label %1332

1322:                                             ; preds = %1294
  %1323 = load ptr, ptr %40, align 8
  %1324 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1323, i32 0, i32 2
  %1325 = load i32, ptr %39, align 4
  %1326 = sub nsw i32 0, %1325
  %1327 = sub nsw i32 %1326, 1
  %1328 = sext i32 %1327 to i64
  %1329 = getelementptr inbounds [576 x i32], ptr %1324, i64 0, i64 %1328
  %1330 = load i32, ptr %1329, align 2
  %1331 = add i32 %1330, 0
  store i32 %1331, ptr %39, align 4
  br label %1332

1332:                                             ; preds = %1322, %1309
  br label %1333

1333:                                             ; preds = %1332
  %1334 = load i32, ptr %42, align 4
  %1335 = add i32 %1334, -1
  store i32 %1335, ptr %42, align 4
  br label %1291, !llvm.loop !32

1336:                                             ; preds = %1291
  %1337 = load i32, ptr %48, align 4
  %1338 = lshr i32 %1337, 1
  store i32 %1338, ptr %48, align 4
  %1339 = and i32 %1338, 1
  %1340 = load i32, ptr %39, align 4
  %1341 = sub i32 %1340, %1339
  store i32 %1341, ptr %39, align 4
  %1342 = load i32, ptr %45, align 4
  %1343 = add i32 %1342, 0
  %1344 = load ptr, ptr %40, align 8
  %1345 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1344, i32 0, i32 2
  %1346 = load i32, ptr %39, align 4
  %1347 = sub nsw i32 0, %1346
  %1348 = sub nsw i32 %1347, 1
  %1349 = sext i32 %1348 to i64
  %1350 = getelementptr inbounds [576 x i32], ptr %1345, i64 0, i64 %1349
  store i32 %1343, ptr %1350, align 2
  br label %1351

1351:                                             ; preds = %1336, %1264, %1219
  %1352 = load i32, ptr %45, align 4
  %1353 = add i32 %1352, 1
  store i32 %1353, ptr %45, align 4
  br label %1198, !llvm.loop !33

1354:                                             ; preds = %1198
  %1355 = load ptr, ptr %9, align 8
  %1356 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1355, i32 0, i32 7
  %1357 = load i32, ptr %1356, align 4
  %1358 = icmp eq i32 %1357, 2
  br i1 %1358, label %1359, label %1778

1359:                                             ; preds = %1354
  store i32 0, ptr %19, align 4
  br label %1360

1360:                                             ; preds = %1695, %1568, %1359
  %1361 = load i32, ptr %19, align 4
  %1362 = load ptr, ptr %9, align 8
  %1363 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1362, i32 0, i32 13
  %1364 = getelementptr inbounds [3 x i32], ptr %1363, i64 0, i64 0
  %1365 = load i32, ptr %1364, align 4
  %1366 = load ptr, ptr %9, align 8
  %1367 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1366, i32 0, i32 13
  %1368 = getelementptr inbounds [3 x i32], ptr %1367, i64 0, i64 1
  %1369 = load i32, ptr %1368, align 4
  %1370 = add i32 %1365, %1369
  %1371 = icmp ult i32 %1361, %1370
  br i1 %1371, label %1372, label %1710

1372:                                             ; preds = %1360
  br label %1373

1373:                                             ; preds = %1372
  %1374 = load i32, ptr %17, align 4
  %1375 = icmp ult i32 %1374, 15
  br i1 %1375, label %1376, label %1517

1376:                                             ; preds = %1373
  %1377 = load ptr, ptr %23, align 8
  %1378 = load ptr, ptr %22, align 8
  %1379 = ptrtoint ptr %1377 to i64
  %1380 = ptrtoint ptr %1378 to i64
  %1381 = sub i64 %1379, %1380
  %1382 = icmp slt i64 %1381, 2
  br i1 %1382, label %1383, label %1493

1383:                                             ; preds = %1376
  br label %1384

1384:                                             ; preds = %1489, %1383
  %1385 = load ptr, ptr %9, align 8
  %1386 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1385, i32 0, i32 16
  %1387 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1386, i64 0, i64 2
  %1388 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1387, i32 0, i32 1
  %1389 = load i64, ptr %21, align 8
  %1390 = and i64 %1389, 1023
  %1391 = getelementptr inbounds [1024 x i32], ptr %1388, i64 0, i64 %1390
  %1392 = load i32, ptr %1391, align 2
  %1393 = add i32 %1392, 0
  store i32 %1393, ptr %54, align 4
  %1394 = load i32, ptr %54, align 4
  %1395 = icmp sge i32 %1394, 0
  br i1 %1395, label %1396, label %1407

1396:                                             ; preds = %1384
  %1397 = load i32, ptr %54, align 4
  %1398 = ashr i32 %1397, 9
  store i32 %1398, ptr %55, align 4
  %1399 = load i32, ptr %55, align 4
  %1400 = icmp ne i32 %1399, 0
  br i1 %1400, label %1401, label %1406

1401:                                             ; preds = %1396
  %1402 = load i32, ptr %17, align 4
  %1403 = load i32, ptr %55, align 4
  %1404 = icmp uge i32 %1402, %1403
  br i1 %1404, label %1405, label %1406

1405:                                             ; preds = %1401
  br label %1492

1406:                                             ; preds = %1401, %1396
  br label %1445

1407:                                             ; preds = %1384
  %1408 = load i32, ptr %17, align 4
  %1409 = icmp ugt i32 %1408, 10
  br i1 %1409, label %1410, label %1444

1410:                                             ; preds = %1407
  store i32 10, ptr %55, align 4
  br label %1411

1411:                                             ; preds = %1437, %1410
  %1412 = load ptr, ptr %9, align 8
  %1413 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1412, i32 0, i32 16
  %1414 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1413, i64 0, i64 2
  %1415 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1414, i32 0, i32 2
  %1416 = load i32, ptr %54, align 4
  %1417 = xor i32 %1416, -1
  %1418 = sext i32 %1417 to i64
  %1419 = load i64, ptr %21, align 8
  %1420 = load i32, ptr %55, align 4
  %1421 = add i32 %1420, 1
  store i32 %1421, ptr %55, align 4
  %1422 = zext i32 %1420 to i64
  %1423 = lshr i64 %1419, %1422
  %1424 = and i64 %1423, 1
  %1425 = add i64 %1418, %1424
  %1426 = getelementptr inbounds [576 x i32], ptr %1415, i64 0, i64 %1425
  %1427 = load i32, ptr %1426, align 2
  %1428 = add i32 %1427, 0
  store i32 %1428, ptr %54, align 4
  br label %1429

1429:                                             ; preds = %1411
  %1430 = load i32, ptr %54, align 4
  %1431 = icmp slt i32 %1430, 0
  br i1 %1431, label %1432, label %1437

1432:                                             ; preds = %1429
  %1433 = load i32, ptr %17, align 4
  %1434 = load i32, ptr %55, align 4
  %1435 = add i32 %1434, 1
  %1436 = icmp uge i32 %1433, %1435
  br label %1437

1437:                                             ; preds = %1432, %1429
  %1438 = phi i1 [ false, %1429 ], [ %1436, %1432 ]
  br i1 %1438, label %1411, label %1439, !llvm.loop !34

1439:                                             ; preds = %1437
  %1440 = load i32, ptr %54, align 4
  %1441 = icmp sge i32 %1440, 0
  br i1 %1441, label %1442, label %1443

1442:                                             ; preds = %1439
  br label %1492

1443:                                             ; preds = %1439
  br label %1444

1444:                                             ; preds = %1443, %1407
  br label %1445

1445:                                             ; preds = %1444, %1406
  br label %1446

1446:                                             ; preds = %1445
  %1447 = load ptr, ptr %22, align 8
  %1448 = load ptr, ptr %23, align 8
  %1449 = icmp uge ptr %1447, %1448
  br i1 %1449, label %1450, label %1473

1450:                                             ; preds = %1446
  br label %1451

1451:                                             ; preds = %1471, %1450
  %1452 = load i32, ptr %15, align 4
  %1453 = and i32 %1452, 2
  %1454 = icmp ne i32 %1453, 0
  br i1 %1454, label %1455, label %1470

1455:                                             ; preds = %1451
  br label %1456

1456:                                             ; preds = %1455
  store i32 1, ptr %16, align 4
  %1457 = load ptr, ptr %9, align 8
  %1458 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1457, i32 0, i32 0
  store i32 16, ptr %1458, align 8
  br label %2905

1459:                                             ; preds = %119
  br label %1460

1460:                                             ; preds = %1459
  %1461 = load ptr, ptr %22, align 8
  %1462 = load ptr, ptr %23, align 8
  %1463 = icmp ult ptr %1461, %1462
  br i1 %1463, label %1464, label %1469

1464:                                             ; preds = %1460
  %1465 = load ptr, ptr %22, align 8
  %1466 = getelementptr inbounds i8, ptr %1465, i32 1
  store ptr %1466, ptr %22, align 8
  %1467 = load i8, ptr %1465, align 1
  %1468 = zext i8 %1467 to i32
  store i32 %1468, ptr %56, align 4
  br label %1472

1469:                                             ; preds = %1460
  br label %1471

1470:                                             ; preds = %1451
  store i32 0, ptr %56, align 4
  br label %1472

1471:                                             ; preds = %1469
  br label %1451

1472:                                             ; preds = %1470, %1464
  br label %1478

1473:                                             ; preds = %1446
  %1474 = load ptr, ptr %22, align 8
  %1475 = getelementptr inbounds i8, ptr %1474, i32 1
  store ptr %1475, ptr %22, align 8
  %1476 = load i8, ptr %1474, align 1
  %1477 = zext i8 %1476 to i32
  store i32 %1477, ptr %56, align 4
  br label %1478

1478:                                             ; preds = %1473, %1472
  br label %1479

1479:                                             ; preds = %1478
  %1480 = load i32, ptr %56, align 4
  %1481 = zext i32 %1480 to i64
  %1482 = load i32, ptr %17, align 4
  %1483 = zext i32 %1482 to i64
  %1484 = shl i64 %1481, %1483
  %1485 = load i64, ptr %21, align 8
  %1486 = or i64 %1485, %1484
  store i64 %1486, ptr %21, align 8
  %1487 = load i32, ptr %17, align 4
  %1488 = add i32 %1487, 8
  store i32 %1488, ptr %17, align 4
  br label %1489

1489:                                             ; preds = %1479
  %1490 = load i32, ptr %17, align 4
  %1491 = icmp ult i32 %1490, 15
  br i1 %1491, label %1384, label %1492, !llvm.loop !35

1492:                                             ; preds = %1489, %1442, %1405
  br label %1516

1493:                                             ; preds = %1376
  %1494 = load ptr, ptr %22, align 8
  %1495 = getelementptr inbounds i8, ptr %1494, i64 0
  %1496 = load i8, ptr %1495, align 1
  %1497 = zext i8 %1496 to i64
  %1498 = load i32, ptr %17, align 4
  %1499 = zext i32 %1498 to i64
  %1500 = shl i64 %1497, %1499
  %1501 = load ptr, ptr %22, align 8
  %1502 = getelementptr inbounds i8, ptr %1501, i64 1
  %1503 = load i8, ptr %1502, align 1
  %1504 = zext i8 %1503 to i64
  %1505 = load i32, ptr %17, align 4
  %1506 = add i32 %1505, 8
  %1507 = zext i32 %1506 to i64
  %1508 = shl i64 %1504, %1507
  %1509 = or i64 %1500, %1508
  %1510 = load i64, ptr %21, align 8
  %1511 = or i64 %1510, %1509
  store i64 %1511, ptr %21, align 8
  %1512 = load ptr, ptr %22, align 8
  %1513 = getelementptr inbounds i8, ptr %1512, i64 2
  store ptr %1513, ptr %22, align 8
  %1514 = load i32, ptr %17, align 4
  %1515 = add i32 %1514, 16
  store i32 %1515, ptr %17, align 4
  br label %1516

1516:                                             ; preds = %1493, %1492
  br label %1517

1517:                                             ; preds = %1516, %1373
  %1518 = load ptr, ptr %9, align 8
  %1519 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1518, i32 0, i32 16
  %1520 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1519, i64 0, i64 2
  %1521 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1520, i32 0, i32 1
  %1522 = load i64, ptr %21, align 8
  %1523 = and i64 %1522, 1023
  %1524 = getelementptr inbounds [1024 x i32], ptr %1521, i64 0, i64 %1523
  %1525 = load i32, ptr %1524, align 2
  %1526 = add i32 %1525, 0
  store i32 %1526, ptr %54, align 4
  %1527 = icmp sge i32 %1526, 0
  br i1 %1527, label %1528, label %1533

1528:                                             ; preds = %1517
  %1529 = load i32, ptr %54, align 4
  %1530 = ashr i32 %1529, 9
  store i32 %1530, ptr %55, align 4
  %1531 = load i32, ptr %54, align 4
  %1532 = and i32 %1531, 511
  store i32 %1532, ptr %54, align 4
  br label %1556

1533:                                             ; preds = %1517
  store i32 10, ptr %55, align 4
  br label %1534

1534:                                             ; preds = %1552, %1533
  %1535 = load ptr, ptr %9, align 8
  %1536 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1535, i32 0, i32 16
  %1537 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1536, i64 0, i64 2
  %1538 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1537, i32 0, i32 2
  %1539 = load i32, ptr %54, align 4
  %1540 = xor i32 %1539, -1
  %1541 = sext i32 %1540 to i64
  %1542 = load i64, ptr %21, align 8
  %1543 = load i32, ptr %55, align 4
  %1544 = add i32 %1543, 1
  store i32 %1544, ptr %55, align 4
  %1545 = zext i32 %1543 to i64
  %1546 = lshr i64 %1542, %1545
  %1547 = and i64 %1546, 1
  %1548 = add i64 %1541, %1547
  %1549 = getelementptr inbounds [576 x i32], ptr %1538, i64 0, i64 %1548
  %1550 = load i32, ptr %1549, align 2
  %1551 = add i32 %1550, 0
  store i32 %1551, ptr %54, align 4
  br label %1552

1552:                                             ; preds = %1534
  %1553 = load i32, ptr %54, align 4
  %1554 = icmp slt i32 %1553, 0
  br i1 %1554, label %1534, label %1555, !llvm.loop !36

1555:                                             ; preds = %1552
  br label %1556

1556:                                             ; preds = %1555, %1528
  %1557 = load i32, ptr %54, align 4
  store i32 %1557, ptr %18, align 4
  %1558 = load i32, ptr %55, align 4
  %1559 = load i64, ptr %21, align 8
  %1560 = zext i32 %1558 to i64
  %1561 = lshr i64 %1559, %1560
  store i64 %1561, ptr %21, align 8
  %1562 = load i32, ptr %55, align 4
  %1563 = load i32, ptr %17, align 4
  %1564 = sub i32 %1563, %1562
  store i32 %1564, ptr %17, align 4
  br label %1565

1565:                                             ; preds = %1556
  %1566 = load i32, ptr %18, align 4
  %1567 = icmp ult i32 %1566, 16
  br i1 %1567, label %1568, label %1577

1568:                                             ; preds = %1565
  %1569 = load i32, ptr %18, align 4
  %1570 = trunc i32 %1569 to i8
  %1571 = load ptr, ptr %9, align 8
  %1572 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1571, i32 0, i32 18
  %1573 = load i32, ptr %19, align 4
  %1574 = add i32 %1573, 1
  store i32 %1574, ptr %19, align 4
  %1575 = zext i32 %1573 to i64
  %1576 = getelementptr inbounds [457 x i8], ptr %1572, i64 0, i64 %1575
  store i8 %1570, ptr %1576, align 1
  br label %1360, !llvm.loop !37

1577:                                             ; preds = %1565
  %1578 = load i32, ptr %18, align 4
  %1579 = icmp eq i32 %1578, 16
  br i1 %1579, label %1580, label %1592

1580:                                             ; preds = %1577
  %1581 = load i32, ptr %19, align 4
  %1582 = icmp ne i32 %1581, 0
  br i1 %1582, label %1592, label %1583

1583:                                             ; preds = %1580
  br label %1584

1584:                                             ; preds = %1583
  br label %1585

1585:                                             ; preds = %1590, %1584
  br label %1586

1586:                                             ; preds = %1585
  store i32 -1, ptr %16, align 4
  %1587 = load ptr, ptr %9, align 8
  %1588 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1587, i32 0, i32 0
  store i32 17, ptr %1588, align 8
  br label %2905

1589:                                             ; preds = %119
  br label %1590

1590:                                             ; preds = %1589
  br label %1585

1591:                                             ; No predecessors!
  br label %1592

1592:                                             ; preds = %1591, %1580, %1577
  %1593 = load i32, ptr %18, align 4
  %1594 = sub i32 %1593, 16
  %1595 = zext i32 %1594 to i64
  %1596 = getelementptr inbounds [4 x i8], ptr @.str.12, i64 0, i64 %1595
  %1597 = load i8, ptr %1596, align 1
  %1598 = sext i8 %1597 to i32
  store i32 %1598, ptr %20, align 4
  br label %1599

1599:                                             ; preds = %1592
  %1600 = load i32, ptr %17, align 4
  %1601 = load i32, ptr %20, align 4
  %1602 = icmp ult i32 %1600, %1601
  br i1 %1602, label %1603, label %1653

1603:                                             ; preds = %1599
  br label %1604

1604:                                             ; preds = %1648, %1603
  br label %1605

1605:                                             ; preds = %1604
  %1606 = load ptr, ptr %22, align 8
  %1607 = load ptr, ptr %23, align 8
  %1608 = icmp uge ptr %1606, %1607
  br i1 %1608, label %1609, label %1632

1609:                                             ; preds = %1605
  br label %1610

1610:                                             ; preds = %1630, %1609
  %1611 = load i32, ptr %15, align 4
  %1612 = and i32 %1611, 2
  %1613 = icmp ne i32 %1612, 0
  br i1 %1613, label %1614, label %1629

1614:                                             ; preds = %1610
  br label %1615

1615:                                             ; preds = %1614
  store i32 1, ptr %16, align 4
  %1616 = load ptr, ptr %9, align 8
  %1617 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1616, i32 0, i32 0
  store i32 18, ptr %1617, align 8
  br label %2905

1618:                                             ; preds = %119
  br label %1619

1619:                                             ; preds = %1618
  %1620 = load ptr, ptr %22, align 8
  %1621 = load ptr, ptr %23, align 8
  %1622 = icmp ult ptr %1620, %1621
  br i1 %1622, label %1623, label %1628

1623:                                             ; preds = %1619
  %1624 = load ptr, ptr %22, align 8
  %1625 = getelementptr inbounds i8, ptr %1624, i32 1
  store ptr %1625, ptr %22, align 8
  %1626 = load i8, ptr %1624, align 1
  %1627 = zext i8 %1626 to i32
  store i32 %1627, ptr %57, align 4
  br label %1631

1628:                                             ; preds = %1619
  br label %1630

1629:                                             ; preds = %1610
  store i32 0, ptr %57, align 4
  br label %1631

1630:                                             ; preds = %1628
  br label %1610

1631:                                             ; preds = %1629, %1623
  br label %1637

1632:                                             ; preds = %1605
  %1633 = load ptr, ptr %22, align 8
  %1634 = getelementptr inbounds i8, ptr %1633, i32 1
  store ptr %1634, ptr %22, align 8
  %1635 = load i8, ptr %1633, align 1
  %1636 = zext i8 %1635 to i32
  store i32 %1636, ptr %57, align 4
  br label %1637

1637:                                             ; preds = %1632, %1631
  br label %1638

1638:                                             ; preds = %1637
  %1639 = load i32, ptr %57, align 4
  %1640 = zext i32 %1639 to i64
  %1641 = load i32, ptr %17, align 4
  %1642 = zext i32 %1641 to i64
  %1643 = shl i64 %1640, %1642
  %1644 = load i64, ptr %21, align 8
  %1645 = or i64 %1644, %1643
  store i64 %1645, ptr %21, align 8
  %1646 = load i32, ptr %17, align 4
  %1647 = add i32 %1646, 8
  store i32 %1647, ptr %17, align 4
  br label %1648

1648:                                             ; preds = %1638
  %1649 = load i32, ptr %17, align 4
  %1650 = load i32, ptr %20, align 4
  %1651 = icmp ult i32 %1649, %1650
  br i1 %1651, label %1604, label %1652, !llvm.loop !38

1652:                                             ; preds = %1648
  br label %1653

1653:                                             ; preds = %1652, %1599
  %1654 = load i64, ptr %21, align 8
  %1655 = load i32, ptr %20, align 4
  %1656 = shl i32 1, %1655
  %1657 = sub nsw i32 %1656, 1
  %1658 = sext i32 %1657 to i64
  %1659 = and i64 %1654, %1658
  %1660 = trunc i64 %1659 to i32
  store i32 %1660, ptr %53, align 4
  %1661 = load i32, ptr %20, align 4
  %1662 = load i64, ptr %21, align 8
  %1663 = zext i32 %1661 to i64
  %1664 = lshr i64 %1662, %1663
  store i64 %1664, ptr %21, align 8
  %1665 = load i32, ptr %20, align 4
  %1666 = load i32, ptr %17, align 4
  %1667 = sub i32 %1666, %1665
  store i32 %1667, ptr %17, align 4
  br label %1668

1668:                                             ; preds = %1653
  %1669 = load i32, ptr %18, align 4
  %1670 = sub i32 %1669, 16
  %1671 = zext i32 %1670 to i64
  %1672 = getelementptr inbounds [4 x i8], ptr @.str.13, i64 0, i64 %1671
  %1673 = load i8, ptr %1672, align 1
  %1674 = sext i8 %1673 to i32
  %1675 = load i32, ptr %53, align 4
  %1676 = add i32 %1675, %1674
  store i32 %1676, ptr %53, align 4
  %1677 = load ptr, ptr %9, align 8
  %1678 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1677, i32 0, i32 18
  %1679 = getelementptr inbounds [457 x i8], ptr %1678, i64 0, i64 0
  %1680 = load i32, ptr %19, align 4
  %1681 = zext i32 %1680 to i64
  %1682 = getelementptr inbounds i8, ptr %1679, i64 %1681
  %1683 = load i32, ptr %18, align 4
  %1684 = icmp eq i32 %1683, 16
  br i1 %1684, label %1685, label %1694

1685:                                             ; preds = %1668
  %1686 = load ptr, ptr %9, align 8
  %1687 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1686, i32 0, i32 18
  %1688 = load i32, ptr %19, align 4
  %1689 = sub i32 %1688, 1
  %1690 = zext i32 %1689 to i64
  %1691 = getelementptr inbounds [457 x i8], ptr %1687, i64 0, i64 %1690
  %1692 = load i8, ptr %1691, align 1
  %1693 = zext i8 %1692 to i32
  br label %1695

1694:                                             ; preds = %1668
  br label %1695

1695:                                             ; preds = %1694, %1685
  %1696 = phi i32 [ %1693, %1685 ], [ 0, %1694 ]
  %1697 = load i32, ptr %53, align 4
  %1698 = zext i32 %1697 to i64
  %1699 = load ptr, ptr %9, align 8
  %1700 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1699, i32 0, i32 18
  %1701 = getelementptr inbounds [457 x i8], ptr %1700, i64 0, i64 0
  %1702 = load i32, ptr %19, align 4
  %1703 = zext i32 %1702 to i64
  %1704 = getelementptr inbounds i8, ptr %1701, i64 %1703
  %1705 = call i64 @llvm.objectsize.i64.p0(ptr %1704, i1 false, i1 true, i1 false)
  %1706 = call ptr @__memset_chk(ptr noundef %1682, i32 noundef %1696, i64 noundef %1698, i64 noundef %1705) #12
  %1707 = load i32, ptr %53, align 4
  %1708 = load i32, ptr %19, align 4
  %1709 = add i32 %1708, %1707
  store i32 %1709, ptr %19, align 4
  br label %1360, !llvm.loop !37

1710:                                             ; preds = %1360
  %1711 = load ptr, ptr %9, align 8
  %1712 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1711, i32 0, i32 13
  %1713 = getelementptr inbounds [3 x i32], ptr %1712, i64 0, i64 0
  %1714 = load i32, ptr %1713, align 4
  %1715 = load ptr, ptr %9, align 8
  %1716 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1715, i32 0, i32 13
  %1717 = getelementptr inbounds [3 x i32], ptr %1716, i64 0, i64 1
  %1718 = load i32, ptr %1717, align 4
  %1719 = add i32 %1714, %1718
  %1720 = load i32, ptr %19, align 4
  %1721 = icmp ne i32 %1719, %1720
  br i1 %1721, label %1722, label %1731

1722:                                             ; preds = %1710
  br label %1723

1723:                                             ; preds = %1722
  br label %1724

1724:                                             ; preds = %1729, %1723
  br label %1725

1725:                                             ; preds = %1724
  store i32 -1, ptr %16, align 4
  %1726 = load ptr, ptr %9, align 8
  %1727 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1726, i32 0, i32 0
  store i32 21, ptr %1727, align 8
  br label %2905

1728:                                             ; preds = %119
  br label %1729

1729:                                             ; preds = %1728
  br label %1724

1730:                                             ; No predecessors!
  br label %1731

1731:                                             ; preds = %1730, %1710
  %1732 = load ptr, ptr %9, align 8
  %1733 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1732, i32 0, i32 16
  %1734 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1733, i64 0, i64 0
  %1735 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1734, i32 0, i32 0
  %1736 = getelementptr inbounds [288 x i8], ptr %1735, i64 0, i64 0
  %1737 = load ptr, ptr %9, align 8
  %1738 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1737, i32 0, i32 18
  %1739 = getelementptr inbounds [457 x i8], ptr %1738, i64 0, i64 0
  %1740 = load ptr, ptr %9, align 8
  %1741 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1740, i32 0, i32 13
  %1742 = getelementptr inbounds [3 x i32], ptr %1741, i64 0, i64 0
  %1743 = load i32, ptr %1742, align 4
  %1744 = zext i32 %1743 to i64
  %1745 = load ptr, ptr %9, align 8
  %1746 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1745, i32 0, i32 16
  %1747 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1746, i64 0, i64 0
  %1748 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1747, i32 0, i32 0
  %1749 = getelementptr inbounds [288 x i8], ptr %1748, i64 0, i64 0
  %1750 = call i64 @llvm.objectsize.i64.p0(ptr %1749, i1 false, i1 true, i1 false)
  %1751 = call ptr @__memcpy_chk(ptr noundef %1736, ptr noundef %1739, i64 noundef %1744, i64 noundef %1750) #12
  %1752 = load ptr, ptr %9, align 8
  %1753 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1752, i32 0, i32 16
  %1754 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1753, i64 0, i64 1
  %1755 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1754, i32 0, i32 0
  %1756 = getelementptr inbounds [288 x i8], ptr %1755, i64 0, i64 0
  %1757 = load ptr, ptr %9, align 8
  %1758 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1757, i32 0, i32 18
  %1759 = getelementptr inbounds [457 x i8], ptr %1758, i64 0, i64 0
  %1760 = load ptr, ptr %9, align 8
  %1761 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1760, i32 0, i32 13
  %1762 = getelementptr inbounds [3 x i32], ptr %1761, i64 0, i64 0
  %1763 = load i32, ptr %1762, align 4
  %1764 = zext i32 %1763 to i64
  %1765 = getelementptr inbounds i8, ptr %1759, i64 %1764
  %1766 = load ptr, ptr %9, align 8
  %1767 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1766, i32 0, i32 13
  %1768 = getelementptr inbounds [3 x i32], ptr %1767, i64 0, i64 1
  %1769 = load i32, ptr %1768, align 4
  %1770 = zext i32 %1769 to i64
  %1771 = load ptr, ptr %9, align 8
  %1772 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1771, i32 0, i32 16
  %1773 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1772, i64 0, i64 1
  %1774 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1773, i32 0, i32 0
  %1775 = getelementptr inbounds [288 x i8], ptr %1774, i64 0, i64 0
  %1776 = call i64 @llvm.objectsize.i64.p0(ptr %1775, i1 false, i1 true, i1 false)
  %1777 = call ptr @__memcpy_chk(ptr noundef %1756, ptr noundef %1765, i64 noundef %1770, i64 noundef %1776) #12
  br label %1778

1778:                                             ; preds = %1731, %1354
  br label %1779

1779:                                             ; preds = %1778
  %1780 = load ptr, ptr %9, align 8
  %1781 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1780, i32 0, i32 7
  %1782 = load i32, ptr %1781, align 4
  %1783 = add i32 %1782, -1
  store i32 %1783, ptr %1781, align 4
  br label %1105, !llvm.loop !39

1784:                                             ; preds = %1105
  br label %1785

1785:                                             ; preds = %2696, %2646, %2588, %1784
  br label %1786

1786:                                             ; preds = %2142, %1785
  %1787 = load ptr, ptr %23, align 8
  %1788 = load ptr, ptr %22, align 8
  %1789 = ptrtoint ptr %1787 to i64
  %1790 = ptrtoint ptr %1788 to i64
  %1791 = sub i64 %1789, %1790
  %1792 = icmp slt i64 %1791, 4
  br i1 %1792, label %1800, label %1793

1793:                                             ; preds = %1786
  %1794 = load ptr, ptr %25, align 8
  %1795 = load ptr, ptr %24, align 8
  %1796 = ptrtoint ptr %1794 to i64
  %1797 = ptrtoint ptr %1795 to i64
  %1798 = sub i64 %1796, %1797
  %1799 = icmp slt i64 %1798, 2
  br i1 %1799, label %1800, label %2013

1800:                                             ; preds = %1793, %1786
  br label %1801

1801:                                             ; preds = %1800
  %1802 = load i32, ptr %17, align 4
  %1803 = icmp ult i32 %1802, 15
  br i1 %1803, label %1804, label %1945

1804:                                             ; preds = %1801
  %1805 = load ptr, ptr %23, align 8
  %1806 = load ptr, ptr %22, align 8
  %1807 = ptrtoint ptr %1805 to i64
  %1808 = ptrtoint ptr %1806 to i64
  %1809 = sub i64 %1807, %1808
  %1810 = icmp slt i64 %1809, 2
  br i1 %1810, label %1811, label %1921

1811:                                             ; preds = %1804
  br label %1812

1812:                                             ; preds = %1917, %1811
  %1813 = load ptr, ptr %9, align 8
  %1814 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1813, i32 0, i32 16
  %1815 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1814, i64 0, i64 0
  %1816 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1815, i32 0, i32 1
  %1817 = load i64, ptr %21, align 8
  %1818 = and i64 %1817, 1023
  %1819 = getelementptr inbounds [1024 x i32], ptr %1816, i64 0, i64 %1818
  %1820 = load i32, ptr %1819, align 2
  %1821 = add i32 %1820, 0
  store i32 %1821, ptr %59, align 4
  %1822 = load i32, ptr %59, align 4
  %1823 = icmp sge i32 %1822, 0
  br i1 %1823, label %1824, label %1835

1824:                                             ; preds = %1812
  %1825 = load i32, ptr %59, align 4
  %1826 = ashr i32 %1825, 9
  store i32 %1826, ptr %60, align 4
  %1827 = load i32, ptr %60, align 4
  %1828 = icmp ne i32 %1827, 0
  br i1 %1828, label %1829, label %1834

1829:                                             ; preds = %1824
  %1830 = load i32, ptr %17, align 4
  %1831 = load i32, ptr %60, align 4
  %1832 = icmp uge i32 %1830, %1831
  br i1 %1832, label %1833, label %1834

1833:                                             ; preds = %1829
  br label %1920

1834:                                             ; preds = %1829, %1824
  br label %1873

1835:                                             ; preds = %1812
  %1836 = load i32, ptr %17, align 4
  %1837 = icmp ugt i32 %1836, 10
  br i1 %1837, label %1838, label %1872

1838:                                             ; preds = %1835
  store i32 10, ptr %60, align 4
  br label %1839

1839:                                             ; preds = %1865, %1838
  %1840 = load ptr, ptr %9, align 8
  %1841 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1840, i32 0, i32 16
  %1842 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1841, i64 0, i64 0
  %1843 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1842, i32 0, i32 2
  %1844 = load i32, ptr %59, align 4
  %1845 = xor i32 %1844, -1
  %1846 = sext i32 %1845 to i64
  %1847 = load i64, ptr %21, align 8
  %1848 = load i32, ptr %60, align 4
  %1849 = add i32 %1848, 1
  store i32 %1849, ptr %60, align 4
  %1850 = zext i32 %1848 to i64
  %1851 = lshr i64 %1847, %1850
  %1852 = and i64 %1851, 1
  %1853 = add i64 %1846, %1852
  %1854 = getelementptr inbounds [576 x i32], ptr %1843, i64 0, i64 %1853
  %1855 = load i32, ptr %1854, align 2
  %1856 = add i32 %1855, 0
  store i32 %1856, ptr %59, align 4
  br label %1857

1857:                                             ; preds = %1839
  %1858 = load i32, ptr %59, align 4
  %1859 = icmp slt i32 %1858, 0
  br i1 %1859, label %1860, label %1865

1860:                                             ; preds = %1857
  %1861 = load i32, ptr %17, align 4
  %1862 = load i32, ptr %60, align 4
  %1863 = add i32 %1862, 1
  %1864 = icmp uge i32 %1861, %1863
  br label %1865

1865:                                             ; preds = %1860, %1857
  %1866 = phi i1 [ false, %1857 ], [ %1864, %1860 ]
  br i1 %1866, label %1839, label %1867, !llvm.loop !40

1867:                                             ; preds = %1865
  %1868 = load i32, ptr %59, align 4
  %1869 = icmp sge i32 %1868, 0
  br i1 %1869, label %1870, label %1871

1870:                                             ; preds = %1867
  br label %1920

1871:                                             ; preds = %1867
  br label %1872

1872:                                             ; preds = %1871, %1835
  br label %1873

1873:                                             ; preds = %1872, %1834
  br label %1874

1874:                                             ; preds = %1873
  %1875 = load ptr, ptr %22, align 8
  %1876 = load ptr, ptr %23, align 8
  %1877 = icmp uge ptr %1875, %1876
  br i1 %1877, label %1878, label %1901

1878:                                             ; preds = %1874
  br label %1879

1879:                                             ; preds = %1899, %1878
  %1880 = load i32, ptr %15, align 4
  %1881 = and i32 %1880, 2
  %1882 = icmp ne i32 %1881, 0
  br i1 %1882, label %1883, label %1898

1883:                                             ; preds = %1879
  br label %1884

1884:                                             ; preds = %1883
  store i32 1, ptr %16, align 4
  %1885 = load ptr, ptr %9, align 8
  %1886 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1885, i32 0, i32 0
  store i32 23, ptr %1886, align 8
  br label %2905

1887:                                             ; preds = %119
  br label %1888

1888:                                             ; preds = %1887
  %1889 = load ptr, ptr %22, align 8
  %1890 = load ptr, ptr %23, align 8
  %1891 = icmp ult ptr %1889, %1890
  br i1 %1891, label %1892, label %1897

1892:                                             ; preds = %1888
  %1893 = load ptr, ptr %22, align 8
  %1894 = getelementptr inbounds i8, ptr %1893, i32 1
  store ptr %1894, ptr %22, align 8
  %1895 = load i8, ptr %1893, align 1
  %1896 = zext i8 %1895 to i32
  store i32 %1896, ptr %61, align 4
  br label %1900

1897:                                             ; preds = %1888
  br label %1899

1898:                                             ; preds = %1879
  store i32 0, ptr %61, align 4
  br label %1900

1899:                                             ; preds = %1897
  br label %1879

1900:                                             ; preds = %1898, %1892
  br label %1906

1901:                                             ; preds = %1874
  %1902 = load ptr, ptr %22, align 8
  %1903 = getelementptr inbounds i8, ptr %1902, i32 1
  store ptr %1903, ptr %22, align 8
  %1904 = load i8, ptr %1902, align 1
  %1905 = zext i8 %1904 to i32
  store i32 %1905, ptr %61, align 4
  br label %1906

1906:                                             ; preds = %1901, %1900
  br label %1907

1907:                                             ; preds = %1906
  %1908 = load i32, ptr %61, align 4
  %1909 = zext i32 %1908 to i64
  %1910 = load i32, ptr %17, align 4
  %1911 = zext i32 %1910 to i64
  %1912 = shl i64 %1909, %1911
  %1913 = load i64, ptr %21, align 8
  %1914 = or i64 %1913, %1912
  store i64 %1914, ptr %21, align 8
  %1915 = load i32, ptr %17, align 4
  %1916 = add i32 %1915, 8
  store i32 %1916, ptr %17, align 4
  br label %1917

1917:                                             ; preds = %1907
  %1918 = load i32, ptr %17, align 4
  %1919 = icmp ult i32 %1918, 15
  br i1 %1919, label %1812, label %1920, !llvm.loop !41

1920:                                             ; preds = %1917, %1870, %1833
  br label %1944

1921:                                             ; preds = %1804
  %1922 = load ptr, ptr %22, align 8
  %1923 = getelementptr inbounds i8, ptr %1922, i64 0
  %1924 = load i8, ptr %1923, align 1
  %1925 = zext i8 %1924 to i64
  %1926 = load i32, ptr %17, align 4
  %1927 = zext i32 %1926 to i64
  %1928 = shl i64 %1925, %1927
  %1929 = load ptr, ptr %22, align 8
  %1930 = getelementptr inbounds i8, ptr %1929, i64 1
  %1931 = load i8, ptr %1930, align 1
  %1932 = zext i8 %1931 to i64
  %1933 = load i32, ptr %17, align 4
  %1934 = add i32 %1933, 8
  %1935 = zext i32 %1934 to i64
  %1936 = shl i64 %1932, %1935
  %1937 = or i64 %1928, %1936
  %1938 = load i64, ptr %21, align 8
  %1939 = or i64 %1938, %1937
  store i64 %1939, ptr %21, align 8
  %1940 = load ptr, ptr %22, align 8
  %1941 = getelementptr inbounds i8, ptr %1940, i64 2
  store ptr %1941, ptr %22, align 8
  %1942 = load i32, ptr %17, align 4
  %1943 = add i32 %1942, 16
  store i32 %1943, ptr %17, align 4
  br label %1944

1944:                                             ; preds = %1921, %1920
  br label %1945

1945:                                             ; preds = %1944, %1801
  %1946 = load ptr, ptr %9, align 8
  %1947 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1946, i32 0, i32 16
  %1948 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1947, i64 0, i64 0
  %1949 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1948, i32 0, i32 1
  %1950 = load i64, ptr %21, align 8
  %1951 = and i64 %1950, 1023
  %1952 = getelementptr inbounds [1024 x i32], ptr %1949, i64 0, i64 %1951
  %1953 = load i32, ptr %1952, align 2
  %1954 = add i32 %1953, 0
  store i32 %1954, ptr %59, align 4
  %1955 = icmp sge i32 %1954, 0
  br i1 %1955, label %1956, label %1961

1956:                                             ; preds = %1945
  %1957 = load i32, ptr %59, align 4
  %1958 = ashr i32 %1957, 9
  store i32 %1958, ptr %60, align 4
  %1959 = load i32, ptr %59, align 4
  %1960 = and i32 %1959, 511
  store i32 %1960, ptr %59, align 4
  br label %1984

1961:                                             ; preds = %1945
  store i32 10, ptr %60, align 4
  br label %1962

1962:                                             ; preds = %1980, %1961
  %1963 = load ptr, ptr %9, align 8
  %1964 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %1963, i32 0, i32 16
  %1965 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %1964, i64 0, i64 0
  %1966 = getelementptr inbounds %struct.tinfl_huff_table, ptr %1965, i32 0, i32 2
  %1967 = load i32, ptr %59, align 4
  %1968 = xor i32 %1967, -1
  %1969 = sext i32 %1968 to i64
  %1970 = load i64, ptr %21, align 8
  %1971 = load i32, ptr %60, align 4
  %1972 = add i32 %1971, 1
  store i32 %1972, ptr %60, align 4
  %1973 = zext i32 %1971 to i64
  %1974 = lshr i64 %1970, %1973
  %1975 = and i64 %1974, 1
  %1976 = add i64 %1969, %1975
  %1977 = getelementptr inbounds [576 x i32], ptr %1966, i64 0, i64 %1976
  %1978 = load i32, ptr %1977, align 2
  %1979 = add i32 %1978, 0
  store i32 %1979, ptr %59, align 4
  br label %1980

1980:                                             ; preds = %1962
  %1981 = load i32, ptr %59, align 4
  %1982 = icmp slt i32 %1981, 0
  br i1 %1982, label %1962, label %1983, !llvm.loop !42

1983:                                             ; preds = %1980
  br label %1984

1984:                                             ; preds = %1983, %1956
  %1985 = load i32, ptr %59, align 4
  store i32 %1985, ptr %19, align 4
  %1986 = load i32, ptr %60, align 4
  %1987 = load i64, ptr %21, align 8
  %1988 = zext i32 %1986 to i64
  %1989 = lshr i64 %1987, %1988
  store i64 %1989, ptr %21, align 8
  %1990 = load i32, ptr %60, align 4
  %1991 = load i32, ptr %17, align 4
  %1992 = sub i32 %1991, %1990
  store i32 %1992, ptr %17, align 4
  br label %1993

1993:                                             ; preds = %1984
  %1994 = load i32, ptr %19, align 4
  %1995 = icmp uge i32 %1994, 256
  br i1 %1995, label %1996, label %1997

1996:                                             ; preds = %1993
  br label %2143

1997:                                             ; preds = %1993
  br label %1998

1998:                                             ; preds = %2007, %1997
  %1999 = load ptr, ptr %24, align 8
  %2000 = load ptr, ptr %25, align 8
  %2001 = icmp uge ptr %1999, %2000
  br i1 %2001, label %2002, label %2008

2002:                                             ; preds = %1998
  br label %2003

2003:                                             ; preds = %2002
  store i32 2, ptr %16, align 4
  %2004 = load ptr, ptr %9, align 8
  %2005 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2004, i32 0, i32 0
  store i32 24, ptr %2005, align 8
  br label %2905

2006:                                             ; preds = %119
  br label %2007

2007:                                             ; preds = %2006
  br label %1998, !llvm.loop !43

2008:                                             ; preds = %1998
  %2009 = load i32, ptr %19, align 4
  %2010 = trunc i32 %2009 to i8
  %2011 = load ptr, ptr %24, align 8
  %2012 = getelementptr inbounds i8, ptr %2011, i32 1
  store ptr %2012, ptr %24, align 8
  store i8 %2010, ptr %2011, align 1
  br label %2142

2013:                                             ; preds = %1793
  %2014 = load i32, ptr %17, align 4
  %2015 = icmp ult i32 %2014, 30
  br i1 %2015, label %2016, label %2029

2016:                                             ; preds = %2013
  %2017 = load ptr, ptr %22, align 8
  %2018 = load i32, ptr %2017, align 4
  %2019 = zext i32 %2018 to i64
  %2020 = load i32, ptr %17, align 4
  %2021 = zext i32 %2020 to i64
  %2022 = shl i64 %2019, %2021
  %2023 = load i64, ptr %21, align 8
  %2024 = or i64 %2023, %2022
  store i64 %2024, ptr %21, align 8
  %2025 = load ptr, ptr %22, align 8
  %2026 = getelementptr inbounds i8, ptr %2025, i64 4
  store ptr %2026, ptr %22, align 8
  %2027 = load i32, ptr %17, align 4
  %2028 = add i32 %2027, 32
  store i32 %2028, ptr %17, align 4
  br label %2029

2029:                                             ; preds = %2016, %2013
  %2030 = load ptr, ptr %9, align 8
  %2031 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2030, i32 0, i32 16
  %2032 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2031, i64 0, i64 0
  %2033 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2032, i32 0, i32 1
  %2034 = load i64, ptr %21, align 8
  %2035 = and i64 %2034, 1023
  %2036 = getelementptr inbounds [1024 x i32], ptr %2033, i64 0, i64 %2035
  %2037 = load i32, ptr %2036, align 2
  %2038 = add i32 %2037, 0
  store i32 %2038, ptr %62, align 4
  %2039 = icmp sge i32 %2038, 0
  br i1 %2039, label %2040, label %2043

2040:                                             ; preds = %2029
  %2041 = load i32, ptr %62, align 4
  %2042 = ashr i32 %2041, 9
  store i32 %2042, ptr %63, align 4
  br label %2066

2043:                                             ; preds = %2029
  store i32 10, ptr %63, align 4
  br label %2044

2044:                                             ; preds = %2062, %2043
  %2045 = load ptr, ptr %9, align 8
  %2046 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2045, i32 0, i32 16
  %2047 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2046, i64 0, i64 0
  %2048 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2047, i32 0, i32 2
  %2049 = load i32, ptr %62, align 4
  %2050 = xor i32 %2049, -1
  %2051 = sext i32 %2050 to i64
  %2052 = load i64, ptr %21, align 8
  %2053 = load i32, ptr %63, align 4
  %2054 = add i32 %2053, 1
  store i32 %2054, ptr %63, align 4
  %2055 = zext i32 %2053 to i64
  %2056 = lshr i64 %2052, %2055
  %2057 = and i64 %2056, 1
  %2058 = add i64 %2051, %2057
  %2059 = getelementptr inbounds [576 x i32], ptr %2048, i64 0, i64 %2058
  %2060 = load i32, ptr %2059, align 2
  %2061 = add i32 %2060, 0
  store i32 %2061, ptr %62, align 4
  br label %2062

2062:                                             ; preds = %2044
  %2063 = load i32, ptr %62, align 4
  %2064 = icmp slt i32 %2063, 0
  br i1 %2064, label %2044, label %2065, !llvm.loop !44

2065:                                             ; preds = %2062
  br label %2066

2066:                                             ; preds = %2065, %2040
  %2067 = load i32, ptr %62, align 4
  store i32 %2067, ptr %19, align 4
  %2068 = load i32, ptr %63, align 4
  %2069 = load i64, ptr %21, align 8
  %2070 = zext i32 %2068 to i64
  %2071 = lshr i64 %2069, %2070
  store i64 %2071, ptr %21, align 8
  %2072 = load i32, ptr %63, align 4
  %2073 = load i32, ptr %17, align 4
  %2074 = sub i32 %2073, %2072
  store i32 %2074, ptr %17, align 4
  %2075 = load i32, ptr %19, align 4
  %2076 = and i32 %2075, 256
  %2077 = icmp ne i32 %2076, 0
  br i1 %2077, label %2078, label %2079

2078:                                             ; preds = %2066
  br label %2143

2079:                                             ; preds = %2066
  %2080 = load ptr, ptr %9, align 8
  %2081 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2080, i32 0, i32 16
  %2082 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2081, i64 0, i64 0
  %2083 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2082, i32 0, i32 1
  %2084 = load i64, ptr %21, align 8
  %2085 = and i64 %2084, 1023
  %2086 = getelementptr inbounds [1024 x i32], ptr %2083, i64 0, i64 %2085
  %2087 = load i32, ptr %2086, align 2
  %2088 = add i32 %2087, 0
  store i32 %2088, ptr %62, align 4
  %2089 = icmp sge i32 %2088, 0
  br i1 %2089, label %2090, label %2093

2090:                                             ; preds = %2079
  %2091 = load i32, ptr %62, align 4
  %2092 = ashr i32 %2091, 9
  store i32 %2092, ptr %63, align 4
  br label %2116

2093:                                             ; preds = %2079
  store i32 10, ptr %63, align 4
  br label %2094

2094:                                             ; preds = %2112, %2093
  %2095 = load ptr, ptr %9, align 8
  %2096 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2095, i32 0, i32 16
  %2097 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2096, i64 0, i64 0
  %2098 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2097, i32 0, i32 2
  %2099 = load i32, ptr %62, align 4
  %2100 = xor i32 %2099, -1
  %2101 = sext i32 %2100 to i64
  %2102 = load i64, ptr %21, align 8
  %2103 = load i32, ptr %63, align 4
  %2104 = add i32 %2103, 1
  store i32 %2104, ptr %63, align 4
  %2105 = zext i32 %2103 to i64
  %2106 = lshr i64 %2102, %2105
  %2107 = and i64 %2106, 1
  %2108 = add i64 %2101, %2107
  %2109 = getelementptr inbounds [576 x i32], ptr %2098, i64 0, i64 %2108
  %2110 = load i32, ptr %2109, align 2
  %2111 = add i32 %2110, 0
  store i32 %2111, ptr %62, align 4
  br label %2112

2112:                                             ; preds = %2094
  %2113 = load i32, ptr %62, align 4
  %2114 = icmp slt i32 %2113, 0
  br i1 %2114, label %2094, label %2115, !llvm.loop !45

2115:                                             ; preds = %2112
  br label %2116

2116:                                             ; preds = %2115, %2090
  %2117 = load i32, ptr %63, align 4
  %2118 = load i64, ptr %21, align 8
  %2119 = zext i32 %2117 to i64
  %2120 = lshr i64 %2118, %2119
  store i64 %2120, ptr %21, align 8
  %2121 = load i32, ptr %63, align 4
  %2122 = load i32, ptr %17, align 4
  %2123 = sub i32 %2122, %2121
  store i32 %2123, ptr %17, align 4
  %2124 = load i32, ptr %19, align 4
  %2125 = trunc i32 %2124 to i8
  %2126 = load ptr, ptr %24, align 8
  %2127 = getelementptr inbounds i8, ptr %2126, i64 0
  store i8 %2125, ptr %2127, align 1
  %2128 = load i32, ptr %62, align 4
  %2129 = and i32 %2128, 256
  %2130 = icmp ne i32 %2129, 0
  br i1 %2130, label %2131, label %2135

2131:                                             ; preds = %2116
  %2132 = load ptr, ptr %24, align 8
  %2133 = getelementptr inbounds i8, ptr %2132, i32 1
  store ptr %2133, ptr %24, align 8
  %2134 = load i32, ptr %62, align 4
  store i32 %2134, ptr %19, align 4
  br label %2143

2135:                                             ; preds = %2116
  %2136 = load i32, ptr %62, align 4
  %2137 = trunc i32 %2136 to i8
  %2138 = load ptr, ptr %24, align 8
  %2139 = getelementptr inbounds i8, ptr %2138, i64 1
  store i8 %2137, ptr %2139, align 1
  %2140 = load ptr, ptr %24, align 8
  %2141 = getelementptr inbounds i8, ptr %2140, i64 2
  store ptr %2141, ptr %24, align 8
  br label %2142

2142:                                             ; preds = %2135, %2008
  br label %1786

2143:                                             ; preds = %2131, %2078, %1996
  %2144 = load i32, ptr %19, align 4
  %2145 = and i32 %2144, 511
  store i32 %2145, ptr %19, align 4
  %2146 = icmp eq i32 %2145, 256
  br i1 %2146, label %2147, label %2148

2147:                                             ; preds = %2143
  br label %2697

2148:                                             ; preds = %2143
  %2149 = load i32, ptr %19, align 4
  %2150 = sub i32 %2149, 257
  %2151 = zext i32 %2150 to i64
  %2152 = getelementptr inbounds [31 x i32], ptr @tinfl_decompress.s_length_extra, i64 0, i64 %2151
  %2153 = load i32, ptr %2152, align 4
  store i32 %2153, ptr %20, align 4
  %2154 = load i32, ptr %19, align 4
  %2155 = sub i32 %2154, 257
  %2156 = zext i32 %2155 to i64
  %2157 = getelementptr inbounds [31 x i32], ptr @tinfl_decompress.s_length_base, i64 0, i64 %2156
  %2158 = load i32, ptr %2157, align 4
  store i32 %2158, ptr %19, align 4
  %2159 = load i32, ptr %20, align 4
  %2160 = icmp ne i32 %2159, 0
  br i1 %2160, label %2161, label %2235

2161:                                             ; preds = %2148
  br label %2162

2162:                                             ; preds = %2161
  %2163 = load i32, ptr %17, align 4
  %2164 = load i32, ptr %20, align 4
  %2165 = icmp ult i32 %2163, %2164
  br i1 %2165, label %2166, label %2216

2166:                                             ; preds = %2162
  br label %2167

2167:                                             ; preds = %2211, %2166
  br label %2168

2168:                                             ; preds = %2167
  %2169 = load ptr, ptr %22, align 8
  %2170 = load ptr, ptr %23, align 8
  %2171 = icmp uge ptr %2169, %2170
  br i1 %2171, label %2172, label %2195

2172:                                             ; preds = %2168
  br label %2173

2173:                                             ; preds = %2193, %2172
  %2174 = load i32, ptr %15, align 4
  %2175 = and i32 %2174, 2
  %2176 = icmp ne i32 %2175, 0
  br i1 %2176, label %2177, label %2192

2177:                                             ; preds = %2173
  br label %2178

2178:                                             ; preds = %2177
  store i32 1, ptr %16, align 4
  %2179 = load ptr, ptr %9, align 8
  %2180 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2179, i32 0, i32 0
  store i32 25, ptr %2180, align 8
  br label %2905

2181:                                             ; preds = %119
  br label %2182

2182:                                             ; preds = %2181
  %2183 = load ptr, ptr %22, align 8
  %2184 = load ptr, ptr %23, align 8
  %2185 = icmp ult ptr %2183, %2184
  br i1 %2185, label %2186, label %2191

2186:                                             ; preds = %2182
  %2187 = load ptr, ptr %22, align 8
  %2188 = getelementptr inbounds i8, ptr %2187, i32 1
  store ptr %2188, ptr %22, align 8
  %2189 = load i8, ptr %2187, align 1
  %2190 = zext i8 %2189 to i32
  store i32 %2190, ptr %65, align 4
  br label %2194

2191:                                             ; preds = %2182
  br label %2193

2192:                                             ; preds = %2173
  store i32 0, ptr %65, align 4
  br label %2194

2193:                                             ; preds = %2191
  br label %2173

2194:                                             ; preds = %2192, %2186
  br label %2200

2195:                                             ; preds = %2168
  %2196 = load ptr, ptr %22, align 8
  %2197 = getelementptr inbounds i8, ptr %2196, i32 1
  store ptr %2197, ptr %22, align 8
  %2198 = load i8, ptr %2196, align 1
  %2199 = zext i8 %2198 to i32
  store i32 %2199, ptr %65, align 4
  br label %2200

2200:                                             ; preds = %2195, %2194
  br label %2201

2201:                                             ; preds = %2200
  %2202 = load i32, ptr %65, align 4
  %2203 = zext i32 %2202 to i64
  %2204 = load i32, ptr %17, align 4
  %2205 = zext i32 %2204 to i64
  %2206 = shl i64 %2203, %2205
  %2207 = load i64, ptr %21, align 8
  %2208 = or i64 %2207, %2206
  store i64 %2208, ptr %21, align 8
  %2209 = load i32, ptr %17, align 4
  %2210 = add i32 %2209, 8
  store i32 %2210, ptr %17, align 4
  br label %2211

2211:                                             ; preds = %2201
  %2212 = load i32, ptr %17, align 4
  %2213 = load i32, ptr %20, align 4
  %2214 = icmp ult i32 %2212, %2213
  br i1 %2214, label %2167, label %2215, !llvm.loop !46

2215:                                             ; preds = %2211
  br label %2216

2216:                                             ; preds = %2215, %2162
  %2217 = load i64, ptr %21, align 8
  %2218 = load i32, ptr %20, align 4
  %2219 = shl i32 1, %2218
  %2220 = sub nsw i32 %2219, 1
  %2221 = sext i32 %2220 to i64
  %2222 = and i64 %2217, %2221
  %2223 = trunc i64 %2222 to i32
  store i32 %2223, ptr %64, align 4
  %2224 = load i32, ptr %20, align 4
  %2225 = load i64, ptr %21, align 8
  %2226 = zext i32 %2224 to i64
  %2227 = lshr i64 %2225, %2226
  store i64 %2227, ptr %21, align 8
  %2228 = load i32, ptr %20, align 4
  %2229 = load i32, ptr %17, align 4
  %2230 = sub i32 %2229, %2228
  store i32 %2230, ptr %17, align 4
  br label %2231

2231:                                             ; preds = %2216
  %2232 = load i32, ptr %64, align 4
  %2233 = load i32, ptr %19, align 4
  %2234 = add i32 %2233, %2232
  store i32 %2234, ptr %19, align 4
  br label %2235

2235:                                             ; preds = %2231, %2148
  br label %2236

2236:                                             ; preds = %2235
  %2237 = load i32, ptr %17, align 4
  %2238 = icmp ult i32 %2237, 15
  br i1 %2238, label %2239, label %2380

2239:                                             ; preds = %2236
  %2240 = load ptr, ptr %23, align 8
  %2241 = load ptr, ptr %22, align 8
  %2242 = ptrtoint ptr %2240 to i64
  %2243 = ptrtoint ptr %2241 to i64
  %2244 = sub i64 %2242, %2243
  %2245 = icmp slt i64 %2244, 2
  br i1 %2245, label %2246, label %2356

2246:                                             ; preds = %2239
  br label %2247

2247:                                             ; preds = %2352, %2246
  %2248 = load ptr, ptr %9, align 8
  %2249 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2248, i32 0, i32 16
  %2250 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2249, i64 0, i64 1
  %2251 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2250, i32 0, i32 1
  %2252 = load i64, ptr %21, align 8
  %2253 = and i64 %2252, 1023
  %2254 = getelementptr inbounds [1024 x i32], ptr %2251, i64 0, i64 %2253
  %2255 = load i32, ptr %2254, align 2
  %2256 = add i32 %2255, 0
  store i32 %2256, ptr %66, align 4
  %2257 = load i32, ptr %66, align 4
  %2258 = icmp sge i32 %2257, 0
  br i1 %2258, label %2259, label %2270

2259:                                             ; preds = %2247
  %2260 = load i32, ptr %66, align 4
  %2261 = ashr i32 %2260, 9
  store i32 %2261, ptr %67, align 4
  %2262 = load i32, ptr %67, align 4
  %2263 = icmp ne i32 %2262, 0
  br i1 %2263, label %2264, label %2269

2264:                                             ; preds = %2259
  %2265 = load i32, ptr %17, align 4
  %2266 = load i32, ptr %67, align 4
  %2267 = icmp uge i32 %2265, %2266
  br i1 %2267, label %2268, label %2269

2268:                                             ; preds = %2264
  br label %2355

2269:                                             ; preds = %2264, %2259
  br label %2308

2270:                                             ; preds = %2247
  %2271 = load i32, ptr %17, align 4
  %2272 = icmp ugt i32 %2271, 10
  br i1 %2272, label %2273, label %2307

2273:                                             ; preds = %2270
  store i32 10, ptr %67, align 4
  br label %2274

2274:                                             ; preds = %2300, %2273
  %2275 = load ptr, ptr %9, align 8
  %2276 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2275, i32 0, i32 16
  %2277 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2276, i64 0, i64 1
  %2278 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2277, i32 0, i32 2
  %2279 = load i32, ptr %66, align 4
  %2280 = xor i32 %2279, -1
  %2281 = sext i32 %2280 to i64
  %2282 = load i64, ptr %21, align 8
  %2283 = load i32, ptr %67, align 4
  %2284 = add i32 %2283, 1
  store i32 %2284, ptr %67, align 4
  %2285 = zext i32 %2283 to i64
  %2286 = lshr i64 %2282, %2285
  %2287 = and i64 %2286, 1
  %2288 = add i64 %2281, %2287
  %2289 = getelementptr inbounds [576 x i32], ptr %2278, i64 0, i64 %2288
  %2290 = load i32, ptr %2289, align 2
  %2291 = add i32 %2290, 0
  store i32 %2291, ptr %66, align 4
  br label %2292

2292:                                             ; preds = %2274
  %2293 = load i32, ptr %66, align 4
  %2294 = icmp slt i32 %2293, 0
  br i1 %2294, label %2295, label %2300

2295:                                             ; preds = %2292
  %2296 = load i32, ptr %17, align 4
  %2297 = load i32, ptr %67, align 4
  %2298 = add i32 %2297, 1
  %2299 = icmp uge i32 %2296, %2298
  br label %2300

2300:                                             ; preds = %2295, %2292
  %2301 = phi i1 [ false, %2292 ], [ %2299, %2295 ]
  br i1 %2301, label %2274, label %2302, !llvm.loop !47

2302:                                             ; preds = %2300
  %2303 = load i32, ptr %66, align 4
  %2304 = icmp sge i32 %2303, 0
  br i1 %2304, label %2305, label %2306

2305:                                             ; preds = %2302
  br label %2355

2306:                                             ; preds = %2302
  br label %2307

2307:                                             ; preds = %2306, %2270
  br label %2308

2308:                                             ; preds = %2307, %2269
  br label %2309

2309:                                             ; preds = %2308
  %2310 = load ptr, ptr %22, align 8
  %2311 = load ptr, ptr %23, align 8
  %2312 = icmp uge ptr %2310, %2311
  br i1 %2312, label %2313, label %2336

2313:                                             ; preds = %2309
  br label %2314

2314:                                             ; preds = %2334, %2313
  %2315 = load i32, ptr %15, align 4
  %2316 = and i32 %2315, 2
  %2317 = icmp ne i32 %2316, 0
  br i1 %2317, label %2318, label %2333

2318:                                             ; preds = %2314
  br label %2319

2319:                                             ; preds = %2318
  store i32 1, ptr %16, align 4
  %2320 = load ptr, ptr %9, align 8
  %2321 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2320, i32 0, i32 0
  store i32 26, ptr %2321, align 8
  br label %2905

2322:                                             ; preds = %119
  br label %2323

2323:                                             ; preds = %2322
  %2324 = load ptr, ptr %22, align 8
  %2325 = load ptr, ptr %23, align 8
  %2326 = icmp ult ptr %2324, %2325
  br i1 %2326, label %2327, label %2332

2327:                                             ; preds = %2323
  %2328 = load ptr, ptr %22, align 8
  %2329 = getelementptr inbounds i8, ptr %2328, i32 1
  store ptr %2329, ptr %22, align 8
  %2330 = load i8, ptr %2328, align 1
  %2331 = zext i8 %2330 to i32
  store i32 %2331, ptr %68, align 4
  br label %2335

2332:                                             ; preds = %2323
  br label %2334

2333:                                             ; preds = %2314
  store i32 0, ptr %68, align 4
  br label %2335

2334:                                             ; preds = %2332
  br label %2314

2335:                                             ; preds = %2333, %2327
  br label %2341

2336:                                             ; preds = %2309
  %2337 = load ptr, ptr %22, align 8
  %2338 = getelementptr inbounds i8, ptr %2337, i32 1
  store ptr %2338, ptr %22, align 8
  %2339 = load i8, ptr %2337, align 1
  %2340 = zext i8 %2339 to i32
  store i32 %2340, ptr %68, align 4
  br label %2341

2341:                                             ; preds = %2336, %2335
  br label %2342

2342:                                             ; preds = %2341
  %2343 = load i32, ptr %68, align 4
  %2344 = zext i32 %2343 to i64
  %2345 = load i32, ptr %17, align 4
  %2346 = zext i32 %2345 to i64
  %2347 = shl i64 %2344, %2346
  %2348 = load i64, ptr %21, align 8
  %2349 = or i64 %2348, %2347
  store i64 %2349, ptr %21, align 8
  %2350 = load i32, ptr %17, align 4
  %2351 = add i32 %2350, 8
  store i32 %2351, ptr %17, align 4
  br label %2352

2352:                                             ; preds = %2342
  %2353 = load i32, ptr %17, align 4
  %2354 = icmp ult i32 %2353, 15
  br i1 %2354, label %2247, label %2355, !llvm.loop !48

2355:                                             ; preds = %2352, %2305, %2268
  br label %2379

2356:                                             ; preds = %2239
  %2357 = load ptr, ptr %22, align 8
  %2358 = getelementptr inbounds i8, ptr %2357, i64 0
  %2359 = load i8, ptr %2358, align 1
  %2360 = zext i8 %2359 to i64
  %2361 = load i32, ptr %17, align 4
  %2362 = zext i32 %2361 to i64
  %2363 = shl i64 %2360, %2362
  %2364 = load ptr, ptr %22, align 8
  %2365 = getelementptr inbounds i8, ptr %2364, i64 1
  %2366 = load i8, ptr %2365, align 1
  %2367 = zext i8 %2366 to i64
  %2368 = load i32, ptr %17, align 4
  %2369 = add i32 %2368, 8
  %2370 = zext i32 %2369 to i64
  %2371 = shl i64 %2367, %2370
  %2372 = or i64 %2363, %2371
  %2373 = load i64, ptr %21, align 8
  %2374 = or i64 %2373, %2372
  store i64 %2374, ptr %21, align 8
  %2375 = load ptr, ptr %22, align 8
  %2376 = getelementptr inbounds i8, ptr %2375, i64 2
  store ptr %2376, ptr %22, align 8
  %2377 = load i32, ptr %17, align 4
  %2378 = add i32 %2377, 16
  store i32 %2378, ptr %17, align 4
  br label %2379

2379:                                             ; preds = %2356, %2355
  br label %2380

2380:                                             ; preds = %2379, %2236
  %2381 = load ptr, ptr %9, align 8
  %2382 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2381, i32 0, i32 16
  %2383 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2382, i64 0, i64 1
  %2384 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2383, i32 0, i32 1
  %2385 = load i64, ptr %21, align 8
  %2386 = and i64 %2385, 1023
  %2387 = getelementptr inbounds [1024 x i32], ptr %2384, i64 0, i64 %2386
  %2388 = load i32, ptr %2387, align 2
  %2389 = add i32 %2388, 0
  store i32 %2389, ptr %66, align 4
  %2390 = icmp sge i32 %2389, 0
  br i1 %2390, label %2391, label %2396

2391:                                             ; preds = %2380
  %2392 = load i32, ptr %66, align 4
  %2393 = ashr i32 %2392, 9
  store i32 %2393, ptr %67, align 4
  %2394 = load i32, ptr %66, align 4
  %2395 = and i32 %2394, 511
  store i32 %2395, ptr %66, align 4
  br label %2419

2396:                                             ; preds = %2380
  store i32 10, ptr %67, align 4
  br label %2397

2397:                                             ; preds = %2415, %2396
  %2398 = load ptr, ptr %9, align 8
  %2399 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2398, i32 0, i32 16
  %2400 = getelementptr inbounds [3 x %struct.tinfl_huff_table], ptr %2399, i64 0, i64 1
  %2401 = getelementptr inbounds %struct.tinfl_huff_table, ptr %2400, i32 0, i32 2
  %2402 = load i32, ptr %66, align 4
  %2403 = xor i32 %2402, -1
  %2404 = sext i32 %2403 to i64
  %2405 = load i64, ptr %21, align 8
  %2406 = load i32, ptr %67, align 4
  %2407 = add i32 %2406, 1
  store i32 %2407, ptr %67, align 4
  %2408 = zext i32 %2406 to i64
  %2409 = lshr i64 %2405, %2408
  %2410 = and i64 %2409, 1
  %2411 = add i64 %2404, %2410
  %2412 = getelementptr inbounds [576 x i32], ptr %2401, i64 0, i64 %2411
  %2413 = load i32, ptr %2412, align 2
  %2414 = add i32 %2413, 0
  store i32 %2414, ptr %66, align 4
  br label %2415

2415:                                             ; preds = %2397
  %2416 = load i32, ptr %66, align 4
  %2417 = icmp slt i32 %2416, 0
  br i1 %2417, label %2397, label %2418, !llvm.loop !49

2418:                                             ; preds = %2415
  br label %2419

2419:                                             ; preds = %2418, %2391
  %2420 = load i32, ptr %66, align 4
  store i32 %2420, ptr %18, align 4
  %2421 = load i32, ptr %67, align 4
  %2422 = load i64, ptr %21, align 8
  %2423 = zext i32 %2421 to i64
  %2424 = lshr i64 %2422, %2423
  store i64 %2424, ptr %21, align 8
  %2425 = load i32, ptr %67, align 4
  %2426 = load i32, ptr %17, align 4
  %2427 = sub i32 %2426, %2425
  store i32 %2427, ptr %17, align 4
  br label %2428

2428:                                             ; preds = %2419
  %2429 = load i32, ptr %18, align 4
  %2430 = zext i32 %2429 to i64
  %2431 = getelementptr inbounds [32 x i32], ptr @tinfl_decompress.s_dist_extra, i64 0, i64 %2430
  %2432 = load i32, ptr %2431, align 4
  store i32 %2432, ptr %20, align 4
  %2433 = load i32, ptr %18, align 4
  %2434 = zext i32 %2433 to i64
  %2435 = getelementptr inbounds [32 x i32], ptr @tinfl_decompress.s_dist_base, i64 0, i64 %2434
  %2436 = load i32, ptr %2435, align 4
  store i32 %2436, ptr %18, align 4
  %2437 = load i32, ptr %20, align 4
  %2438 = icmp ne i32 %2437, 0
  br i1 %2438, label %2439, label %2513

2439:                                             ; preds = %2428
  br label %2440

2440:                                             ; preds = %2439
  %2441 = load i32, ptr %17, align 4
  %2442 = load i32, ptr %20, align 4
  %2443 = icmp ult i32 %2441, %2442
  br i1 %2443, label %2444, label %2494

2444:                                             ; preds = %2440
  br label %2445

2445:                                             ; preds = %2489, %2444
  br label %2446

2446:                                             ; preds = %2445
  %2447 = load ptr, ptr %22, align 8
  %2448 = load ptr, ptr %23, align 8
  %2449 = icmp uge ptr %2447, %2448
  br i1 %2449, label %2450, label %2473

2450:                                             ; preds = %2446
  br label %2451

2451:                                             ; preds = %2471, %2450
  %2452 = load i32, ptr %15, align 4
  %2453 = and i32 %2452, 2
  %2454 = icmp ne i32 %2453, 0
  br i1 %2454, label %2455, label %2470

2455:                                             ; preds = %2451
  br label %2456

2456:                                             ; preds = %2455
  store i32 1, ptr %16, align 4
  %2457 = load ptr, ptr %9, align 8
  %2458 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2457, i32 0, i32 0
  store i32 27, ptr %2458, align 8
  br label %2905

2459:                                             ; preds = %119
  br label %2460

2460:                                             ; preds = %2459
  %2461 = load ptr, ptr %22, align 8
  %2462 = load ptr, ptr %23, align 8
  %2463 = icmp ult ptr %2461, %2462
  br i1 %2463, label %2464, label %2469

2464:                                             ; preds = %2460
  %2465 = load ptr, ptr %22, align 8
  %2466 = getelementptr inbounds i8, ptr %2465, i32 1
  store ptr %2466, ptr %22, align 8
  %2467 = load i8, ptr %2465, align 1
  %2468 = zext i8 %2467 to i32
  store i32 %2468, ptr %70, align 4
  br label %2472

2469:                                             ; preds = %2460
  br label %2471

2470:                                             ; preds = %2451
  store i32 0, ptr %70, align 4
  br label %2472

2471:                                             ; preds = %2469
  br label %2451

2472:                                             ; preds = %2470, %2464
  br label %2478

2473:                                             ; preds = %2446
  %2474 = load ptr, ptr %22, align 8
  %2475 = getelementptr inbounds i8, ptr %2474, i32 1
  store ptr %2475, ptr %22, align 8
  %2476 = load i8, ptr %2474, align 1
  %2477 = zext i8 %2476 to i32
  store i32 %2477, ptr %70, align 4
  br label %2478

2478:                                             ; preds = %2473, %2472
  br label %2479

2479:                                             ; preds = %2478
  %2480 = load i32, ptr %70, align 4
  %2481 = zext i32 %2480 to i64
  %2482 = load i32, ptr %17, align 4
  %2483 = zext i32 %2482 to i64
  %2484 = shl i64 %2481, %2483
  %2485 = load i64, ptr %21, align 8
  %2486 = or i64 %2485, %2484
  store i64 %2486, ptr %21, align 8
  %2487 = load i32, ptr %17, align 4
  %2488 = add i32 %2487, 8
  store i32 %2488, ptr %17, align 4
  br label %2489

2489:                                             ; preds = %2479
  %2490 = load i32, ptr %17, align 4
  %2491 = load i32, ptr %20, align 4
  %2492 = icmp ult i32 %2490, %2491
  br i1 %2492, label %2445, label %2493, !llvm.loop !50

2493:                                             ; preds = %2489
  br label %2494

2494:                                             ; preds = %2493, %2440
  %2495 = load i64, ptr %21, align 8
  %2496 = load i32, ptr %20, align 4
  %2497 = shl i32 1, %2496
  %2498 = sub nsw i32 %2497, 1
  %2499 = sext i32 %2498 to i64
  %2500 = and i64 %2495, %2499
  %2501 = trunc i64 %2500 to i32
  store i32 %2501, ptr %69, align 4
  %2502 = load i32, ptr %20, align 4
  %2503 = load i64, ptr %21, align 8
  %2504 = zext i32 %2502 to i64
  %2505 = lshr i64 %2503, %2504
  store i64 %2505, ptr %21, align 8
  %2506 = load i32, ptr %20, align 4
  %2507 = load i32, ptr %17, align 4
  %2508 = sub i32 %2507, %2506
  store i32 %2508, ptr %17, align 4
  br label %2509

2509:                                             ; preds = %2494
  %2510 = load i32, ptr %69, align 4
  %2511 = load i32, ptr %18, align 4
  %2512 = add i32 %2511, %2510
  store i32 %2512, ptr %18, align 4
  br label %2513

2513:                                             ; preds = %2509, %2428
  %2514 = load ptr, ptr %24, align 8
  %2515 = load ptr, ptr %12, align 8
  %2516 = ptrtoint ptr %2514 to i64
  %2517 = ptrtoint ptr %2515 to i64
  %2518 = sub i64 %2516, %2517
  store i64 %2518, ptr %27, align 8
  %2519 = load i32, ptr %18, align 4
  %2520 = zext i32 %2519 to i64
  %2521 = load i64, ptr %27, align 8
  %2522 = icmp ugt i64 %2520, %2521
  br i1 %2522, label %2523, label %2536

2523:                                             ; preds = %2513
  %2524 = load i32, ptr %15, align 4
  %2525 = and i32 %2524, 4
  %2526 = icmp ne i32 %2525, 0
  br i1 %2526, label %2527, label %2536

2527:                                             ; preds = %2523
  br label %2528

2528:                                             ; preds = %2527
  br label %2529

2529:                                             ; preds = %2534, %2528
  br label %2530

2530:                                             ; preds = %2529
  store i32 -1, ptr %16, align 4
  %2531 = load ptr, ptr %9, align 8
  %2532 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2531, i32 0, i32 0
  store i32 37, ptr %2532, align 8
  br label %2905

2533:                                             ; preds = %119
  br label %2534

2534:                                             ; preds = %2533
  br label %2529

2535:                                             ; No predecessors!
  br label %2536

2536:                                             ; preds = %2535, %2523, %2513
  %2537 = load ptr, ptr %12, align 8
  %2538 = load i64, ptr %27, align 8
  %2539 = load i32, ptr %18, align 4
  %2540 = zext i32 %2539 to i64
  %2541 = sub i64 %2538, %2540
  %2542 = load i64, ptr %26, align 8
  %2543 = and i64 %2541, %2542
  %2544 = getelementptr inbounds i8, ptr %2537, i64 %2543
  store ptr %2544, ptr %58, align 8
  %2545 = load ptr, ptr %24, align 8
  %2546 = load ptr, ptr %58, align 8
  %2547 = icmp ugt ptr %2545, %2546
  br i1 %2547, label %2548, label %2550

2548:                                             ; preds = %2536
  %2549 = load ptr, ptr %24, align 8
  br label %2552

2550:                                             ; preds = %2536
  %2551 = load ptr, ptr %58, align 8
  br label %2552

2552:                                             ; preds = %2550, %2548
  %2553 = phi ptr [ %2549, %2548 ], [ %2551, %2550 ]
  %2554 = load i32, ptr %19, align 4
  %2555 = zext i32 %2554 to i64
  %2556 = getelementptr inbounds i8, ptr %2553, i64 %2555
  %2557 = load ptr, ptr %25, align 8
  %2558 = icmp ugt ptr %2556, %2557
  br i1 %2558, label %2559, label %2589

2559:                                             ; preds = %2552
  br label %2560

2560:                                             ; preds = %2575, %2559
  %2561 = load i32, ptr %19, align 4
  %2562 = add i32 %2561, -1
  store i32 %2562, ptr %19, align 4
  %2563 = icmp ne i32 %2561, 0
  br i1 %2563, label %2564, label %2588

2564:                                             ; preds = %2560
  br label %2565

2565:                                             ; preds = %2574, %2564
  %2566 = load ptr, ptr %24, align 8
  %2567 = load ptr, ptr %25, align 8
  %2568 = icmp uge ptr %2566, %2567
  br i1 %2568, label %2569, label %2575

2569:                                             ; preds = %2565
  br label %2570

2570:                                             ; preds = %2569
  store i32 2, ptr %16, align 4
  %2571 = load ptr, ptr %9, align 8
  %2572 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2571, i32 0, i32 0
  store i32 53, ptr %2572, align 8
  br label %2905

2573:                                             ; preds = %119
  br label %2574

2574:                                             ; preds = %2573
  br label %2565, !llvm.loop !51

2575:                                             ; preds = %2565
  %2576 = load ptr, ptr %12, align 8
  %2577 = load i64, ptr %27, align 8
  %2578 = add i64 %2577, 1
  store i64 %2578, ptr %27, align 8
  %2579 = load i32, ptr %18, align 4
  %2580 = zext i32 %2579 to i64
  %2581 = sub i64 %2577, %2580
  %2582 = load i64, ptr %26, align 8
  %2583 = and i64 %2581, %2582
  %2584 = getelementptr inbounds i8, ptr %2576, i64 %2583
  %2585 = load i8, ptr %2584, align 1
  %2586 = load ptr, ptr %24, align 8
  %2587 = getelementptr inbounds i8, ptr %2586, i32 1
  store ptr %2587, ptr %24, align 8
  store i8 %2585, ptr %2586, align 1
  br label %2560, !llvm.loop !52

2588:                                             ; preds = %2560
  br label %1785

2589:                                             ; preds = %2552
  %2590 = load i32, ptr %19, align 4
  %2591 = icmp uge i32 %2590, 9
  br i1 %2591, label %2592, label %2648

2592:                                             ; preds = %2589
  %2593 = load i32, ptr %19, align 4
  %2594 = load i32, ptr %18, align 4
  %2595 = icmp ule i32 %2593, %2594
  br i1 %2595, label %2596, label %2648

2596:                                             ; preds = %2592
  %2597 = load ptr, ptr %58, align 8
  %2598 = load i32, ptr %19, align 4
  %2599 = and i32 %2598, -8
  %2600 = zext i32 %2599 to i64
  %2601 = getelementptr inbounds i8, ptr %2597, i64 %2600
  store ptr %2601, ptr %71, align 8
  br label %2602

2602:                                             ; preds = %2615, %2596
  %2603 = load ptr, ptr %58, align 8
  %2604 = getelementptr inbounds i32, ptr %2603, i64 0
  %2605 = load i32, ptr %2604, align 4
  %2606 = load ptr, ptr %24, align 8
  %2607 = getelementptr inbounds i32, ptr %2606, i64 0
  store i32 %2605, ptr %2607, align 4
  %2608 = load ptr, ptr %58, align 8
  %2609 = getelementptr inbounds i32, ptr %2608, i64 1
  %2610 = load i32, ptr %2609, align 4
  %2611 = load ptr, ptr %24, align 8
  %2612 = getelementptr inbounds i32, ptr %2611, i64 1
  store i32 %2610, ptr %2612, align 4
  %2613 = load ptr, ptr %24, align 8
  %2614 = getelementptr inbounds i8, ptr %2613, i64 8
  store ptr %2614, ptr %24, align 8
  br label %2615

2615:                                             ; preds = %2602
  %2616 = load ptr, ptr %58, align 8
  %2617 = getelementptr inbounds i8, ptr %2616, i64 8
  store ptr %2617, ptr %58, align 8
  %2618 = load ptr, ptr %71, align 8
  %2619 = icmp ult ptr %2617, %2618
  br i1 %2619, label %2602, label %2620, !llvm.loop !53

2620:                                             ; preds = %2615
  %2621 = load i32, ptr %19, align 4
  %2622 = and i32 %2621, 7
  store i32 %2622, ptr %19, align 4
  %2623 = icmp ult i32 %2622, 3
  br i1 %2623, label %2624, label %2647

2624:                                             ; preds = %2620
  %2625 = load i32, ptr %19, align 4
  %2626 = icmp ne i32 %2625, 0
  br i1 %2626, label %2627, label %2646

2627:                                             ; preds = %2624
  %2628 = load ptr, ptr %58, align 8
  %2629 = getelementptr inbounds i8, ptr %2628, i64 0
  %2630 = load i8, ptr %2629, align 1
  %2631 = load ptr, ptr %24, align 8
  %2632 = getelementptr inbounds i8, ptr %2631, i64 0
  store i8 %2630, ptr %2632, align 1
  %2633 = load i32, ptr %19, align 4
  %2634 = icmp ugt i32 %2633, 1
  br i1 %2634, label %2635, label %2641

2635:                                             ; preds = %2627
  %2636 = load ptr, ptr %58, align 8
  %2637 = getelementptr inbounds i8, ptr %2636, i64 1
  %2638 = load i8, ptr %2637, align 1
  %2639 = load ptr, ptr %24, align 8
  %2640 = getelementptr inbounds i8, ptr %2639, i64 1
  store i8 %2638, ptr %2640, align 1
  br label %2641

2641:                                             ; preds = %2635, %2627
  %2642 = load i32, ptr %19, align 4
  %2643 = load ptr, ptr %24, align 8
  %2644 = zext i32 %2642 to i64
  %2645 = getelementptr inbounds i8, ptr %2643, i64 %2644
  store ptr %2645, ptr %24, align 8
  br label %2646

2646:                                             ; preds = %2641, %2624
  br label %1785

2647:                                             ; preds = %2620
  br label %2648

2648:                                             ; preds = %2647, %2592, %2589
  br label %2649

2649:                                             ; preds = %2648
  br label %2650

2650:                                             ; preds = %2670, %2649
  %2651 = load ptr, ptr %58, align 8
  %2652 = getelementptr inbounds i8, ptr %2651, i64 0
  %2653 = load i8, ptr %2652, align 1
  %2654 = load ptr, ptr %24, align 8
  %2655 = getelementptr inbounds i8, ptr %2654, i64 0
  store i8 %2653, ptr %2655, align 1
  %2656 = load ptr, ptr %58, align 8
  %2657 = getelementptr inbounds i8, ptr %2656, i64 1
  %2658 = load i8, ptr %2657, align 1
  %2659 = load ptr, ptr %24, align 8
  %2660 = getelementptr inbounds i8, ptr %2659, i64 1
  store i8 %2658, ptr %2660, align 1
  %2661 = load ptr, ptr %58, align 8
  %2662 = getelementptr inbounds i8, ptr %2661, i64 2
  %2663 = load i8, ptr %2662, align 1
  %2664 = load ptr, ptr %24, align 8
  %2665 = getelementptr inbounds i8, ptr %2664, i64 2
  store i8 %2663, ptr %2665, align 1
  %2666 = load ptr, ptr %24, align 8
  %2667 = getelementptr inbounds i8, ptr %2666, i64 3
  store ptr %2667, ptr %24, align 8
  %2668 = load ptr, ptr %58, align 8
  %2669 = getelementptr inbounds i8, ptr %2668, i64 3
  store ptr %2669, ptr %58, align 8
  br label %2670

2670:                                             ; preds = %2650
  %2671 = load i32, ptr %19, align 4
  %2672 = sub i32 %2671, 3
  store i32 %2672, ptr %19, align 4
  %2673 = icmp sgt i32 %2672, 2
  br i1 %2673, label %2650, label %2674, !llvm.loop !54

2674:                                             ; preds = %2670
  %2675 = load i32, ptr %19, align 4
  %2676 = icmp sgt i32 %2675, 0
  br i1 %2676, label %2677, label %2696

2677:                                             ; preds = %2674
  %2678 = load ptr, ptr %58, align 8
  %2679 = getelementptr inbounds i8, ptr %2678, i64 0
  %2680 = load i8, ptr %2679, align 1
  %2681 = load ptr, ptr %24, align 8
  %2682 = getelementptr inbounds i8, ptr %2681, i64 0
  store i8 %2680, ptr %2682, align 1
  %2683 = load i32, ptr %19, align 4
  %2684 = icmp sgt i32 %2683, 1
  br i1 %2684, label %2685, label %2691

2685:                                             ; preds = %2677
  %2686 = load ptr, ptr %58, align 8
  %2687 = getelementptr inbounds i8, ptr %2686, i64 1
  %2688 = load i8, ptr %2687, align 1
  %2689 = load ptr, ptr %24, align 8
  %2690 = getelementptr inbounds i8, ptr %2689, i64 1
  store i8 %2688, ptr %2690, align 1
  br label %2691

2691:                                             ; preds = %2685, %2677
  %2692 = load i32, ptr %19, align 4
  %2693 = load ptr, ptr %24, align 8
  %2694 = zext i32 %2692 to i64
  %2695 = getelementptr inbounds i8, ptr %2693, i64 %2694
  store ptr %2695, ptr %24, align 8
  br label %2696

2696:                                             ; preds = %2691, %2674
  br label %1785

2697:                                             ; preds = %2147
  br label %2698

2698:                                             ; preds = %2697, %821
  br label %2699

2699:                                             ; preds = %2698, %807
  br label %2700

2700:                                             ; preds = %2699
  %2701 = load ptr, ptr %9, align 8
  %2702 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2701, i32 0, i32 6
  %2703 = load i32, ptr %2702, align 8
  %2704 = and i32 %2703, 1
  %2705 = icmp ne i32 %2704, 0
  %2706 = xor i1 %2705, true
  br i1 %2706, label %300, label %2707, !llvm.loop !55

2707:                                             ; preds = %2700
  %2708 = load i32, ptr %15, align 4
  %2709 = and i32 %2708, 1
  %2710 = icmp ne i32 %2709, 0
  br i1 %2710, label %2711, label %2895

2711:                                             ; preds = %2707
  br label %2712

2712:                                             ; preds = %2711
  %2713 = load i32, ptr %17, align 4
  %2714 = load i32, ptr %17, align 4
  %2715 = and i32 %2714, 7
  %2716 = icmp ult i32 %2713, %2715
  br i1 %2716, label %2717, label %2768

2717:                                             ; preds = %2712
  br label %2718

2718:                                             ; preds = %2762, %2717
  br label %2719

2719:                                             ; preds = %2718
  %2720 = load ptr, ptr %22, align 8
  %2721 = load ptr, ptr %23, align 8
  %2722 = icmp uge ptr %2720, %2721
  br i1 %2722, label %2723, label %2746

2723:                                             ; preds = %2719
  br label %2724

2724:                                             ; preds = %2744, %2723
  %2725 = load i32, ptr %15, align 4
  %2726 = and i32 %2725, 2
  %2727 = icmp ne i32 %2726, 0
  br i1 %2727, label %2728, label %2743

2728:                                             ; preds = %2724
  br label %2729

2729:                                             ; preds = %2728
  store i32 1, ptr %16, align 4
  %2730 = load ptr, ptr %9, align 8
  %2731 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2730, i32 0, i32 0
  store i32 32, ptr %2731, align 8
  br label %2905

2732:                                             ; preds = %119
  br label %2733

2733:                                             ; preds = %2732
  %2734 = load ptr, ptr %22, align 8
  %2735 = load ptr, ptr %23, align 8
  %2736 = icmp ult ptr %2734, %2735
  br i1 %2736, label %2737, label %2742

2737:                                             ; preds = %2733
  %2738 = load ptr, ptr %22, align 8
  %2739 = getelementptr inbounds i8, ptr %2738, i32 1
  store ptr %2739, ptr %22, align 8
  %2740 = load i8, ptr %2738, align 1
  %2741 = zext i8 %2740 to i32
  store i32 %2741, ptr %72, align 4
  br label %2745

2742:                                             ; preds = %2733
  br label %2744

2743:                                             ; preds = %2724
  store i32 0, ptr %72, align 4
  br label %2745

2744:                                             ; preds = %2742
  br label %2724

2745:                                             ; preds = %2743, %2737
  br label %2751

2746:                                             ; preds = %2719
  %2747 = load ptr, ptr %22, align 8
  %2748 = getelementptr inbounds i8, ptr %2747, i32 1
  store ptr %2748, ptr %22, align 8
  %2749 = load i8, ptr %2747, align 1
  %2750 = zext i8 %2749 to i32
  store i32 %2750, ptr %72, align 4
  br label %2751

2751:                                             ; preds = %2746, %2745
  br label %2752

2752:                                             ; preds = %2751
  %2753 = load i32, ptr %72, align 4
  %2754 = zext i32 %2753 to i64
  %2755 = load i32, ptr %17, align 4
  %2756 = zext i32 %2755 to i64
  %2757 = shl i64 %2754, %2756
  %2758 = load i64, ptr %21, align 8
  %2759 = or i64 %2758, %2757
  store i64 %2759, ptr %21, align 8
  %2760 = load i32, ptr %17, align 4
  %2761 = add i32 %2760, 8
  store i32 %2761, ptr %17, align 4
  br label %2762

2762:                                             ; preds = %2752
  %2763 = load i32, ptr %17, align 4
  %2764 = load i32, ptr %17, align 4
  %2765 = and i32 %2764, 7
  %2766 = icmp ult i32 %2763, %2765
  br i1 %2766, label %2718, label %2767, !llvm.loop !56

2767:                                             ; preds = %2762
  br label %2768

2768:                                             ; preds = %2767, %2712
  %2769 = load i32, ptr %17, align 4
  %2770 = and i32 %2769, 7
  %2771 = load i64, ptr %21, align 8
  %2772 = zext i32 %2770 to i64
  %2773 = lshr i64 %2771, %2772
  store i64 %2773, ptr %21, align 8
  %2774 = load i32, ptr %17, align 4
  %2775 = and i32 %2774, 7
  %2776 = load i32, ptr %17, align 4
  %2777 = sub i32 %2776, %2775
  store i32 %2777, ptr %17, align 4
  br label %2778

2778:                                             ; preds = %2768
  store i32 0, ptr %19, align 4
  br label %2779

2779:                                             ; preds = %2891, %2778
  %2780 = load i32, ptr %19, align 4
  %2781 = icmp ult i32 %2780, 4
  br i1 %2781, label %2782, label %2894

2782:                                             ; preds = %2779
  %2783 = load i32, ptr %17, align 4
  %2784 = icmp ne i32 %2783, 0
  br i1 %2784, label %2785, label %2847

2785:                                             ; preds = %2782
  br label %2786

2786:                                             ; preds = %2785
  %2787 = load i32, ptr %17, align 4
  %2788 = icmp ult i32 %2787, 8
  br i1 %2788, label %2789, label %2838

2789:                                             ; preds = %2786
  br label %2790

2790:                                             ; preds = %2834, %2789
  br label %2791

2791:                                             ; preds = %2790
  %2792 = load ptr, ptr %22, align 8
  %2793 = load ptr, ptr %23, align 8
  %2794 = icmp uge ptr %2792, %2793
  br i1 %2794, label %2795, label %2818

2795:                                             ; preds = %2791
  br label %2796

2796:                                             ; preds = %2816, %2795
  %2797 = load i32, ptr %15, align 4
  %2798 = and i32 %2797, 2
  %2799 = icmp ne i32 %2798, 0
  br i1 %2799, label %2800, label %2815

2800:                                             ; preds = %2796
  br label %2801

2801:                                             ; preds = %2800
  store i32 1, ptr %16, align 4
  %2802 = load ptr, ptr %9, align 8
  %2803 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2802, i32 0, i32 0
  store i32 41, ptr %2803, align 8
  br label %2905

2804:                                             ; preds = %119
  br label %2805

2805:                                             ; preds = %2804
  %2806 = load ptr, ptr %22, align 8
  %2807 = load ptr, ptr %23, align 8
  %2808 = icmp ult ptr %2806, %2807
  br i1 %2808, label %2809, label %2814

2809:                                             ; preds = %2805
  %2810 = load ptr, ptr %22, align 8
  %2811 = getelementptr inbounds i8, ptr %2810, i32 1
  store ptr %2811, ptr %22, align 8
  %2812 = load i8, ptr %2810, align 1
  %2813 = zext i8 %2812 to i32
  store i32 %2813, ptr %74, align 4
  br label %2817

2814:                                             ; preds = %2805
  br label %2816

2815:                                             ; preds = %2796
  store i32 0, ptr %74, align 4
  br label %2817

2816:                                             ; preds = %2814
  br label %2796

2817:                                             ; preds = %2815, %2809
  br label %2823

2818:                                             ; preds = %2791
  %2819 = load ptr, ptr %22, align 8
  %2820 = getelementptr inbounds i8, ptr %2819, i32 1
  store ptr %2820, ptr %22, align 8
  %2821 = load i8, ptr %2819, align 1
  %2822 = zext i8 %2821 to i32
  store i32 %2822, ptr %74, align 4
  br label %2823

2823:                                             ; preds = %2818, %2817
  br label %2824

2824:                                             ; preds = %2823
  %2825 = load i32, ptr %74, align 4
  %2826 = zext i32 %2825 to i64
  %2827 = load i32, ptr %17, align 4
  %2828 = zext i32 %2827 to i64
  %2829 = shl i64 %2826, %2828
  %2830 = load i64, ptr %21, align 8
  %2831 = or i64 %2830, %2829
  store i64 %2831, ptr %21, align 8
  %2832 = load i32, ptr %17, align 4
  %2833 = add i32 %2832, 8
  store i32 %2833, ptr %17, align 4
  br label %2834

2834:                                             ; preds = %2824
  %2835 = load i32, ptr %17, align 4
  %2836 = icmp ult i32 %2835, 8
  br i1 %2836, label %2790, label %2837, !llvm.loop !57

2837:                                             ; preds = %2834
  br label %2838

2838:                                             ; preds = %2837, %2786
  %2839 = load i64, ptr %21, align 8
  %2840 = and i64 %2839, 255
  %2841 = trunc i64 %2840 to i32
  store i32 %2841, ptr %73, align 4
  %2842 = load i64, ptr %21, align 8
  %2843 = lshr i64 %2842, 8
  store i64 %2843, ptr %21, align 8
  %2844 = load i32, ptr %17, align 4
  %2845 = sub i32 %2844, 8
  store i32 %2845, ptr %17, align 4
  br label %2846

2846:                                             ; preds = %2838
  br label %2882

2847:                                             ; preds = %2782
  br label %2848

2848:                                             ; preds = %2847
  %2849 = load ptr, ptr %22, align 8
  %2850 = load ptr, ptr %23, align 8
  %2851 = icmp uge ptr %2849, %2850
  br i1 %2851, label %2852, label %2875

2852:                                             ; preds = %2848
  br label %2853

2853:                                             ; preds = %2873, %2852
  %2854 = load i32, ptr %15, align 4
  %2855 = and i32 %2854, 2
  %2856 = icmp ne i32 %2855, 0
  br i1 %2856, label %2857, label %2872

2857:                                             ; preds = %2853
  br label %2858

2858:                                             ; preds = %2857
  store i32 1, ptr %16, align 4
  %2859 = load ptr, ptr %9, align 8
  %2860 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2859, i32 0, i32 0
  store i32 42, ptr %2860, align 8
  br label %2905

2861:                                             ; preds = %119
  br label %2862

2862:                                             ; preds = %2861
  %2863 = load ptr, ptr %22, align 8
  %2864 = load ptr, ptr %23, align 8
  %2865 = icmp ult ptr %2863, %2864
  br i1 %2865, label %2866, label %2871

2866:                                             ; preds = %2862
  %2867 = load ptr, ptr %22, align 8
  %2868 = getelementptr inbounds i8, ptr %2867, i32 1
  store ptr %2868, ptr %22, align 8
  %2869 = load i8, ptr %2867, align 1
  %2870 = zext i8 %2869 to i32
  store i32 %2870, ptr %73, align 4
  br label %2874

2871:                                             ; preds = %2862
  br label %2873

2872:                                             ; preds = %2853
  store i32 0, ptr %73, align 4
  br label %2874

2873:                                             ; preds = %2871
  br label %2853

2874:                                             ; preds = %2872, %2866
  br label %2880

2875:                                             ; preds = %2848
  %2876 = load ptr, ptr %22, align 8
  %2877 = getelementptr inbounds i8, ptr %2876, i32 1
  store ptr %2877, ptr %22, align 8
  %2878 = load i8, ptr %2876, align 1
  %2879 = zext i8 %2878 to i32
  store i32 %2879, ptr %73, align 4
  br label %2880

2880:                                             ; preds = %2875, %2874
  br label %2881

2881:                                             ; preds = %2880
  br label %2882

2882:                                             ; preds = %2881, %2846
  %2883 = load ptr, ptr %9, align 8
  %2884 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2883, i32 0, i32 4
  %2885 = load i32, ptr %2884, align 8
  %2886 = shl i32 %2885, 8
  %2887 = load i32, ptr %73, align 4
  %2888 = or i32 %2886, %2887
  %2889 = load ptr, ptr %9, align 8
  %2890 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2889, i32 0, i32 4
  store i32 %2888, ptr %2890, align 8
  br label %2891

2891:                                             ; preds = %2882
  %2892 = load i32, ptr %19, align 4
  %2893 = add i32 %2892, 1
  store i32 %2893, ptr %19, align 4
  br label %2779, !llvm.loop !58

2894:                                             ; preds = %2779
  br label %2895

2895:                                             ; preds = %2894, %2707
  br label %2896

2896:                                             ; preds = %2895
  br label %2897

2897:                                             ; preds = %2902, %2896
  br label %2898

2898:                                             ; preds = %2897
  store i32 0, ptr %16, align 4
  %2899 = load ptr, ptr %9, align 8
  %2900 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2899, i32 0, i32 0
  store i32 34, ptr %2900, align 8
  br label %2905

2901:                                             ; preds = %119
  br label %2902

2902:                                             ; preds = %2901
  br label %2897

2903:                                             ; No predecessors!
  br label %2904

2904:                                             ; preds = %2903, %119
  br label %2905

2905:                                             ; preds = %2904, %2898, %2858, %2801, %2729, %2570, %2530, %2456, %2319, %2178, %2003, %1884, %1725, %1615, %1586, %1456, %1191, %1039, %916, %816, %724, %716, %701, %679, %628, %597, %526, %464, %392, %316, %292, %204, %164
  %2906 = load i32, ptr %17, align 4
  %2907 = load ptr, ptr %9, align 8
  %2908 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2907, i32 0, i32 1
  store i32 %2906, ptr %2908, align 4
  %2909 = load i64, ptr %21, align 8
  %2910 = load ptr, ptr %9, align 8
  %2911 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2910, i32 0, i32 14
  store i64 %2909, ptr %2911, align 8
  %2912 = load i32, ptr %18, align 4
  %2913 = load ptr, ptr %9, align 8
  %2914 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2913, i32 0, i32 10
  store i32 %2912, ptr %2914, align 8
  %2915 = load i32, ptr %19, align 4
  %2916 = load ptr, ptr %9, align 8
  %2917 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2916, i32 0, i32 11
  store i32 %2915, ptr %2917, align 4
  %2918 = load i32, ptr %20, align 4
  %2919 = load ptr, ptr %9, align 8
  %2920 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2919, i32 0, i32 12
  store i32 %2918, ptr %2920, align 8
  %2921 = load i64, ptr %27, align 8
  %2922 = load ptr, ptr %9, align 8
  %2923 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2922, i32 0, i32 15
  store i64 %2921, ptr %2923, align 8
  %2924 = load ptr, ptr %22, align 8
  %2925 = load ptr, ptr %10, align 8
  %2926 = ptrtoint ptr %2924 to i64
  %2927 = ptrtoint ptr %2925 to i64
  %2928 = sub i64 %2926, %2927
  %2929 = load ptr, ptr %11, align 8
  store i64 %2928, ptr %2929, align 8
  %2930 = load ptr, ptr %24, align 8
  %2931 = load ptr, ptr %13, align 8
  %2932 = ptrtoint ptr %2930 to i64
  %2933 = ptrtoint ptr %2931 to i64
  %2934 = sub i64 %2932, %2933
  %2935 = load ptr, ptr %14, align 8
  store i64 %2934, ptr %2935, align 8
  %2936 = load i32, ptr %15, align 4
  %2937 = and i32 %2936, 9
  %2938 = icmp ne i32 %2937, 0
  br i1 %2938, label %2939, label %3094

2939:                                             ; preds = %2905
  %2940 = load i32, ptr %16, align 4
  %2941 = icmp sge i32 %2940, 0
  br i1 %2941, label %2942, label %3094

2942:                                             ; preds = %2939
  %2943 = load ptr, ptr %13, align 8
  store ptr %2943, ptr %75, align 8
  %2944 = load ptr, ptr %14, align 8
  %2945 = load i64, ptr %2944, align 8
  store i64 %2945, ptr %76, align 8
  %2946 = load ptr, ptr %9, align 8
  %2947 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2946, i32 0, i32 8
  %2948 = load i32, ptr %2947, align 8
  %2949 = and i32 %2948, 65535
  store i32 %2949, ptr %78, align 4
  %2950 = load ptr, ptr %9, align 8
  %2951 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %2950, i32 0, i32 8
  %2952 = load i32, ptr %2951, align 8
  %2953 = lshr i32 %2952, 16
  store i32 %2953, ptr %79, align 4
  %2954 = load i64, ptr %76, align 8
  %2955 = urem i64 %2954, 5552
  store i64 %2955, ptr %80, align 8
  br label %2956

2956:                                             ; preds = %3063, %2942
  %2957 = load i64, ptr %76, align 8
  %2958 = icmp ne i64 %2957, 0
  br i1 %2958, label %2959, label %3071

2959:                                             ; preds = %2956
  store i32 0, ptr %77, align 4
  br label %2960

2960:                                             ; preds = %3039, %2959
  %2961 = load i32, ptr %77, align 4
  %2962 = add i32 %2961, 7
  %2963 = zext i32 %2962 to i64
  %2964 = load i64, ptr %80, align 8
  %2965 = icmp ult i64 %2963, %2964
  br i1 %2965, label %2966, label %3044

2966:                                             ; preds = %2960
  %2967 = load ptr, ptr %75, align 8
  %2968 = getelementptr inbounds i8, ptr %2967, i64 0
  %2969 = load i8, ptr %2968, align 1
  %2970 = zext i8 %2969 to i32
  %2971 = load i32, ptr %78, align 4
  %2972 = add i32 %2971, %2970
  store i32 %2972, ptr %78, align 4
  %2973 = load i32, ptr %78, align 4
  %2974 = load i32, ptr %79, align 4
  %2975 = add i32 %2974, %2973
  store i32 %2975, ptr %79, align 4
  %2976 = load ptr, ptr %75, align 8
  %2977 = getelementptr inbounds i8, ptr %2976, i64 1
  %2978 = load i8, ptr %2977, align 1
  %2979 = zext i8 %2978 to i32
  %2980 = load i32, ptr %78, align 4
  %2981 = add i32 %2980, %2979
  store i32 %2981, ptr %78, align 4
  %2982 = load i32, ptr %78, align 4
  %2983 = load i32, ptr %79, align 4
  %2984 = add i32 %2983, %2982
  store i32 %2984, ptr %79, align 4
  %2985 = load ptr, ptr %75, align 8
  %2986 = getelementptr inbounds i8, ptr %2985, i64 2
  %2987 = load i8, ptr %2986, align 1
  %2988 = zext i8 %2987 to i32
  %2989 = load i32, ptr %78, align 4
  %2990 = add i32 %2989, %2988
  store i32 %2990, ptr %78, align 4
  %2991 = load i32, ptr %78, align 4
  %2992 = load i32, ptr %79, align 4
  %2993 = add i32 %2992, %2991
  store i32 %2993, ptr %79, align 4
  %2994 = load ptr, ptr %75, align 8
  %2995 = getelementptr inbounds i8, ptr %2994, i64 3
  %2996 = load i8, ptr %2995, align 1
  %2997 = zext i8 %2996 to i32
  %2998 = load i32, ptr %78, align 4
  %2999 = add i32 %2998, %2997
  store i32 %2999, ptr %78, align 4
  %3000 = load i32, ptr %78, align 4
  %3001 = load i32, ptr %79, align 4
  %3002 = add i32 %3001, %3000
  store i32 %3002, ptr %79, align 4
  %3003 = load ptr, ptr %75, align 8
  %3004 = getelementptr inbounds i8, ptr %3003, i64 4
  %3005 = load i8, ptr %3004, align 1
  %3006 = zext i8 %3005 to i32
  %3007 = load i32, ptr %78, align 4
  %3008 = add i32 %3007, %3006
  store i32 %3008, ptr %78, align 4
  %3009 = load i32, ptr %78, align 4
  %3010 = load i32, ptr %79, align 4
  %3011 = add i32 %3010, %3009
  store i32 %3011, ptr %79, align 4
  %3012 = load ptr, ptr %75, align 8
  %3013 = getelementptr inbounds i8, ptr %3012, i64 5
  %3014 = load i8, ptr %3013, align 1
  %3015 = zext i8 %3014 to i32
  %3016 = load i32, ptr %78, align 4
  %3017 = add i32 %3016, %3015
  store i32 %3017, ptr %78, align 4
  %3018 = load i32, ptr %78, align 4
  %3019 = load i32, ptr %79, align 4
  %3020 = add i32 %3019, %3018
  store i32 %3020, ptr %79, align 4
  %3021 = load ptr, ptr %75, align 8
  %3022 = getelementptr inbounds i8, ptr %3021, i64 6
  %3023 = load i8, ptr %3022, align 1
  %3024 = zext i8 %3023 to i32
  %3025 = load i32, ptr %78, align 4
  %3026 = add i32 %3025, %3024
  store i32 %3026, ptr %78, align 4
  %3027 = load i32, ptr %78, align 4
  %3028 = load i32, ptr %79, align 4
  %3029 = add i32 %3028, %3027
  store i32 %3029, ptr %79, align 4
  %3030 = load ptr, ptr %75, align 8
  %3031 = getelementptr inbounds i8, ptr %3030, i64 7
  %3032 = load i8, ptr %3031, align 1
  %3033 = zext i8 %3032 to i32
  %3034 = load i32, ptr %78, align 4
  %3035 = add i32 %3034, %3033
  store i32 %3035, ptr %78, align 4
  %3036 = load i32, ptr %78, align 4
  %3037 = load i32, ptr %79, align 4
  %3038 = add i32 %3037, %3036
  store i32 %3038, ptr %79, align 4
  br label %3039

3039:                                             ; preds = %2966
  %3040 = load i32, ptr %77, align 4
  %3041 = add i32 %3040, 8
  store i32 %3041, ptr %77, align 4
  %3042 = load ptr, ptr %75, align 8
  %3043 = getelementptr inbounds i8, ptr %3042, i64 8
  store ptr %3043, ptr %75, align 8
  br label %2960, !llvm.loop !59

3044:                                             ; preds = %2960
  br label %3045

3045:                                             ; preds = %3060, %3044
  %3046 = load i32, ptr %77, align 4
  %3047 = zext i32 %3046 to i64
  %3048 = load i64, ptr %80, align 8
  %3049 = icmp ult i64 %3047, %3048
  br i1 %3049, label %3050, label %3063

3050:                                             ; preds = %3045
  %3051 = load ptr, ptr %75, align 8
  %3052 = getelementptr inbounds i8, ptr %3051, i32 1
  store ptr %3052, ptr %75, align 8
  %3053 = load i8, ptr %3051, align 1
  %3054 = zext i8 %3053 to i32
  %3055 = load i32, ptr %78, align 4
  %3056 = add i32 %3055, %3054
  store i32 %3056, ptr %78, align 4
  %3057 = load i32, ptr %78, align 4
  %3058 = load i32, ptr %79, align 4
  %3059 = add i32 %3058, %3057
  store i32 %3059, ptr %79, align 4
  br label %3060

3060:                                             ; preds = %3050
  %3061 = load i32, ptr %77, align 4
  %3062 = add i32 %3061, 1
  store i32 %3062, ptr %77, align 4
  br label %3045, !llvm.loop !60

3063:                                             ; preds = %3045
  %3064 = load i32, ptr %78, align 4
  %3065 = urem i32 %3064, 65521
  store i32 %3065, ptr %78, align 4
  %3066 = load i32, ptr %79, align 4
  %3067 = urem i32 %3066, 65521
  store i32 %3067, ptr %79, align 4
  %3068 = load i64, ptr %80, align 8
  %3069 = load i64, ptr %76, align 8
  %3070 = sub i64 %3069, %3068
  store i64 %3070, ptr %76, align 8
  store i64 5552, ptr %80, align 8
  br label %2956, !llvm.loop !61

3071:                                             ; preds = %2956
  %3072 = load i32, ptr %79, align 4
  %3073 = shl i32 %3072, 16
  %3074 = load i32, ptr %78, align 4
  %3075 = add i32 %3073, %3074
  %3076 = load ptr, ptr %9, align 8
  %3077 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %3076, i32 0, i32 8
  store i32 %3075, ptr %3077, align 8
  %3078 = load i32, ptr %16, align 4
  %3079 = icmp eq i32 %3078, 0
  br i1 %3079, label %3080, label %3093

3080:                                             ; preds = %3071
  %3081 = load i32, ptr %15, align 4
  %3082 = and i32 %3081, 1
  %3083 = icmp ne i32 %3082, 0
  br i1 %3083, label %3084, label %3093

3084:                                             ; preds = %3080
  %3085 = load ptr, ptr %9, align 8
  %3086 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %3085, i32 0, i32 8
  %3087 = load i32, ptr %3086, align 8
  %3088 = load ptr, ptr %9, align 8
  %3089 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %3088, i32 0, i32 4
  %3090 = load i32, ptr %3089, align 8
  %3091 = icmp ne i32 %3087, %3090
  br i1 %3091, label %3092, label %3093

3092:                                             ; preds = %3084
  store i32 -2, ptr %16, align 4
  br label %3093

3093:                                             ; preds = %3092, %3084, %3080, %3071
  br label %3094

3094:                                             ; preds = %3093, %2939, %2905
  %3095 = load i32, ptr %16, align 4
  store i32 %3095, ptr %8, align 4
  br label %3096

3096:                                             ; preds = %3094, %116
  %3097 = load i32, ptr %8, align 4
  ret i32 %3097
}

; Function Attrs: nounwind
declare ptr @__memcpy_chk(ptr noundef, ptr noundef, i64 noundef, i64 noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.objectsize.i64.p0(ptr, i1 immarg, i1 immarg, i1 immarg) #3

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_inflateEnd(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  %4 = load ptr, ptr %3, align 8
  %5 = icmp ne ptr %4, null
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  store i32 -2, ptr %2, align 4
  br label %25

7:                                                ; preds = %1
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 7
  %10 = load ptr, ptr %9, align 8
  %11 = icmp ne ptr %10, null
  br i1 %11, label %12, label %24

12:                                               ; preds = %7
  %13 = load ptr, ptr %3, align 8
  %14 = getelementptr inbounds %struct.mz_stream_s, ptr %13, i32 0, i32 9
  %15 = load ptr, ptr %14, align 8
  %16 = load ptr, ptr %3, align 8
  %17 = getelementptr inbounds %struct.mz_stream_s, ptr %16, i32 0, i32 10
  %18 = load ptr, ptr %17, align 8
  %19 = load ptr, ptr %3, align 8
  %20 = getelementptr inbounds %struct.mz_stream_s, ptr %19, i32 0, i32 7
  %21 = load ptr, ptr %20, align 8
  call void %15(ptr noundef %18, ptr noundef %21)
  %22 = load ptr, ptr %3, align 8
  %23 = getelementptr inbounds %struct.mz_stream_s, ptr %22, i32 0, i32 7
  store ptr null, ptr %23, align 8
  br label %24

24:                                               ; preds = %12, %7
  store i32 0, ptr %2, align 4
  br label %25

25:                                               ; preds = %24, %6
  %26 = load i32, ptr %2, align 4
  ret i32 %26
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mz_uncompress(ptr noundef %0, ptr noundef %1, ptr noundef %2, i64 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca %struct.mz_stream_s, align 8
  %11 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i64 %3, ptr %9, align 8
  call void @llvm.memset.p0.i64(ptr align 8 %10, i8 0, i64 120, i1 false)
  %12 = load i64, ptr %9, align 8
  %13 = load ptr, ptr %7, align 8
  %14 = load i64, ptr %13, align 8
  %15 = or i64 %12, %14
  %16 = icmp ugt i64 %15, 4294967295
  br i1 %16, label %17, label %18

17:                                               ; preds = %4
  store i32 -10000, ptr %5, align 4
  br label %57

18:                                               ; preds = %4
  %19 = load ptr, ptr %8, align 8
  %20 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 0
  store ptr %19, ptr %20, align 8
  %21 = load i64, ptr %9, align 8
  %22 = trunc i64 %21 to i32
  %23 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 1
  store i32 %22, ptr %23, align 8
  %24 = load ptr, ptr %6, align 8
  %25 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 3
  store ptr %24, ptr %25, align 8
  %26 = load ptr, ptr %7, align 8
  %27 = load i64, ptr %26, align 8
  %28 = trunc i64 %27 to i32
  %29 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 4
  store i32 %28, ptr %29, align 8
  %30 = call i32 @mz_inflateInit(ptr noundef %10)
  store i32 %30, ptr %11, align 4
  %31 = load i32, ptr %11, align 4
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %35

33:                                               ; preds = %18
  %34 = load i32, ptr %11, align 4
  store i32 %34, ptr %5, align 4
  br label %57

35:                                               ; preds = %18
  %36 = call i32 @mz_inflate(ptr noundef %10, i32 noundef 4)
  store i32 %36, ptr %11, align 4
  %37 = load i32, ptr %11, align 4
  %38 = icmp ne i32 %37, 1
  br i1 %38, label %39, label %52

39:                                               ; preds = %35
  %40 = call i32 @mz_inflateEnd(ptr noundef %10)
  %41 = load i32, ptr %11, align 4
  %42 = icmp eq i32 %41, -5
  br i1 %42, label %43, label %48

43:                                               ; preds = %39
  %44 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 1
  %45 = load i32, ptr %44, align 8
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %48, label %47

47:                                               ; preds = %43
  br label %50

48:                                               ; preds = %43, %39
  %49 = load i32, ptr %11, align 4
  br label %50

50:                                               ; preds = %48, %47
  %51 = phi i32 [ -3, %47 ], [ %49, %48 ]
  store i32 %51, ptr %5, align 4
  br label %57

52:                                               ; preds = %35
  %53 = getelementptr inbounds %struct.mz_stream_s, ptr %10, i32 0, i32 5
  %54 = load i64, ptr %53, align 8
  %55 = load ptr, ptr %7, align 8
  store i64 %54, ptr %55, align 8
  %56 = call i32 @mz_inflateEnd(ptr noundef %10)
  store i32 %56, ptr %5, align 4
  br label %57

57:                                               ; preds = %52, %50, %33, %17
  %58 = load i32, ptr %5, align 4
  ret i32 %58
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define ptr @mz_error(i32 noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %24, %1
  %6 = load i32, ptr %4, align 4
  %7 = zext i32 %6 to i64
  %8 = icmp ult i64 %7, 10
  br i1 %8, label %9, label %27

9:                                                ; preds = %5
  %10 = load i32, ptr %4, align 4
  %11 = zext i32 %10 to i64
  %12 = getelementptr inbounds [10 x %struct.anon], ptr @mz_error.s_error_descs, i64 0, i64 %11
  %13 = getelementptr inbounds %struct.anon, ptr %12, i32 0, i32 0
  %14 = load i32, ptr %13, align 16
  %15 = load i32, ptr %3, align 4
  %16 = icmp eq i32 %14, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %9
  %18 = load i32, ptr %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds [10 x %struct.anon], ptr @mz_error.s_error_descs, i64 0, i64 %19
  %21 = getelementptr inbounds %struct.anon, ptr %20, i32 0, i32 1
  %22 = load ptr, ptr %21, align 8
  store ptr %22, ptr %2, align 8
  br label %28

23:                                               ; preds = %9
  br label %24

24:                                               ; preds = %23
  %25 = load i32, ptr %4, align 4
  %26 = add i32 %25, 1
  store i32 %26, ptr %4, align 4
  br label %5, !llvm.loop !62

27:                                               ; preds = %5
  store ptr null, ptr %2, align 8
  br label %28

28:                                               ; preds = %27, %17
  %29 = load ptr, ptr %2, align 8
  ret ptr %29
}

; Function Attrs: nounwind
declare ptr @__memset_chk(ptr noundef, i32 noundef, i64 noundef, i64 noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define ptr @tinfl_decompress_mem_to_heap(ptr noundef %0, i64 noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tinfl_decompressor_tag, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i64, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  store ptr null, ptr %11, align 8
  store i64 0, ptr %13, align 8
  store i64 0, ptr %14, align 8
  %19 = load ptr, ptr %8, align 8
  store i64 0, ptr %19, align 8
  br label %20

20:                                               ; preds = %4
  %21 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %10, i32 0, i32 0
  store i32 0, ptr %21, align 8
  br label %22

22:                                               ; preds = %20
  br label %23

23:                                               ; preds = %83, %22
  %24 = load i64, ptr %7, align 8
  %25 = load i64, ptr %13, align 8
  %26 = sub i64 %24, %25
  store i64 %26, ptr %15, align 8
  %27 = load i64, ptr %14, align 8
  %28 = load ptr, ptr %8, align 8
  %29 = load i64, ptr %28, align 8
  %30 = sub i64 %27, %29
  store i64 %30, ptr %16, align 8
  %31 = load ptr, ptr %6, align 8
  %32 = load i64, ptr %13, align 8
  %33 = getelementptr inbounds i8, ptr %31, i64 %32
  %34 = load ptr, ptr %11, align 8
  %35 = load ptr, ptr %11, align 8
  %36 = icmp ne ptr %35, null
  br i1 %36, label %37, label %42

37:                                               ; preds = %23
  %38 = load ptr, ptr %11, align 8
  %39 = load ptr, ptr %8, align 8
  %40 = load i64, ptr %39, align 8
  %41 = getelementptr inbounds i8, ptr %38, i64 %40
  br label %43

42:                                               ; preds = %23
  br label %43

43:                                               ; preds = %42, %37
  %44 = phi ptr [ %41, %37 ], [ null, %42 ]
  %45 = load i32, ptr %9, align 4
  %46 = and i32 %45, -3
  %47 = or i32 %46, 4
  %48 = call i32 @tinfl_decompress(ptr noundef %10, ptr noundef %33, ptr noundef %15, ptr noundef %34, ptr noundef %44, ptr noundef %16, i32 noundef %47)
  store i32 %48, ptr %18, align 4
  %49 = load i32, ptr %18, align 4
  %50 = icmp slt i32 %49, 0
  br i1 %50, label %54, label %51

51:                                               ; preds = %43
  %52 = load i32, ptr %18, align 4
  %53 = icmp eq i32 %52, 1
  br i1 %53, label %54, label %57

54:                                               ; preds = %51, %43
  %55 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %55)
  %56 = load ptr, ptr %8, align 8
  store i64 0, ptr %56, align 8
  store ptr null, ptr %5, align 8
  br label %88

57:                                               ; preds = %51
  %58 = load i64, ptr %15, align 8
  %59 = load i64, ptr %13, align 8
  %60 = add i64 %59, %58
  store i64 %60, ptr %13, align 8
  %61 = load i64, ptr %16, align 8
  %62 = load ptr, ptr %8, align 8
  %63 = load i64, ptr %62, align 8
  %64 = add i64 %63, %61
  store i64 %64, ptr %62, align 8
  %65 = load i32, ptr %18, align 4
  %66 = icmp eq i32 %65, 0
  br i1 %66, label %67, label %68

67:                                               ; preds = %57
  br label %86

68:                                               ; preds = %57
  %69 = load i64, ptr %14, align 8
  %70 = mul i64 %69, 2
  store i64 %70, ptr %17, align 8
  %71 = load i64, ptr %17, align 8
  %72 = icmp ult i64 %71, 128
  br i1 %72, label %73, label %74

73:                                               ; preds = %68
  store i64 128, ptr %17, align 8
  br label %74

74:                                               ; preds = %73, %68
  %75 = load ptr, ptr %11, align 8
  %76 = load i64, ptr %17, align 8
  %77 = call ptr @realloc(ptr noundef %75, i64 noundef %76) #13
  store ptr %77, ptr %12, align 8
  %78 = load ptr, ptr %12, align 8
  %79 = icmp ne ptr %78, null
  br i1 %79, label %83, label %80

80:                                               ; preds = %74
  %81 = load ptr, ptr %11, align 8
  call void @free(ptr noundef %81)
  %82 = load ptr, ptr %8, align 8
  store i64 0, ptr %82, align 8
  store ptr null, ptr %5, align 8
  br label %88

83:                                               ; preds = %74
  %84 = load ptr, ptr %12, align 8
  store ptr %84, ptr %11, align 8
  %85 = load i64, ptr %17, align 8
  store i64 %85, ptr %14, align 8
  br label %23

86:                                               ; preds = %67
  %87 = load ptr, ptr %11, align 8
  store ptr %87, ptr %5, align 8
  br label %88

88:                                               ; preds = %86, %80, %54
  %89 = load ptr, ptr %5, align 8
  ret ptr %89
}

declare void @free(ptr noundef) #4

; Function Attrs: allocsize(1)
declare ptr @realloc(ptr noundef, i64 noundef) #5

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @tinfl_decompress_mem_to_mem(ptr noundef %0, i64 noundef %1, ptr noundef %2, i64 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.tinfl_decompressor_tag, align 8
  %12 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i64 %3, ptr %9, align 8
  store i32 %4, ptr %10, align 4
  br label %13

13:                                               ; preds = %5
  %14 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %11, i32 0, i32 0
  store i32 0, ptr %14, align 8
  br label %15

15:                                               ; preds = %13
  %16 = load ptr, ptr %8, align 8
  %17 = load ptr, ptr %6, align 8
  %18 = load ptr, ptr %6, align 8
  %19 = load i32, ptr %10, align 4
  %20 = and i32 %19, -3
  %21 = or i32 %20, 4
  %22 = call i32 @tinfl_decompress(ptr noundef %11, ptr noundef %16, ptr noundef %9, ptr noundef %17, ptr noundef %18, ptr noundef %7, i32 noundef %21)
  store i32 %22, ptr %12, align 4
  %23 = load i32, ptr %12, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %26

25:                                               ; preds = %15
  br label %28

26:                                               ; preds = %15
  %27 = load i64, ptr %7, align 8
  br label %28

28:                                               ; preds = %26, %25
  %29 = phi i64 [ -1, %25 ], [ %27, %26 ]
  ret i64 %29
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tinfl_decompress_mem_to_callback(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.tinfl_decompressor_tag, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  %19 = alloca i32, align 4
  store ptr %0, ptr %7, align 8
  store ptr %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store i32 %4, ptr %11, align 4
  store i32 0, ptr %12, align 4
  %20 = call ptr @malloc(i64 noundef 32768) #11
  store ptr %20, ptr %14, align 8
  store i64 0, ptr %15, align 8
  store i64 0, ptr %16, align 8
  %21 = load ptr, ptr %14, align 8
  %22 = icmp ne ptr %21, null
  br i1 %22, label %24, label %23

23:                                               ; preds = %5
  store i32 -1, ptr %6, align 4
  br label %78

24:                                               ; preds = %5
  br label %25

25:                                               ; preds = %24
  %26 = getelementptr inbounds %struct.tinfl_decompressor_tag, ptr %13, i32 0, i32 0
  store i32 0, ptr %26, align 8
  br label %27

27:                                               ; preds = %25
  br label %28

28:                                               ; preds = %68, %27
  %29 = load ptr, ptr %8, align 8
  %30 = load i64, ptr %29, align 8
  %31 = load i64, ptr %15, align 8
  %32 = sub i64 %30, %31
  store i64 %32, ptr %17, align 8
  %33 = load i64, ptr %16, align 8
  %34 = sub i64 32768, %33
  store i64 %34, ptr %18, align 8
  %35 = load ptr, ptr %7, align 8
  %36 = load i64, ptr %15, align 8
  %37 = getelementptr inbounds i8, ptr %35, i64 %36
  %38 = load ptr, ptr %14, align 8
  %39 = load ptr, ptr %14, align 8
  %40 = load i64, ptr %16, align 8
  %41 = getelementptr inbounds i8, ptr %39, i64 %40
  %42 = load i32, ptr %11, align 4
  %43 = and i32 %42, -7
  %44 = call i32 @tinfl_decompress(ptr noundef %13, ptr noundef %37, ptr noundef %17, ptr noundef %38, ptr noundef %41, ptr noundef %18, i32 noundef %43)
  store i32 %44, ptr %19, align 4
  %45 = load i64, ptr %17, align 8
  %46 = load i64, ptr %15, align 8
  %47 = add i64 %46, %45
  store i64 %47, ptr %15, align 8
  %48 = load i64, ptr %18, align 8
  %49 = icmp ne i64 %48, 0
  br i1 %49, label %50, label %61

50:                                               ; preds = %28
  %51 = load ptr, ptr %9, align 8
  %52 = load ptr, ptr %14, align 8
  %53 = load i64, ptr %16, align 8
  %54 = getelementptr inbounds i8, ptr %52, i64 %53
  %55 = load i64, ptr %18, align 8
  %56 = trunc i64 %55 to i32
  %57 = load ptr, ptr %10, align 8
  %58 = call i32 %51(ptr noundef %54, i32 noundef %56, ptr noundef %57)
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %61, label %60

60:                                               ; preds = %50
  br label %73

61:                                               ; preds = %50, %28
  %62 = load i32, ptr %19, align 4
  %63 = icmp ne i32 %62, 2
  br i1 %63, label %64, label %68

64:                                               ; preds = %61
  %65 = load i32, ptr %19, align 4
  %66 = icmp eq i32 %65, 0
  %67 = zext i1 %66 to i32
  store i32 %67, ptr %12, align 4
  br label %73

68:                                               ; preds = %61
  %69 = load i64, ptr %16, align 8
  %70 = load i64, ptr %18, align 8
  %71 = add i64 %69, %70
  %72 = and i64 %71, 32767
  store i64 %72, ptr %16, align 8
  br label %28

73:                                               ; preds = %64, %60
  %74 = load ptr, ptr %14, align 8
  call void @free(ptr noundef %74)
  %75 = load i64, ptr %15, align 8
  %76 = load ptr, ptr %8, align 8
  store i64 %75, ptr %76, align 8
  %77 = load i32, ptr %12, align 4
  store i32 %77, ptr %6, align 4
  br label %78

78:                                               ; preds = %73, %23
  %79 = load i32, ptr %6, align 4
  ret i32 %79
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #6

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_flush_output_buffer(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.tdefl_compressor, ptr %4, i32 0, i32 30
  %6 = load ptr, ptr %5, align 8
  %7 = icmp ne ptr %6, null
  br i1 %7, label %8, label %21

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 8
  %10 = getelementptr inbounds %struct.tdefl_compressor, ptr %9, i32 0, i32 33
  %11 = load ptr, ptr %10, align 8
  %12 = load ptr, ptr %2, align 8
  %13 = getelementptr inbounds %struct.tdefl_compressor, ptr %12, i32 0, i32 28
  %14 = load ptr, ptr %13, align 8
  %15 = ptrtoint ptr %11 to i64
  %16 = ptrtoint ptr %14 to i64
  %17 = sub i64 %15, %16
  %18 = load ptr, ptr %2, align 8
  %19 = getelementptr inbounds %struct.tdefl_compressor, ptr %18, i32 0, i32 30
  %20 = load ptr, ptr %19, align 8
  store i64 %17, ptr %20, align 8
  br label %21

21:                                               ; preds = %8, %1
  %22 = load ptr, ptr %2, align 8
  %23 = getelementptr inbounds %struct.tdefl_compressor, ptr %22, i32 0, i32 31
  %24 = load ptr, ptr %23, align 8
  %25 = icmp ne ptr %24, null
  br i1 %25, label %26, label %104

26:                                               ; preds = %21
  %27 = load ptr, ptr %2, align 8
  %28 = getelementptr inbounds %struct.tdefl_compressor, ptr %27, i32 0, i32 31
  %29 = load ptr, ptr %28, align 8
  %30 = load i64, ptr %29, align 8
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.tdefl_compressor, ptr %31, i32 0, i32 35
  %33 = load i64, ptr %32, align 8
  %34 = sub i64 %30, %33
  %35 = load ptr, ptr %2, align 8
  %36 = getelementptr inbounds %struct.tdefl_compressor, ptr %35, i32 0, i32 23
  %37 = load i32, ptr %36, align 4
  %38 = zext i32 %37 to i64
  %39 = icmp ult i64 %34, %38
  br i1 %39, label %40, label %49

40:                                               ; preds = %26
  %41 = load ptr, ptr %2, align 8
  %42 = getelementptr inbounds %struct.tdefl_compressor, ptr %41, i32 0, i32 31
  %43 = load ptr, ptr %42, align 8
  %44 = load i64, ptr %43, align 8
  %45 = load ptr, ptr %2, align 8
  %46 = getelementptr inbounds %struct.tdefl_compressor, ptr %45, i32 0, i32 35
  %47 = load i64, ptr %46, align 8
  %48 = sub i64 %44, %47
  br label %54

49:                                               ; preds = %26
  %50 = load ptr, ptr %2, align 8
  %51 = getelementptr inbounds %struct.tdefl_compressor, ptr %50, i32 0, i32 23
  %52 = load i32, ptr %51, align 4
  %53 = zext i32 %52 to i64
  br label %54

54:                                               ; preds = %49, %40
  %55 = phi i64 [ %48, %40 ], [ %53, %49 ]
  store i64 %55, ptr %3, align 8
  %56 = load ptr, ptr %2, align 8
  %57 = getelementptr inbounds %struct.tdefl_compressor, ptr %56, i32 0, i32 29
  %58 = load ptr, ptr %57, align 8
  %59 = load ptr, ptr %2, align 8
  %60 = getelementptr inbounds %struct.tdefl_compressor, ptr %59, i32 0, i32 35
  %61 = load i64, ptr %60, align 8
  %62 = getelementptr inbounds i8, ptr %58, i64 %61
  %63 = load ptr, ptr %2, align 8
  %64 = getelementptr inbounds %struct.tdefl_compressor, ptr %63, i32 0, i32 43
  %65 = getelementptr inbounds [85196 x i8], ptr %64, i64 0, i64 0
  %66 = load ptr, ptr %2, align 8
  %67 = getelementptr inbounds %struct.tdefl_compressor, ptr %66, i32 0, i32 22
  %68 = load i32, ptr %67, align 8
  %69 = zext i32 %68 to i64
  %70 = getelementptr inbounds i8, ptr %65, i64 %69
  %71 = load i64, ptr %3, align 8
  %72 = load ptr, ptr %2, align 8
  %73 = getelementptr inbounds %struct.tdefl_compressor, ptr %72, i32 0, i32 29
  %74 = load ptr, ptr %73, align 8
  %75 = load ptr, ptr %2, align 8
  %76 = getelementptr inbounds %struct.tdefl_compressor, ptr %75, i32 0, i32 35
  %77 = load i64, ptr %76, align 8
  %78 = getelementptr inbounds i8, ptr %74, i64 %77
  %79 = call i64 @llvm.objectsize.i64.p0(ptr %78, i1 false, i1 true, i1 false)
  %80 = call ptr @__memcpy_chk(ptr noundef %62, ptr noundef %70, i64 noundef %71, i64 noundef %79) #12
  %81 = load i64, ptr %3, align 8
  %82 = trunc i64 %81 to i32
  %83 = load ptr, ptr %2, align 8
  %84 = getelementptr inbounds %struct.tdefl_compressor, ptr %83, i32 0, i32 22
  %85 = load i32, ptr %84, align 8
  %86 = add i32 %85, %82
  store i32 %86, ptr %84, align 8
  %87 = load i64, ptr %3, align 8
  %88 = trunc i64 %87 to i32
  %89 = load ptr, ptr %2, align 8
  %90 = getelementptr inbounds %struct.tdefl_compressor, ptr %89, i32 0, i32 23
  %91 = load i32, ptr %90, align 4
  %92 = sub i32 %91, %88
  store i32 %92, ptr %90, align 4
  %93 = load i64, ptr %3, align 8
  %94 = load ptr, ptr %2, align 8
  %95 = getelementptr inbounds %struct.tdefl_compressor, ptr %94, i32 0, i32 35
  %96 = load i64, ptr %95, align 8
  %97 = add i64 %96, %93
  store i64 %97, ptr %95, align 8
  %98 = load ptr, ptr %2, align 8
  %99 = getelementptr inbounds %struct.tdefl_compressor, ptr %98, i32 0, i32 35
  %100 = load i64, ptr %99, align 8
  %101 = load ptr, ptr %2, align 8
  %102 = getelementptr inbounds %struct.tdefl_compressor, ptr %101, i32 0, i32 31
  %103 = load ptr, ptr %102, align 8
  store i64 %100, ptr %103, align 8
  br label %104

104:                                              ; preds = %54, %21
  %105 = load ptr, ptr %2, align 8
  %106 = getelementptr inbounds %struct.tdefl_compressor, ptr %105, i32 0, i32 24
  %107 = load i32, ptr %106, align 8
  %108 = icmp ne i32 %107, 0
  br i1 %108, label %109, label %115

109:                                              ; preds = %104
  %110 = load ptr, ptr %2, align 8
  %111 = getelementptr inbounds %struct.tdefl_compressor, ptr %110, i32 0, i32 23
  %112 = load i32, ptr %111, align 4
  %113 = icmp ne i32 %112, 0
  %114 = xor i1 %113, true
  br label %115

115:                                              ; preds = %109, %104
  %116 = phi i1 [ false, %104 ], [ %114, %109 ]
  %117 = zext i1 %116 to i64
  %118 = select i1 %116, i32 1, i32 0
  ret i32 %118
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_compress_fast(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca ptr, align 8
  %23 = alloca ptr, align 8
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i8, align 1
  %29 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.tdefl_compressor, ptr %30, i32 0, i32 7
  %32 = load i32, ptr %31, align 8
  store i32 %32, ptr %4, align 4
  %33 = load ptr, ptr %3, align 8
  %34 = getelementptr inbounds %struct.tdefl_compressor, ptr %33, i32 0, i32 8
  %35 = load i32, ptr %34, align 4
  store i32 %35, ptr %5, align 4
  %36 = load ptr, ptr %3, align 8
  %37 = getelementptr inbounds %struct.tdefl_compressor, ptr %36, i32 0, i32 9
  %38 = load i32, ptr %37, align 8
  store i32 %38, ptr %6, align 4
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %struct.tdefl_compressor, ptr %39, i32 0, i32 15
  %41 = load i32, ptr %40, align 4
  store i32 %41, ptr %7, align 4
  %42 = load ptr, ptr %3, align 8
  %43 = getelementptr inbounds %struct.tdefl_compressor, ptr %42, i32 0, i32 14
  %44 = load i32, ptr %43, align 8
  store i32 %44, ptr %8, align 4
  %45 = load ptr, ptr %3, align 8
  %46 = getelementptr inbounds %struct.tdefl_compressor, ptr %45, i32 0, i32 10
  %47 = load ptr, ptr %46, align 8
  store ptr %47, ptr %9, align 8
  %48 = load ptr, ptr %3, align 8
  %49 = getelementptr inbounds %struct.tdefl_compressor, ptr %48, i32 0, i32 11
  %50 = load ptr, ptr %49, align 8
  store ptr %50, ptr %10, align 8
  %51 = load i32, ptr %4, align 4
  %52 = and i32 %51, 32767
  store i32 %52, ptr %11, align 4
  br label %53

53:                                               ; preds = %667, %1
  %54 = load ptr, ptr %3, align 8
  %55 = getelementptr inbounds %struct.tdefl_compressor, ptr %54, i32 0, i32 34
  %56 = load i64, ptr %55, align 8
  %57 = icmp ne i64 %56, 0
  br i1 %57, label %68, label %58

58:                                               ; preds = %53
  %59 = load ptr, ptr %3, align 8
  %60 = getelementptr inbounds %struct.tdefl_compressor, ptr %59, i32 0, i32 32
  %61 = load i32, ptr %60, align 8
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %66

63:                                               ; preds = %58
  %64 = load i32, ptr %5, align 4
  %65 = icmp ne i32 %64, 0
  br label %66

66:                                               ; preds = %63, %58
  %67 = phi i1 [ false, %58 ], [ %65, %63 ]
  br label %68

68:                                               ; preds = %66, %53
  %69 = phi i1 [ true, %53 ], [ %67, %66 ]
  br i1 %69, label %70, label %668

70:                                               ; preds = %68
  store i32 4096, ptr %12, align 4
  %71 = load i32, ptr %4, align 4
  %72 = load i32, ptr %5, align 4
  %73 = add i32 %71, %72
  %74 = and i32 %73, 32767
  store i32 %74, ptr %13, align 4
  %75 = load ptr, ptr %3, align 8
  %76 = getelementptr inbounds %struct.tdefl_compressor, ptr %75, i32 0, i32 34
  %77 = load i64, ptr %76, align 8
  %78 = load i32, ptr %5, align 4
  %79 = sub i32 4096, %78
  %80 = zext i32 %79 to i64
  %81 = icmp ult i64 %77, %80
  br i1 %81, label %82, label %86

82:                                               ; preds = %70
  %83 = load ptr, ptr %3, align 8
  %84 = getelementptr inbounds %struct.tdefl_compressor, ptr %83, i32 0, i32 34
  %85 = load i64, ptr %84, align 8
  br label %90

86:                                               ; preds = %70
  %87 = load i32, ptr %5, align 4
  %88 = sub i32 4096, %87
  %89 = zext i32 %88 to i64
  br label %90

90:                                               ; preds = %86, %82
  %91 = phi i64 [ %85, %82 ], [ %89, %86 ]
  %92 = trunc i64 %91 to i32
  store i32 %92, ptr %14, align 4
  %93 = load i32, ptr %14, align 4
  %94 = zext i32 %93 to i64
  %95 = load ptr, ptr %3, align 8
  %96 = getelementptr inbounds %struct.tdefl_compressor, ptr %95, i32 0, i32 34
  %97 = load i64, ptr %96, align 8
  %98 = sub i64 %97, %94
  store i64 %98, ptr %96, align 8
  %99 = load i32, ptr %14, align 4
  %100 = load i32, ptr %5, align 4
  %101 = add i32 %100, %99
  store i32 %101, ptr %5, align 4
  br label %102

102:                                              ; preds = %170, %90
  %103 = load i32, ptr %14, align 4
  %104 = icmp ne i32 %103, 0
  br i1 %104, label %105, label %184

105:                                              ; preds = %102
  %106 = load i32, ptr %13, align 4
  %107 = sub i32 32768, %106
  %108 = load i32, ptr %14, align 4
  %109 = icmp ult i32 %107, %108
  br i1 %109, label %110, label %113

110:                                              ; preds = %105
  %111 = load i32, ptr %13, align 4
  %112 = sub i32 32768, %111
  br label %115

113:                                              ; preds = %105
  %114 = load i32, ptr %14, align 4
  br label %115

115:                                              ; preds = %113, %110
  %116 = phi i32 [ %112, %110 ], [ %114, %113 ]
  store i32 %116, ptr %15, align 4
  %117 = load ptr, ptr %3, align 8
  %118 = getelementptr inbounds %struct.tdefl_compressor, ptr %117, i32 0, i32 36
  %119 = getelementptr inbounds [33025 x i8], ptr %118, i64 0, i64 0
  %120 = load i32, ptr %13, align 4
  %121 = zext i32 %120 to i64
  %122 = getelementptr inbounds i8, ptr %119, i64 %121
  %123 = load ptr, ptr %3, align 8
  %124 = getelementptr inbounds %struct.tdefl_compressor, ptr %123, i32 0, i32 33
  %125 = load ptr, ptr %124, align 8
  %126 = load i32, ptr %15, align 4
  %127 = zext i32 %126 to i64
  %128 = load ptr, ptr %3, align 8
  %129 = getelementptr inbounds %struct.tdefl_compressor, ptr %128, i32 0, i32 36
  %130 = getelementptr inbounds [33025 x i8], ptr %129, i64 0, i64 0
  %131 = load i32, ptr %13, align 4
  %132 = zext i32 %131 to i64
  %133 = getelementptr inbounds i8, ptr %130, i64 %132
  %134 = call i64 @llvm.objectsize.i64.p0(ptr %133, i1 false, i1 true, i1 false)
  %135 = call ptr @__memcpy_chk(ptr noundef %122, ptr noundef %125, i64 noundef %127, i64 noundef %134) #12
  %136 = load i32, ptr %13, align 4
  %137 = icmp ult i32 %136, 257
  br i1 %137, label %138, label %170

138:                                              ; preds = %115
  %139 = load ptr, ptr %3, align 8
  %140 = getelementptr inbounds %struct.tdefl_compressor, ptr %139, i32 0, i32 36
  %141 = getelementptr inbounds [33025 x i8], ptr %140, i64 0, i64 0
  %142 = getelementptr inbounds i8, ptr %141, i64 32768
  %143 = load i32, ptr %13, align 4
  %144 = zext i32 %143 to i64
  %145 = getelementptr inbounds i8, ptr %142, i64 %144
  %146 = load ptr, ptr %3, align 8
  %147 = getelementptr inbounds %struct.tdefl_compressor, ptr %146, i32 0, i32 33
  %148 = load ptr, ptr %147, align 8
  %149 = load i32, ptr %15, align 4
  %150 = load i32, ptr %13, align 4
  %151 = sub i32 257, %150
  %152 = icmp ult i32 %149, %151
  br i1 %152, label %153, label %155

153:                                              ; preds = %138
  %154 = load i32, ptr %15, align 4
  br label %158

155:                                              ; preds = %138
  %156 = load i32, ptr %13, align 4
  %157 = sub i32 257, %156
  br label %158

158:                                              ; preds = %155, %153
  %159 = phi i32 [ %154, %153 ], [ %157, %155 ]
  %160 = zext i32 %159 to i64
  %161 = load ptr, ptr %3, align 8
  %162 = getelementptr inbounds %struct.tdefl_compressor, ptr %161, i32 0, i32 36
  %163 = getelementptr inbounds [33025 x i8], ptr %162, i64 0, i64 0
  %164 = getelementptr inbounds i8, ptr %163, i64 32768
  %165 = load i32, ptr %13, align 4
  %166 = zext i32 %165 to i64
  %167 = getelementptr inbounds i8, ptr %164, i64 %166
  %168 = call i64 @llvm.objectsize.i64.p0(ptr %167, i1 false, i1 true, i1 false)
  %169 = call ptr @__memcpy_chk(ptr noundef %145, ptr noundef %148, i64 noundef %160, i64 noundef %168) #12
  br label %170

170:                                              ; preds = %158, %115
  %171 = load i32, ptr %15, align 4
  %172 = load ptr, ptr %3, align 8
  %173 = getelementptr inbounds %struct.tdefl_compressor, ptr %172, i32 0, i32 33
  %174 = load ptr, ptr %173, align 8
  %175 = zext i32 %171 to i64
  %176 = getelementptr inbounds i8, ptr %174, i64 %175
  store ptr %176, ptr %173, align 8
  %177 = load i32, ptr %13, align 4
  %178 = load i32, ptr %15, align 4
  %179 = add i32 %177, %178
  %180 = and i32 %179, 32767
  store i32 %180, ptr %13, align 4
  %181 = load i32, ptr %15, align 4
  %182 = load i32, ptr %14, align 4
  %183 = sub i32 %182, %181
  store i32 %183, ptr %14, align 4
  br label %102, !llvm.loop !63

184:                                              ; preds = %102
  %185 = load i32, ptr %5, align 4
  %186 = sub i32 32768, %185
  %187 = load i32, ptr %6, align 4
  %188 = icmp ult i32 %186, %187
  br i1 %188, label %189, label %192

189:                                              ; preds = %184
  %190 = load i32, ptr %5, align 4
  %191 = sub i32 32768, %190
  br label %194

192:                                              ; preds = %184
  %193 = load i32, ptr %6, align 4
  br label %194

194:                                              ; preds = %192, %189
  %195 = phi i32 [ %191, %189 ], [ %193, %192 ]
  store i32 %195, ptr %6, align 4
  %196 = load ptr, ptr %3, align 8
  %197 = getelementptr inbounds %struct.tdefl_compressor, ptr %196, i32 0, i32 32
  %198 = load i32, ptr %197, align 8
  %199 = icmp ne i32 %198, 0
  br i1 %199, label %204, label %200

200:                                              ; preds = %194
  %201 = load i32, ptr %5, align 4
  %202 = icmp ult i32 %201, 4096
  br i1 %202, label %203, label %204

203:                                              ; preds = %200
  br label %668

204:                                              ; preds = %200, %194
  br label %205

205:                                              ; preds = %564, %204
  %206 = load i32, ptr %5, align 4
  %207 = icmp uge i32 %206, 4
  br i1 %207, label %208, label %565

208:                                              ; preds = %205
  store i32 1, ptr %17, align 4
  %209 = load ptr, ptr %3, align 8
  %210 = getelementptr inbounds %struct.tdefl_compressor, ptr %209, i32 0, i32 36
  %211 = getelementptr inbounds [33025 x i8], ptr %210, i64 0, i64 0
  %212 = load i32, ptr %11, align 4
  %213 = zext i32 %212 to i64
  %214 = getelementptr inbounds i8, ptr %211, i64 %213
  store ptr %214, ptr %18, align 8
  %215 = load ptr, ptr %18, align 8
  %216 = load i32, ptr %215, align 4
  %217 = and i32 %216, 16777215
  store i32 %217, ptr %19, align 4
  %218 = load i32, ptr %19, align 4
  %219 = load i32, ptr %19, align 4
  %220 = lshr i32 %219, 17
  %221 = xor i32 %218, %220
  %222 = and i32 %221, 4095
  store i32 %222, ptr %20, align 4
  %223 = load ptr, ptr %3, align 8
  %224 = getelementptr inbounds %struct.tdefl_compressor, ptr %223, i32 0, i32 42
  %225 = load i32, ptr %20, align 4
  %226 = zext i32 %225 to i64
  %227 = getelementptr inbounds [32768 x i32], ptr %224, i64 0, i64 %226
  %228 = load i32, ptr %227, align 2
  %229 = add i32 %228, 0
  store i32 %229, ptr %21, align 4
  %230 = load i32, ptr %4, align 4
  %231 = add i32 %230, 0
  %232 = load ptr, ptr %3, align 8
  %233 = getelementptr inbounds %struct.tdefl_compressor, ptr %232, i32 0, i32 42
  %234 = load i32, ptr %20, align 4
  %235 = zext i32 %234 to i64
  %236 = getelementptr inbounds [32768 x i32], ptr %233, i64 0, i64 %235
  store i32 %231, ptr %236, align 2
  %237 = load i32, ptr %4, align 4
  %238 = load i32, ptr %21, align 4
  %239 = sub i32 %237, %238
  %240 = add i32 %239, 0
  %241 = add i32 %240, 0
  store i32 %241, ptr %16, align 4
  %242 = load i32, ptr %6, align 4
  %243 = icmp ule i32 %241, %242
  br i1 %243, label %244, label %453

244:                                              ; preds = %208
  %245 = load ptr, ptr %3, align 8
  %246 = getelementptr inbounds %struct.tdefl_compressor, ptr %245, i32 0, i32 36
  %247 = getelementptr inbounds [33025 x i8], ptr %246, i64 0, i64 0
  %248 = load i32, ptr %21, align 4
  %249 = and i32 %248, 32767
  store i32 %249, ptr %21, align 4
  %250 = zext i32 %249 to i64
  %251 = getelementptr inbounds i8, ptr %247, i64 %250
  %252 = load i32, ptr %251, align 4
  %253 = and i32 %252, 16777215
  %254 = load i32, ptr %19, align 4
  %255 = icmp eq i32 %253, %254
  br i1 %255, label %256, label %453

256:                                              ; preds = %244
  %257 = load ptr, ptr %18, align 8
  store ptr %257, ptr %22, align 8
  %258 = load ptr, ptr %3, align 8
  %259 = getelementptr inbounds %struct.tdefl_compressor, ptr %258, i32 0, i32 36
  %260 = getelementptr inbounds [33025 x i8], ptr %259, i64 0, i64 0
  %261 = load i32, ptr %21, align 4
  %262 = zext i32 %261 to i64
  %263 = getelementptr inbounds i8, ptr %260, i64 %262
  store ptr %263, ptr %23, align 8
  store i32 32, ptr %24, align 4
  br label %264

264:                                              ; preds = %309, %256
  br label %265

265:                                              ; preds = %264
  %266 = load ptr, ptr %22, align 8
  %267 = getelementptr inbounds i32, ptr %266, i32 1
  store ptr %267, ptr %22, align 8
  %268 = load i32, ptr %267, align 2
  %269 = add i32 %268, 0
  %270 = load ptr, ptr %23, align 8
  %271 = getelementptr inbounds i32, ptr %270, i32 1
  store ptr %271, ptr %23, align 8
  %272 = load i32, ptr %271, align 2
  %273 = add i32 %272, 0
  %274 = icmp eq i32 %269, %273
  br i1 %274, label %275, label %309

275:                                              ; preds = %265
  %276 = load ptr, ptr %22, align 8
  %277 = getelementptr inbounds i32, ptr %276, i32 1
  store ptr %277, ptr %22, align 8
  %278 = load i32, ptr %277, align 2
  %279 = add i32 %278, 0
  %280 = load ptr, ptr %23, align 8
  %281 = getelementptr inbounds i32, ptr %280, i32 1
  store ptr %281, ptr %23, align 8
  %282 = load i32, ptr %281, align 2
  %283 = add i32 %282, 0
  %284 = icmp eq i32 %279, %283
  br i1 %284, label %285, label %309

285:                                              ; preds = %275
  %286 = load ptr, ptr %22, align 8
  %287 = getelementptr inbounds i32, ptr %286, i32 1
  store ptr %287, ptr %22, align 8
  %288 = load i32, ptr %287, align 2
  %289 = add i32 %288, 0
  %290 = load ptr, ptr %23, align 8
  %291 = getelementptr inbounds i32, ptr %290, i32 1
  store ptr %291, ptr %23, align 8
  %292 = load i32, ptr %291, align 2
  %293 = add i32 %292, 0
  %294 = icmp eq i32 %289, %293
  br i1 %294, label %295, label %309

295:                                              ; preds = %285
  %296 = load ptr, ptr %22, align 8
  %297 = getelementptr inbounds i32, ptr %296, i32 1
  store ptr %297, ptr %22, align 8
  %298 = load i32, ptr %297, align 2
  %299 = add i32 %298, 0
  %300 = load ptr, ptr %23, align 8
  %301 = getelementptr inbounds i32, ptr %300, i32 1
  store ptr %301, ptr %23, align 8
  %302 = load i32, ptr %301, align 2
  %303 = add i32 %302, 0
  %304 = icmp eq i32 %299, %303
  br i1 %304, label %305, label %309

305:                                              ; preds = %295
  %306 = load i32, ptr %24, align 4
  %307 = add i32 %306, -1
  store i32 %307, ptr %24, align 4
  %308 = icmp ugt i32 %307, 0
  br label %309

309:                                              ; preds = %305, %295, %285, %275, %265
  %310 = phi i1 [ false, %295 ], [ false, %285 ], [ false, %275 ], [ false, %265 ], [ %308, %305 ]
  br i1 %310, label %264, label %311, !llvm.loop !64

311:                                              ; preds = %309
  %312 = load ptr, ptr %22, align 8
  %313 = load ptr, ptr %18, align 8
  %314 = ptrtoint ptr %312 to i64
  %315 = ptrtoint ptr %313 to i64
  %316 = sub i64 %314, %315
  %317 = sdiv exact i64 %316, 2
  %318 = trunc i64 %317 to i32
  %319 = mul i32 %318, 2
  %320 = load ptr, ptr %22, align 8
  %321 = load i8, ptr %320, align 1
  %322 = zext i8 %321 to i32
  %323 = load ptr, ptr %23, align 8
  %324 = load i8, ptr %323, align 1
  %325 = zext i8 %324 to i32
  %326 = icmp eq i32 %322, %325
  %327 = zext i1 %326 to i32
  %328 = add i32 %319, %327
  store i32 %328, ptr %17, align 4
  %329 = load i32, ptr %24, align 4
  %330 = icmp ne i32 %329, 0
  br i1 %330, label %336, label %331

331:                                              ; preds = %311
  %332 = load i32, ptr %16, align 4
  %333 = icmp ne i32 %332, 0
  %334 = zext i1 %333 to i64
  %335 = select i1 %333, i32 258, i32 0
  store i32 %335, ptr %17, align 4
  br label %336

336:                                              ; preds = %331, %311
  %337 = load i32, ptr %17, align 4
  %338 = icmp ult i32 %337, 3
  br i1 %338, label %345, label %339

339:                                              ; preds = %336
  %340 = load i32, ptr %17, align 4
  %341 = icmp eq i32 %340, 3
  br i1 %341, label %342, label %365

342:                                              ; preds = %339
  %343 = load i32, ptr %16, align 4
  %344 = icmp uge i32 %343, 8192
  br i1 %344, label %345, label %365

345:                                              ; preds = %342, %336
  store i32 1, ptr %17, align 4
  %346 = load i32, ptr %19, align 4
  %347 = trunc i32 %346 to i8
  %348 = load ptr, ptr %9, align 8
  %349 = getelementptr inbounds i8, ptr %348, i32 1
  store ptr %349, ptr %9, align 8
  store i8 %347, ptr %348, align 1
  %350 = load ptr, ptr %10, align 8
  %351 = load i8, ptr %350, align 1
  %352 = zext i8 %351 to i32
  %353 = ashr i32 %352, 1
  %354 = trunc i32 %353 to i8
  %355 = load ptr, ptr %10, align 8
  store i8 %354, ptr %355, align 1
  %356 = load ptr, ptr %3, align 8
  %357 = getelementptr inbounds %struct.tdefl_compressor, ptr %356, i32 0, i32 37
  %358 = getelementptr inbounds [3 x [288 x i32]], ptr %357, i64 0, i64 0
  %359 = load i32, ptr %19, align 4
  %360 = trunc i32 %359 to i8
  %361 = zext i8 %360 to i64
  %362 = getelementptr inbounds [288 x i32], ptr %358, i64 0, i64 %361
  %363 = load i32, ptr %362, align 2
  %364 = add i32 %363, 1
  store i32 %364, ptr %362, align 2
  br label %452

365:                                              ; preds = %342, %339
  %366 = load i32, ptr %17, align 4
  %367 = load i32, ptr %5, align 4
  %368 = icmp ult i32 %366, %367
  br i1 %368, label %369, label %371

369:                                              ; preds = %365
  %370 = load i32, ptr %17, align 4
  br label %373

371:                                              ; preds = %365
  %372 = load i32, ptr %5, align 4
  br label %373

373:                                              ; preds = %371, %369
  %374 = phi i32 [ %370, %369 ], [ %372, %371 ]
  store i32 %374, ptr %17, align 4
  %375 = load i32, ptr %17, align 4
  %376 = icmp uge i32 %375, 3
  br i1 %376, label %377, label %383

377:                                              ; preds = %373
  %378 = load i32, ptr %16, align 4
  %379 = icmp uge i32 %378, 1
  br i1 %379, label %380, label %383

380:                                              ; preds = %377
  %381 = load i32, ptr %16, align 4
  %382 = icmp ule i32 %381, 32768
  br label %383

383:                                              ; preds = %380, %377, %373
  %384 = phi i1 [ false, %377 ], [ false, %373 ], [ %382, %380 ]
  %385 = xor i1 %384, true
  %386 = zext i1 %385 to i32
  %387 = sext i32 %386 to i64
  %388 = icmp ne i64 %387, 0
  br i1 %388, label %389, label %391

389:                                              ; preds = %383
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_fast, ptr noundef @.str.14, i32 noundef 2046, ptr noundef @.str.32) #14
  unreachable

390:                                              ; No predecessors!
  br label %392

391:                                              ; preds = %383
  br label %392

392:                                              ; preds = %391, %390
  %393 = load i32, ptr %16, align 4
  %394 = add i32 %393, -1
  store i32 %394, ptr %16, align 4
  %395 = load i32, ptr %17, align 4
  %396 = sub i32 %395, 3
  %397 = trunc i32 %396 to i8
  %398 = load ptr, ptr %9, align 8
  %399 = getelementptr inbounds i8, ptr %398, i64 0
  store i8 %397, ptr %399, align 1
  %400 = load i32, ptr %16, align 4
  %401 = add i32 %400, 0
  %402 = load ptr, ptr %9, align 8
  %403 = getelementptr inbounds i8, ptr %402, i64 1
  store i32 %401, ptr %403, align 2
  %404 = load ptr, ptr %9, align 8
  %405 = getelementptr inbounds i8, ptr %404, i64 3
  store ptr %405, ptr %9, align 8
  %406 = load ptr, ptr %10, align 8
  %407 = load i8, ptr %406, align 1
  %408 = zext i8 %407 to i32
  %409 = ashr i32 %408, 1
  %410 = or i32 %409, 128
  %411 = trunc i32 %410 to i8
  %412 = load ptr, ptr %10, align 8
  store i8 %411, ptr %412, align 1
  %413 = load i32, ptr %16, align 4
  %414 = and i32 %413, 511
  %415 = zext i32 %414 to i64
  %416 = getelementptr inbounds [512 x i8], ptr @s_tdefl_small_dist_sym, i64 0, i64 %415
  %417 = load i8, ptr %416, align 1
  %418 = zext i8 %417 to i32
  store i32 %418, ptr %25, align 4
  %419 = load i32, ptr %16, align 4
  %420 = lshr i32 %419, 8
  %421 = zext i32 %420 to i64
  %422 = getelementptr inbounds [128 x i8], ptr @s_tdefl_large_dist_sym, i64 0, i64 %421
  %423 = load i8, ptr %422, align 1
  %424 = zext i8 %423 to i32
  store i32 %424, ptr %26, align 4
  %425 = load ptr, ptr %3, align 8
  %426 = getelementptr inbounds %struct.tdefl_compressor, ptr %425, i32 0, i32 37
  %427 = getelementptr inbounds [3 x [288 x i32]], ptr %426, i64 0, i64 1
  %428 = load i32, ptr %16, align 4
  %429 = icmp ult i32 %428, 512
  br i1 %429, label %430, label %432

430:                                              ; preds = %392
  %431 = load i32, ptr %25, align 4
  br label %434

432:                                              ; preds = %392
  %433 = load i32, ptr %26, align 4
  br label %434

434:                                              ; preds = %432, %430
  %435 = phi i32 [ %431, %430 ], [ %433, %432 ]
  %436 = zext i32 %435 to i64
  %437 = getelementptr inbounds [288 x i32], ptr %427, i64 0, i64 %436
  %438 = load i32, ptr %437, align 2
  %439 = add i32 %438, 1
  store i32 %439, ptr %437, align 2
  %440 = load ptr, ptr %3, align 8
  %441 = getelementptr inbounds %struct.tdefl_compressor, ptr %440, i32 0, i32 37
  %442 = getelementptr inbounds [3 x [288 x i32]], ptr %441, i64 0, i64 0
  %443 = load i32, ptr %17, align 4
  %444 = sub i32 %443, 3
  %445 = zext i32 %444 to i64
  %446 = getelementptr inbounds [256 x i32], ptr @s_tdefl_len_sym, i64 0, i64 %445
  %447 = load i32, ptr %446, align 2
  %448 = zext i32 %447 to i64
  %449 = getelementptr inbounds [288 x i32], ptr %442, i64 0, i64 %448
  %450 = load i32, ptr %449, align 2
  %451 = add i32 %450, 1
  store i32 %451, ptr %449, align 2
  br label %452

452:                                              ; preds = %434, %345
  br label %473

453:                                              ; preds = %244, %208
  %454 = load i32, ptr %19, align 4
  %455 = trunc i32 %454 to i8
  %456 = load ptr, ptr %9, align 8
  %457 = getelementptr inbounds i8, ptr %456, i32 1
  store ptr %457, ptr %9, align 8
  store i8 %455, ptr %456, align 1
  %458 = load ptr, ptr %10, align 8
  %459 = load i8, ptr %458, align 1
  %460 = zext i8 %459 to i32
  %461 = ashr i32 %460, 1
  %462 = trunc i32 %461 to i8
  %463 = load ptr, ptr %10, align 8
  store i8 %462, ptr %463, align 1
  %464 = load ptr, ptr %3, align 8
  %465 = getelementptr inbounds %struct.tdefl_compressor, ptr %464, i32 0, i32 37
  %466 = getelementptr inbounds [3 x [288 x i32]], ptr %465, i64 0, i64 0
  %467 = load i32, ptr %19, align 4
  %468 = trunc i32 %467 to i8
  %469 = zext i8 %468 to i64
  %470 = getelementptr inbounds [288 x i32], ptr %466, i64 0, i64 %469
  %471 = load i32, ptr %470, align 2
  %472 = add i32 %471, 1
  store i32 %472, ptr %470, align 2
  br label %473

473:                                              ; preds = %453, %452
  %474 = load i32, ptr %8, align 4
  %475 = add i32 %474, -1
  store i32 %475, ptr %8, align 4
  %476 = icmp eq i32 %475, 0
  br i1 %476, label %477, label %480

477:                                              ; preds = %473
  store i32 8, ptr %8, align 4
  %478 = load ptr, ptr %9, align 8
  %479 = getelementptr inbounds i8, ptr %478, i32 1
  store ptr %479, ptr %9, align 8
  store ptr %478, ptr %10, align 8
  br label %480

480:                                              ; preds = %477, %473
  %481 = load i32, ptr %17, align 4
  %482 = load i32, ptr %7, align 4
  %483 = add i32 %482, %481
  store i32 %483, ptr %7, align 4
  %484 = load i32, ptr %17, align 4
  %485 = load i32, ptr %4, align 4
  %486 = add i32 %485, %484
  store i32 %486, ptr %4, align 4
  %487 = load i32, ptr %6, align 4
  %488 = load i32, ptr %17, align 4
  %489 = add i32 %487, %488
  %490 = icmp ult i32 %489, 32768
  br i1 %490, label %491, label %495

491:                                              ; preds = %480
  %492 = load i32, ptr %6, align 4
  %493 = load i32, ptr %17, align 4
  %494 = add i32 %492, %493
  br label %496

495:                                              ; preds = %480
  br label %496

496:                                              ; preds = %495, %491
  %497 = phi i32 [ %494, %491 ], [ 32768, %495 ]
  store i32 %497, ptr %6, align 4
  %498 = load i32, ptr %11, align 4
  %499 = load i32, ptr %17, align 4
  %500 = add i32 %498, %499
  %501 = and i32 %500, 32767
  store i32 %501, ptr %11, align 4
  %502 = load i32, ptr %5, align 4
  %503 = load i32, ptr %17, align 4
  %504 = icmp uge i32 %502, %503
  %505 = xor i1 %504, true
  %506 = zext i1 %505 to i32
  %507 = sext i32 %506 to i64
  %508 = icmp ne i64 %507, 0
  br i1 %508, label %509, label %511

509:                                              ; preds = %496
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_fast, ptr noundef @.str.14, i32 noundef 2075, ptr noundef @.str.33) #14
  unreachable

510:                                              ; No predecessors!
  br label %512

511:                                              ; preds = %496
  br label %512

512:                                              ; preds = %511, %510
  %513 = load i32, ptr %17, align 4
  %514 = load i32, ptr %5, align 4
  %515 = sub i32 %514, %513
  store i32 %515, ptr %5, align 4
  %516 = load ptr, ptr %9, align 8
  %517 = load ptr, ptr %3, align 8
  %518 = getelementptr inbounds %struct.tdefl_compressor, ptr %517, i32 0, i32 40
  %519 = getelementptr inbounds [65536 x i8], ptr %518, i64 0, i64 65528
  %520 = icmp ugt ptr %516, %519
  br i1 %520, label %521, label %564

521:                                              ; preds = %512
  %522 = load i32, ptr %4, align 4
  %523 = load ptr, ptr %3, align 8
  %524 = getelementptr inbounds %struct.tdefl_compressor, ptr %523, i32 0, i32 7
  store i32 %522, ptr %524, align 8
  %525 = load i32, ptr %5, align 4
  %526 = load ptr, ptr %3, align 8
  %527 = getelementptr inbounds %struct.tdefl_compressor, ptr %526, i32 0, i32 8
  store i32 %525, ptr %527, align 4
  %528 = load i32, ptr %6, align 4
  %529 = load ptr, ptr %3, align 8
  %530 = getelementptr inbounds %struct.tdefl_compressor, ptr %529, i32 0, i32 9
  store i32 %528, ptr %530, align 8
  %531 = load i32, ptr %7, align 4
  %532 = load ptr, ptr %3, align 8
  %533 = getelementptr inbounds %struct.tdefl_compressor, ptr %532, i32 0, i32 15
  store i32 %531, ptr %533, align 4
  %534 = load ptr, ptr %9, align 8
  %535 = load ptr, ptr %3, align 8
  %536 = getelementptr inbounds %struct.tdefl_compressor, ptr %535, i32 0, i32 10
  store ptr %534, ptr %536, align 8
  %537 = load ptr, ptr %10, align 8
  %538 = load ptr, ptr %3, align 8
  %539 = getelementptr inbounds %struct.tdefl_compressor, ptr %538, i32 0, i32 11
  store ptr %537, ptr %539, align 8
  %540 = load i32, ptr %8, align 4
  %541 = load ptr, ptr %3, align 8
  %542 = getelementptr inbounds %struct.tdefl_compressor, ptr %541, i32 0, i32 14
  store i32 %540, ptr %542, align 8
  %543 = load ptr, ptr %3, align 8
  %544 = call i32 @tdefl_flush_block(ptr noundef %543, i32 noundef 0)
  store i32 %544, ptr %27, align 4
  %545 = icmp ne i32 %544, 0
  br i1 %545, label %546, label %551

546:                                              ; preds = %521
  %547 = load i32, ptr %27, align 4
  %548 = icmp slt i32 %547, 0
  %549 = zext i1 %548 to i64
  %550 = select i1 %548, i32 0, i32 1
  store i32 %550, ptr %2, align 4
  br label %690

551:                                              ; preds = %521
  %552 = load ptr, ptr %3, align 8
  %553 = getelementptr inbounds %struct.tdefl_compressor, ptr %552, i32 0, i32 15
  %554 = load i32, ptr %553, align 4
  store i32 %554, ptr %7, align 4
  %555 = load ptr, ptr %3, align 8
  %556 = getelementptr inbounds %struct.tdefl_compressor, ptr %555, i32 0, i32 10
  %557 = load ptr, ptr %556, align 8
  store ptr %557, ptr %9, align 8
  %558 = load ptr, ptr %3, align 8
  %559 = getelementptr inbounds %struct.tdefl_compressor, ptr %558, i32 0, i32 11
  %560 = load ptr, ptr %559, align 8
  store ptr %560, ptr %10, align 8
  %561 = load ptr, ptr %3, align 8
  %562 = getelementptr inbounds %struct.tdefl_compressor, ptr %561, i32 0, i32 14
  %563 = load i32, ptr %562, align 8
  store i32 %563, ptr %8, align 4
  br label %564

564:                                              ; preds = %551, %512
  br label %205, !llvm.loop !65

565:                                              ; preds = %205
  br label %566

566:                                              ; preds = %666, %565
  %567 = load i32, ptr %5, align 4
  %568 = icmp ne i32 %567, 0
  br i1 %568, label %569, label %667

569:                                              ; preds = %566
  %570 = load ptr, ptr %3, align 8
  %571 = getelementptr inbounds %struct.tdefl_compressor, ptr %570, i32 0, i32 36
  %572 = load i32, ptr %11, align 4
  %573 = zext i32 %572 to i64
  %574 = getelementptr inbounds [33025 x i8], ptr %571, i64 0, i64 %573
  %575 = load i8, ptr %574, align 1
  store i8 %575, ptr %28, align 1
  %576 = load i32, ptr %7, align 4
  %577 = add i32 %576, 1
  store i32 %577, ptr %7, align 4
  %578 = load i8, ptr %28, align 1
  %579 = load ptr, ptr %9, align 8
  %580 = getelementptr inbounds i8, ptr %579, i32 1
  store ptr %580, ptr %9, align 8
  store i8 %578, ptr %579, align 1
  %581 = load ptr, ptr %10, align 8
  %582 = load i8, ptr %581, align 1
  %583 = zext i8 %582 to i32
  %584 = ashr i32 %583, 1
  %585 = trunc i32 %584 to i8
  %586 = load ptr, ptr %10, align 8
  store i8 %585, ptr %586, align 1
  %587 = load i32, ptr %8, align 4
  %588 = add i32 %587, -1
  store i32 %588, ptr %8, align 4
  %589 = icmp eq i32 %588, 0
  br i1 %589, label %590, label %593

590:                                              ; preds = %569
  store i32 8, ptr %8, align 4
  %591 = load ptr, ptr %9, align 8
  %592 = getelementptr inbounds i8, ptr %591, i32 1
  store ptr %592, ptr %9, align 8
  store ptr %591, ptr %10, align 8
  br label %593

593:                                              ; preds = %590, %569
  %594 = load ptr, ptr %3, align 8
  %595 = getelementptr inbounds %struct.tdefl_compressor, ptr %594, i32 0, i32 37
  %596 = getelementptr inbounds [3 x [288 x i32]], ptr %595, i64 0, i64 0
  %597 = load i8, ptr %28, align 1
  %598 = zext i8 %597 to i64
  %599 = getelementptr inbounds [288 x i32], ptr %596, i64 0, i64 %598
  %600 = load i32, ptr %599, align 2
  %601 = add i32 %600, 1
  store i32 %601, ptr %599, align 2
  %602 = load i32, ptr %4, align 4
  %603 = add i32 %602, 1
  store i32 %603, ptr %4, align 4
  %604 = load i32, ptr %6, align 4
  %605 = add i32 %604, 1
  %606 = icmp ult i32 %605, 32768
  br i1 %606, label %607, label %610

607:                                              ; preds = %593
  %608 = load i32, ptr %6, align 4
  %609 = add i32 %608, 1
  br label %611

610:                                              ; preds = %593
  br label %611

611:                                              ; preds = %610, %607
  %612 = phi i32 [ %609, %607 ], [ 32768, %610 ]
  store i32 %612, ptr %6, align 4
  %613 = load i32, ptr %11, align 4
  %614 = add i32 %613, 1
  %615 = and i32 %614, 32767
  store i32 %615, ptr %11, align 4
  %616 = load i32, ptr %5, align 4
  %617 = add i32 %616, -1
  store i32 %617, ptr %5, align 4
  %618 = load ptr, ptr %9, align 8
  %619 = load ptr, ptr %3, align 8
  %620 = getelementptr inbounds %struct.tdefl_compressor, ptr %619, i32 0, i32 40
  %621 = getelementptr inbounds [65536 x i8], ptr %620, i64 0, i64 65528
  %622 = icmp ugt ptr %618, %621
  br i1 %622, label %623, label %666

623:                                              ; preds = %611
  %624 = load i32, ptr %4, align 4
  %625 = load ptr, ptr %3, align 8
  %626 = getelementptr inbounds %struct.tdefl_compressor, ptr %625, i32 0, i32 7
  store i32 %624, ptr %626, align 8
  %627 = load i32, ptr %5, align 4
  %628 = load ptr, ptr %3, align 8
  %629 = getelementptr inbounds %struct.tdefl_compressor, ptr %628, i32 0, i32 8
  store i32 %627, ptr %629, align 4
  %630 = load i32, ptr %6, align 4
  %631 = load ptr, ptr %3, align 8
  %632 = getelementptr inbounds %struct.tdefl_compressor, ptr %631, i32 0, i32 9
  store i32 %630, ptr %632, align 8
  %633 = load i32, ptr %7, align 4
  %634 = load ptr, ptr %3, align 8
  %635 = getelementptr inbounds %struct.tdefl_compressor, ptr %634, i32 0, i32 15
  store i32 %633, ptr %635, align 4
  %636 = load ptr, ptr %9, align 8
  %637 = load ptr, ptr %3, align 8
  %638 = getelementptr inbounds %struct.tdefl_compressor, ptr %637, i32 0, i32 10
  store ptr %636, ptr %638, align 8
  %639 = load ptr, ptr %10, align 8
  %640 = load ptr, ptr %3, align 8
  %641 = getelementptr inbounds %struct.tdefl_compressor, ptr %640, i32 0, i32 11
  store ptr %639, ptr %641, align 8
  %642 = load i32, ptr %8, align 4
  %643 = load ptr, ptr %3, align 8
  %644 = getelementptr inbounds %struct.tdefl_compressor, ptr %643, i32 0, i32 14
  store i32 %642, ptr %644, align 8
  %645 = load ptr, ptr %3, align 8
  %646 = call i32 @tdefl_flush_block(ptr noundef %645, i32 noundef 0)
  store i32 %646, ptr %29, align 4
  %647 = icmp ne i32 %646, 0
  br i1 %647, label %648, label %653

648:                                              ; preds = %623
  %649 = load i32, ptr %29, align 4
  %650 = icmp slt i32 %649, 0
  %651 = zext i1 %650 to i64
  %652 = select i1 %650, i32 0, i32 1
  store i32 %652, ptr %2, align 4
  br label %690

653:                                              ; preds = %623
  %654 = load ptr, ptr %3, align 8
  %655 = getelementptr inbounds %struct.tdefl_compressor, ptr %654, i32 0, i32 15
  %656 = load i32, ptr %655, align 4
  store i32 %656, ptr %7, align 4
  %657 = load ptr, ptr %3, align 8
  %658 = getelementptr inbounds %struct.tdefl_compressor, ptr %657, i32 0, i32 10
  %659 = load ptr, ptr %658, align 8
  store ptr %659, ptr %9, align 8
  %660 = load ptr, ptr %3, align 8
  %661 = getelementptr inbounds %struct.tdefl_compressor, ptr %660, i32 0, i32 11
  %662 = load ptr, ptr %661, align 8
  store ptr %662, ptr %10, align 8
  %663 = load ptr, ptr %3, align 8
  %664 = getelementptr inbounds %struct.tdefl_compressor, ptr %663, i32 0, i32 14
  %665 = load i32, ptr %664, align 8
  store i32 %665, ptr %8, align 4
  br label %666

666:                                              ; preds = %653, %611
  br label %566, !llvm.loop !66

667:                                              ; preds = %566
  br label %53, !llvm.loop !67

668:                                              ; preds = %203, %68
  %669 = load i32, ptr %4, align 4
  %670 = load ptr, ptr %3, align 8
  %671 = getelementptr inbounds %struct.tdefl_compressor, ptr %670, i32 0, i32 7
  store i32 %669, ptr %671, align 8
  %672 = load i32, ptr %5, align 4
  %673 = load ptr, ptr %3, align 8
  %674 = getelementptr inbounds %struct.tdefl_compressor, ptr %673, i32 0, i32 8
  store i32 %672, ptr %674, align 4
  %675 = load i32, ptr %6, align 4
  %676 = load ptr, ptr %3, align 8
  %677 = getelementptr inbounds %struct.tdefl_compressor, ptr %676, i32 0, i32 9
  store i32 %675, ptr %677, align 8
  %678 = load i32, ptr %7, align 4
  %679 = load ptr, ptr %3, align 8
  %680 = getelementptr inbounds %struct.tdefl_compressor, ptr %679, i32 0, i32 15
  store i32 %678, ptr %680, align 4
  %681 = load ptr, ptr %9, align 8
  %682 = load ptr, ptr %3, align 8
  %683 = getelementptr inbounds %struct.tdefl_compressor, ptr %682, i32 0, i32 10
  store ptr %681, ptr %683, align 8
  %684 = load ptr, ptr %10, align 8
  %685 = load ptr, ptr %3, align 8
  %686 = getelementptr inbounds %struct.tdefl_compressor, ptr %685, i32 0, i32 11
  store ptr %684, ptr %686, align 8
  %687 = load i32, ptr %8, align 4
  %688 = load ptr, ptr %3, align 8
  %689 = getelementptr inbounds %struct.tdefl_compressor, ptr %688, i32 0, i32 14
  store i32 %687, ptr %689, align 8
  store i32 1, ptr %2, align 4
  br label %690

690:                                              ; preds = %668, %648, %546
  %691 = load i32, ptr %2, align 4
  ret i32 %691
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_compress_normal(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca i8, align 1
  %17 = alloca i8, align 1
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i8, align 1
  %22 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %23 = load ptr, ptr %3, align 8
  %24 = getelementptr inbounds %struct.tdefl_compressor, ptr %23, i32 0, i32 33
  %25 = load ptr, ptr %24, align 8
  store ptr %25, ptr %4, align 8
  %26 = load ptr, ptr %3, align 8
  %27 = getelementptr inbounds %struct.tdefl_compressor, ptr %26, i32 0, i32 34
  %28 = load i64, ptr %27, align 8
  store i64 %28, ptr %5, align 8
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %struct.tdefl_compressor, ptr %29, i32 0, i32 32
  %31 = load i32, ptr %30, align 8
  store i32 %31, ptr %6, align 4
  br label %32

32:                                               ; preds = %615, %1
  %33 = load i64, ptr %5, align 8
  %34 = icmp ne i64 %33, 0
  br i1 %34, label %45, label %35

35:                                               ; preds = %32
  %36 = load i32, ptr %6, align 4
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %38, label %43

38:                                               ; preds = %35
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %struct.tdefl_compressor, ptr %39, i32 0, i32 8
  %41 = load i32, ptr %40, align 4
  %42 = icmp ne i32 %41, 0
  br label %43

43:                                               ; preds = %38, %35
  %44 = phi i1 [ false, %35 ], [ %42, %38 ]
  br label %45

45:                                               ; preds = %43, %32
  %46 = phi i1 [ true, %32 ], [ %44, %43 ]
  br i1 %46, label %47, label %616

47:                                               ; preds = %45
  %48 = load ptr, ptr %3, align 8
  %49 = getelementptr inbounds %struct.tdefl_compressor, ptr %48, i32 0, i32 8
  %50 = load i32, ptr %49, align 4
  %51 = load ptr, ptr %3, align 8
  %52 = getelementptr inbounds %struct.tdefl_compressor, ptr %51, i32 0, i32 9
  %53 = load i32, ptr %52, align 8
  %54 = add i32 %50, %53
  %55 = icmp uge i32 %54, 2
  br i1 %55, label %56, label %179

56:                                               ; preds = %47
  %57 = load ptr, ptr %3, align 8
  %58 = getelementptr inbounds %struct.tdefl_compressor, ptr %57, i32 0, i32 7
  %59 = load i32, ptr %58, align 8
  %60 = load ptr, ptr %3, align 8
  %61 = getelementptr inbounds %struct.tdefl_compressor, ptr %60, i32 0, i32 8
  %62 = load i32, ptr %61, align 4
  %63 = add i32 %59, %62
  %64 = and i32 %63, 32767
  store i32 %64, ptr %11, align 4
  %65 = load ptr, ptr %3, align 8
  %66 = getelementptr inbounds %struct.tdefl_compressor, ptr %65, i32 0, i32 7
  %67 = load i32, ptr %66, align 8
  %68 = load ptr, ptr %3, align 8
  %69 = getelementptr inbounds %struct.tdefl_compressor, ptr %68, i32 0, i32 8
  %70 = load i32, ptr %69, align 4
  %71 = add i32 %67, %70
  %72 = sub i32 %71, 2
  store i32 %72, ptr %12, align 4
  %73 = load ptr, ptr %3, align 8
  %74 = getelementptr inbounds %struct.tdefl_compressor, ptr %73, i32 0, i32 36
  %75 = load i32, ptr %12, align 4
  %76 = and i32 %75, 32767
  %77 = zext i32 %76 to i64
  %78 = getelementptr inbounds [33025 x i8], ptr %74, i64 0, i64 %77
  %79 = load i8, ptr %78, align 1
  %80 = zext i8 %79 to i32
  %81 = shl i32 %80, 5
  %82 = load ptr, ptr %3, align 8
  %83 = getelementptr inbounds %struct.tdefl_compressor, ptr %82, i32 0, i32 36
  %84 = load i32, ptr %12, align 4
  %85 = add i32 %84, 1
  %86 = and i32 %85, 32767
  %87 = zext i32 %86 to i64
  %88 = getelementptr inbounds [33025 x i8], ptr %83, i64 0, i64 %87
  %89 = load i8, ptr %88, align 1
  %90 = zext i8 %89 to i32
  %91 = xor i32 %81, %90
  store i32 %91, ptr %13, align 4
  %92 = load i64, ptr %5, align 8
  %93 = load ptr, ptr %3, align 8
  %94 = getelementptr inbounds %struct.tdefl_compressor, ptr %93, i32 0, i32 8
  %95 = load i32, ptr %94, align 4
  %96 = sub i32 258, %95
  %97 = zext i32 %96 to i64
  %98 = icmp ult i64 %92, %97
  br i1 %98, label %99, label %101

99:                                               ; preds = %56
  %100 = load i64, ptr %5, align 8
  br label %107

101:                                              ; preds = %56
  %102 = load ptr, ptr %3, align 8
  %103 = getelementptr inbounds %struct.tdefl_compressor, ptr %102, i32 0, i32 8
  %104 = load i32, ptr %103, align 4
  %105 = sub i32 258, %104
  %106 = zext i32 %105 to i64
  br label %107

107:                                              ; preds = %101, %99
  %108 = phi i64 [ %100, %99 ], [ %106, %101 ]
  %109 = trunc i64 %108 to i32
  store i32 %109, ptr %14, align 4
  %110 = load ptr, ptr %4, align 8
  %111 = load i32, ptr %14, align 4
  %112 = zext i32 %111 to i64
  %113 = getelementptr inbounds i8, ptr %110, i64 %112
  store ptr %113, ptr %15, align 8
  %114 = load i32, ptr %14, align 4
  %115 = zext i32 %114 to i64
  %116 = load i64, ptr %5, align 8
  %117 = sub i64 %116, %115
  store i64 %117, ptr %5, align 8
  %118 = load i32, ptr %14, align 4
  %119 = load ptr, ptr %3, align 8
  %120 = getelementptr inbounds %struct.tdefl_compressor, ptr %119, i32 0, i32 8
  %121 = load i32, ptr %120, align 4
  %122 = add i32 %121, %118
  store i32 %122, ptr %120, align 4
  br label %123

123:                                              ; preds = %147, %107
  %124 = load ptr, ptr %4, align 8
  %125 = load ptr, ptr %15, align 8
  %126 = icmp ne ptr %124, %125
  br i1 %126, label %127, label %178

127:                                              ; preds = %123
  %128 = load ptr, ptr %4, align 8
  %129 = getelementptr inbounds i8, ptr %128, i32 1
  store ptr %129, ptr %4, align 8
  %130 = load i8, ptr %128, align 1
  store i8 %130, ptr %16, align 1
  %131 = load i8, ptr %16, align 1
  %132 = load ptr, ptr %3, align 8
  %133 = getelementptr inbounds %struct.tdefl_compressor, ptr %132, i32 0, i32 36
  %134 = load i32, ptr %11, align 4
  %135 = zext i32 %134 to i64
  %136 = getelementptr inbounds [33025 x i8], ptr %133, i64 0, i64 %135
  store i8 %131, ptr %136, align 1
  %137 = load i32, ptr %11, align 4
  %138 = icmp ult i32 %137, 257
  br i1 %138, label %139, label %147

139:                                              ; preds = %127
  %140 = load i8, ptr %16, align 1
  %141 = load ptr, ptr %3, align 8
  %142 = getelementptr inbounds %struct.tdefl_compressor, ptr %141, i32 0, i32 36
  %143 = load i32, ptr %11, align 4
  %144 = add i32 32768, %143
  %145 = zext i32 %144 to i64
  %146 = getelementptr inbounds [33025 x i8], ptr %142, i64 0, i64 %145
  store i8 %140, ptr %146, align 1
  br label %147

147:                                              ; preds = %139, %127
  %148 = load i32, ptr %13, align 4
  %149 = shl i32 %148, 5
  %150 = load i8, ptr %16, align 1
  %151 = zext i8 %150 to i32
  %152 = xor i32 %149, %151
  %153 = and i32 %152, 32767
  store i32 %153, ptr %13, align 4
  %154 = load ptr, ptr %3, align 8
  %155 = getelementptr inbounds %struct.tdefl_compressor, ptr %154, i32 0, i32 42
  %156 = load i32, ptr %13, align 4
  %157 = zext i32 %156 to i64
  %158 = getelementptr inbounds [32768 x i32], ptr %155, i64 0, i64 %157
  %159 = load i32, ptr %158, align 2
  %160 = load ptr, ptr %3, align 8
  %161 = getelementptr inbounds %struct.tdefl_compressor, ptr %160, i32 0, i32 41
  %162 = load i32, ptr %12, align 4
  %163 = and i32 %162, 32767
  %164 = zext i32 %163 to i64
  %165 = getelementptr inbounds [32768 x i32], ptr %161, i64 0, i64 %164
  store i32 %159, ptr %165, align 2
  %166 = load i32, ptr %12, align 4
  %167 = add i32 %166, 0
  %168 = load ptr, ptr %3, align 8
  %169 = getelementptr inbounds %struct.tdefl_compressor, ptr %168, i32 0, i32 42
  %170 = load i32, ptr %13, align 4
  %171 = zext i32 %170 to i64
  %172 = getelementptr inbounds [32768 x i32], ptr %169, i64 0, i64 %171
  store i32 %167, ptr %172, align 2
  %173 = load i32, ptr %11, align 4
  %174 = add i32 %173, 1
  %175 = and i32 %174, 32767
  store i32 %175, ptr %11, align 4
  %176 = load i32, ptr %12, align 4
  %177 = add i32 %176, 1
  store i32 %177, ptr %12, align 4
  br label %123, !llvm.loop !68

178:                                              ; preds = %123
  br label %285

179:                                              ; preds = %47
  br label %180

180:                                              ; preds = %283, %179
  %181 = load i64, ptr %5, align 8
  %182 = icmp ne i64 %181, 0
  br i1 %182, label %183, label %188

183:                                              ; preds = %180
  %184 = load ptr, ptr %3, align 8
  %185 = getelementptr inbounds %struct.tdefl_compressor, ptr %184, i32 0, i32 8
  %186 = load i32, ptr %185, align 4
  %187 = icmp ult i32 %186, 258
  br label %188

188:                                              ; preds = %183, %180
  %189 = phi i1 [ false, %180 ], [ %187, %183 ]
  br i1 %189, label %190, label %284

190:                                              ; preds = %188
  %191 = load ptr, ptr %4, align 8
  %192 = getelementptr inbounds i8, ptr %191, i32 1
  store ptr %192, ptr %4, align 8
  %193 = load i8, ptr %191, align 1
  store i8 %193, ptr %17, align 1
  %194 = load ptr, ptr %3, align 8
  %195 = getelementptr inbounds %struct.tdefl_compressor, ptr %194, i32 0, i32 7
  %196 = load i32, ptr %195, align 8
  %197 = load ptr, ptr %3, align 8
  %198 = getelementptr inbounds %struct.tdefl_compressor, ptr %197, i32 0, i32 8
  %199 = load i32, ptr %198, align 4
  %200 = add i32 %196, %199
  %201 = and i32 %200, 32767
  store i32 %201, ptr %18, align 4
  %202 = load i64, ptr %5, align 8
  %203 = add i64 %202, -1
  store i64 %203, ptr %5, align 8
  %204 = load i8, ptr %17, align 1
  %205 = load ptr, ptr %3, align 8
  %206 = getelementptr inbounds %struct.tdefl_compressor, ptr %205, i32 0, i32 36
  %207 = load i32, ptr %18, align 4
  %208 = zext i32 %207 to i64
  %209 = getelementptr inbounds [33025 x i8], ptr %206, i64 0, i64 %208
  store i8 %204, ptr %209, align 1
  %210 = load i32, ptr %18, align 4
  %211 = icmp ult i32 %210, 257
  br i1 %211, label %212, label %220

212:                                              ; preds = %190
  %213 = load i8, ptr %17, align 1
  %214 = load ptr, ptr %3, align 8
  %215 = getelementptr inbounds %struct.tdefl_compressor, ptr %214, i32 0, i32 36
  %216 = load i32, ptr %18, align 4
  %217 = add i32 32768, %216
  %218 = zext i32 %217 to i64
  %219 = getelementptr inbounds [33025 x i8], ptr %215, i64 0, i64 %218
  store i8 %213, ptr %219, align 1
  br label %220

220:                                              ; preds = %212, %190
  %221 = load ptr, ptr %3, align 8
  %222 = getelementptr inbounds %struct.tdefl_compressor, ptr %221, i32 0, i32 8
  %223 = load i32, ptr %222, align 4
  %224 = add i32 %223, 1
  store i32 %224, ptr %222, align 4
  %225 = load ptr, ptr %3, align 8
  %226 = getelementptr inbounds %struct.tdefl_compressor, ptr %225, i32 0, i32 9
  %227 = load i32, ptr %226, align 8
  %228 = add i32 %224, %227
  %229 = icmp uge i32 %228, 3
  br i1 %229, label %230, label %283

230:                                              ; preds = %220
  %231 = load ptr, ptr %3, align 8
  %232 = getelementptr inbounds %struct.tdefl_compressor, ptr %231, i32 0, i32 7
  %233 = load i32, ptr %232, align 8
  %234 = load ptr, ptr %3, align 8
  %235 = getelementptr inbounds %struct.tdefl_compressor, ptr %234, i32 0, i32 8
  %236 = load i32, ptr %235, align 4
  %237 = sub i32 %236, 1
  %238 = add i32 %233, %237
  %239 = sub i32 %238, 2
  store i32 %239, ptr %19, align 4
  %240 = load ptr, ptr %3, align 8
  %241 = getelementptr inbounds %struct.tdefl_compressor, ptr %240, i32 0, i32 36
  %242 = load i32, ptr %19, align 4
  %243 = and i32 %242, 32767
  %244 = zext i32 %243 to i64
  %245 = getelementptr inbounds [33025 x i8], ptr %241, i64 0, i64 %244
  %246 = load i8, ptr %245, align 1
  %247 = zext i8 %246 to i32
  %248 = shl i32 %247, 10
  %249 = load ptr, ptr %3, align 8
  %250 = getelementptr inbounds %struct.tdefl_compressor, ptr %249, i32 0, i32 36
  %251 = load i32, ptr %19, align 4
  %252 = add i32 %251, 1
  %253 = and i32 %252, 32767
  %254 = zext i32 %253 to i64
  %255 = getelementptr inbounds [33025 x i8], ptr %250, i64 0, i64 %254
  %256 = load i8, ptr %255, align 1
  %257 = zext i8 %256 to i32
  %258 = shl i32 %257, 5
  %259 = xor i32 %248, %258
  %260 = load i8, ptr %17, align 1
  %261 = zext i8 %260 to i32
  %262 = xor i32 %259, %261
  %263 = and i32 %262, 32767
  store i32 %263, ptr %20, align 4
  %264 = load ptr, ptr %3, align 8
  %265 = getelementptr inbounds %struct.tdefl_compressor, ptr %264, i32 0, i32 42
  %266 = load i32, ptr %20, align 4
  %267 = zext i32 %266 to i64
  %268 = getelementptr inbounds [32768 x i32], ptr %265, i64 0, i64 %267
  %269 = load i32, ptr %268, align 2
  %270 = load ptr, ptr %3, align 8
  %271 = getelementptr inbounds %struct.tdefl_compressor, ptr %270, i32 0, i32 41
  %272 = load i32, ptr %19, align 4
  %273 = and i32 %272, 32767
  %274 = zext i32 %273 to i64
  %275 = getelementptr inbounds [32768 x i32], ptr %271, i64 0, i64 %274
  store i32 %269, ptr %275, align 2
  %276 = load i32, ptr %19, align 4
  %277 = add i32 %276, 0
  %278 = load ptr, ptr %3, align 8
  %279 = getelementptr inbounds %struct.tdefl_compressor, ptr %278, i32 0, i32 42
  %280 = load i32, ptr %20, align 4
  %281 = zext i32 %280 to i64
  %282 = getelementptr inbounds [32768 x i32], ptr %279, i64 0, i64 %281
  store i32 %277, ptr %282, align 2
  br label %283

283:                                              ; preds = %230, %220
  br label %180, !llvm.loop !69

284:                                              ; preds = %188
  br label %285

285:                                              ; preds = %284, %178
  %286 = load ptr, ptr %3, align 8
  %287 = getelementptr inbounds %struct.tdefl_compressor, ptr %286, i32 0, i32 8
  %288 = load i32, ptr %287, align 4
  %289 = sub i32 32768, %288
  %290 = load ptr, ptr %3, align 8
  %291 = getelementptr inbounds %struct.tdefl_compressor, ptr %290, i32 0, i32 9
  %292 = load i32, ptr %291, align 8
  %293 = icmp ult i32 %289, %292
  br i1 %293, label %294, label %299

294:                                              ; preds = %285
  %295 = load ptr, ptr %3, align 8
  %296 = getelementptr inbounds %struct.tdefl_compressor, ptr %295, i32 0, i32 8
  %297 = load i32, ptr %296, align 4
  %298 = sub i32 32768, %297
  br label %303

299:                                              ; preds = %285
  %300 = load ptr, ptr %3, align 8
  %301 = getelementptr inbounds %struct.tdefl_compressor, ptr %300, i32 0, i32 9
  %302 = load i32, ptr %301, align 8
  br label %303

303:                                              ; preds = %299, %294
  %304 = phi i32 [ %298, %294 ], [ %302, %299 ]
  %305 = load ptr, ptr %3, align 8
  %306 = getelementptr inbounds %struct.tdefl_compressor, ptr %305, i32 0, i32 9
  store i32 %304, ptr %306, align 8
  %307 = load i32, ptr %6, align 4
  %308 = icmp ne i32 %307, 0
  br i1 %308, label %315, label %309

309:                                              ; preds = %303
  %310 = load ptr, ptr %3, align 8
  %311 = getelementptr inbounds %struct.tdefl_compressor, ptr %310, i32 0, i32 8
  %312 = load i32, ptr %311, align 4
  %313 = icmp ult i32 %312, 258
  br i1 %313, label %314, label %315

314:                                              ; preds = %309
  br label %616

315:                                              ; preds = %309, %303
  store i32 1, ptr %7, align 4
  store i32 0, ptr %8, align 4
  %316 = load ptr, ptr %3, align 8
  %317 = getelementptr inbounds %struct.tdefl_compressor, ptr %316, i32 0, i32 20
  %318 = load i32, ptr %317, align 8
  %319 = icmp ne i32 %318, 0
  br i1 %319, label %320, label %324

320:                                              ; preds = %315
  %321 = load ptr, ptr %3, align 8
  %322 = getelementptr inbounds %struct.tdefl_compressor, ptr %321, i32 0, i32 20
  %323 = load i32, ptr %322, align 8
  br label %325

324:                                              ; preds = %315
  br label %325

325:                                              ; preds = %324, %320
  %326 = phi i32 [ %323, %320 ], [ 2, %324 ]
  store i32 %326, ptr %9, align 4
  %327 = load ptr, ptr %3, align 8
  %328 = getelementptr inbounds %struct.tdefl_compressor, ptr %327, i32 0, i32 7
  %329 = load i32, ptr %328, align 8
  %330 = and i32 %329, 32767
  store i32 %330, ptr %10, align 4
  %331 = load ptr, ptr %3, align 8
  %332 = getelementptr inbounds %struct.tdefl_compressor, ptr %331, i32 0, i32 2
  %333 = load i32, ptr %332, align 8
  %334 = and i32 %333, 1179648
  %335 = icmp ne i32 %334, 0
  br i1 %335, label %336, label %386

336:                                              ; preds = %325
  %337 = load ptr, ptr %3, align 8
  %338 = getelementptr inbounds %struct.tdefl_compressor, ptr %337, i32 0, i32 9
  %339 = load i32, ptr %338, align 8
  %340 = icmp ne i32 %339, 0
  br i1 %340, label %341, label %385

341:                                              ; preds = %336
  %342 = load ptr, ptr %3, align 8
  %343 = getelementptr inbounds %struct.tdefl_compressor, ptr %342, i32 0, i32 2
  %344 = load i32, ptr %343, align 8
  %345 = and i32 %344, 1048576
  %346 = icmp ne i32 %345, 0
  br i1 %346, label %385, label %347

347:                                              ; preds = %341
  %348 = load ptr, ptr %3, align 8
  %349 = getelementptr inbounds %struct.tdefl_compressor, ptr %348, i32 0, i32 36
  %350 = load i32, ptr %10, align 4
  %351 = sub i32 %350, 1
  %352 = and i32 %351, 32767
  %353 = zext i32 %352 to i64
  %354 = getelementptr inbounds [33025 x i8], ptr %349, i64 0, i64 %353
  %355 = load i8, ptr %354, align 1
  store i8 %355, ptr %21, align 1
  store i32 0, ptr %9, align 4
  br label %356

356:                                              ; preds = %376, %347
  %357 = load i32, ptr %9, align 4
  %358 = load ptr, ptr %3, align 8
  %359 = getelementptr inbounds %struct.tdefl_compressor, ptr %358, i32 0, i32 8
  %360 = load i32, ptr %359, align 4
  %361 = icmp ult i32 %357, %360
  br i1 %361, label %362, label %379

362:                                              ; preds = %356
  %363 = load ptr, ptr %3, align 8
  %364 = getelementptr inbounds %struct.tdefl_compressor, ptr %363, i32 0, i32 36
  %365 = load i32, ptr %10, align 4
  %366 = load i32, ptr %9, align 4
  %367 = add i32 %365, %366
  %368 = zext i32 %367 to i64
  %369 = getelementptr inbounds [33025 x i8], ptr %364, i64 0, i64 %368
  %370 = load i8, ptr %369, align 1
  %371 = zext i8 %370 to i32
  %372 = load i8, ptr %21, align 1
  %373 = zext i8 %372 to i32
  %374 = icmp ne i32 %371, %373
  br i1 %374, label %375, label %376

375:                                              ; preds = %362
  br label %379

376:                                              ; preds = %362
  %377 = load i32, ptr %9, align 4
  %378 = add i32 %377, 1
  store i32 %378, ptr %9, align 4
  br label %356, !llvm.loop !70

379:                                              ; preds = %375, %356
  %380 = load i32, ptr %9, align 4
  %381 = icmp ult i32 %380, 3
  br i1 %381, label %382, label %383

382:                                              ; preds = %379
  store i32 0, ptr %9, align 4
  br label %384

383:                                              ; preds = %379
  store i32 1, ptr %8, align 4
  br label %384

384:                                              ; preds = %383, %382
  br label %385

385:                                              ; preds = %384, %341, %336
  br label %397

386:                                              ; preds = %325
  %387 = load ptr, ptr %3, align 8
  %388 = load ptr, ptr %3, align 8
  %389 = getelementptr inbounds %struct.tdefl_compressor, ptr %388, i32 0, i32 7
  %390 = load i32, ptr %389, align 8
  %391 = load ptr, ptr %3, align 8
  %392 = getelementptr inbounds %struct.tdefl_compressor, ptr %391, i32 0, i32 9
  %393 = load i32, ptr %392, align 8
  %394 = load ptr, ptr %3, align 8
  %395 = getelementptr inbounds %struct.tdefl_compressor, ptr %394, i32 0, i32 8
  %396 = load i32, ptr %395, align 4
  call void @tdefl_find_match(ptr noundef %387, i32 noundef %390, i32 noundef %393, i32 noundef %396, ptr noundef %8, ptr noundef %9)
  br label %397

397:                                              ; preds = %386, %385
  %398 = load i32, ptr %9, align 4
  %399 = icmp eq i32 %398, 3
  br i1 %399, label %400, label %403

400:                                              ; preds = %397
  %401 = load i32, ptr %8, align 4
  %402 = icmp uge i32 %401, 8192
  br i1 %402, label %416, label %403

403:                                              ; preds = %400, %397
  %404 = load i32, ptr %10, align 4
  %405 = load i32, ptr %8, align 4
  %406 = icmp eq i32 %404, %405
  br i1 %406, label %416, label %407

407:                                              ; preds = %403
  %408 = load ptr, ptr %3, align 8
  %409 = getelementptr inbounds %struct.tdefl_compressor, ptr %408, i32 0, i32 2
  %410 = load i32, ptr %409, align 8
  %411 = and i32 %410, 262144
  %412 = icmp ne i32 %411, 0
  br i1 %412, label %413, label %417

413:                                              ; preds = %407
  %414 = load i32, ptr %9, align 4
  %415 = icmp ule i32 %414, 5
  br i1 %415, label %416, label %417

416:                                              ; preds = %413, %403, %400
  store i32 0, ptr %9, align 4
  store i32 0, ptr %8, align 4
  br label %417

417:                                              ; preds = %416, %413, %407
  %418 = load ptr, ptr %3, align 8
  %419 = getelementptr inbounds %struct.tdefl_compressor, ptr %418, i32 0, i32 20
  %420 = load i32, ptr %419, align 8
  %421 = icmp ne i32 %420, 0
  br i1 %421, label %422, label %475

422:                                              ; preds = %417
  %423 = load i32, ptr %9, align 4
  %424 = load ptr, ptr %3, align 8
  %425 = getelementptr inbounds %struct.tdefl_compressor, ptr %424, i32 0, i32 20
  %426 = load i32, ptr %425, align 8
  %427 = icmp ugt i32 %423, %426
  br i1 %427, label %428, label %460

428:                                              ; preds = %422
  %429 = load ptr, ptr %3, align 8
  %430 = load ptr, ptr %3, align 8
  %431 = getelementptr inbounds %struct.tdefl_compressor, ptr %430, i32 0, i32 21
  %432 = load i32, ptr %431, align 4
  %433 = trunc i32 %432 to i8
  call void @tdefl_record_literal(ptr noundef %429, i8 noundef zeroext %433)
  %434 = load i32, ptr %9, align 4
  %435 = icmp uge i32 %434, 128
  br i1 %435, label %436, label %443

436:                                              ; preds = %428
  %437 = load ptr, ptr %3, align 8
  %438 = load i32, ptr %9, align 4
  %439 = load i32, ptr %8, align 4
  call void @tdefl_record_match(ptr noundef %437, i32 noundef %438, i32 noundef %439)
  %440 = load ptr, ptr %3, align 8
  %441 = getelementptr inbounds %struct.tdefl_compressor, ptr %440, i32 0, i32 20
  store i32 0, ptr %441, align 8
  %442 = load i32, ptr %9, align 4
  store i32 %442, ptr %7, align 4
  br label %459

443:                                              ; preds = %428
  %444 = load ptr, ptr %3, align 8
  %445 = getelementptr inbounds %struct.tdefl_compressor, ptr %444, i32 0, i32 36
  %446 = load i32, ptr %10, align 4
  %447 = zext i32 %446 to i64
  %448 = getelementptr inbounds [33025 x i8], ptr %445, i64 0, i64 %447
  %449 = load i8, ptr %448, align 1
  %450 = zext i8 %449 to i32
  %451 = load ptr, ptr %3, align 8
  %452 = getelementptr inbounds %struct.tdefl_compressor, ptr %451, i32 0, i32 21
  store i32 %450, ptr %452, align 4
  %453 = load i32, ptr %8, align 4
  %454 = load ptr, ptr %3, align 8
  %455 = getelementptr inbounds %struct.tdefl_compressor, ptr %454, i32 0, i32 19
  store i32 %453, ptr %455, align 4
  %456 = load i32, ptr %9, align 4
  %457 = load ptr, ptr %3, align 8
  %458 = getelementptr inbounds %struct.tdefl_compressor, ptr %457, i32 0, i32 20
  store i32 %456, ptr %458, align 8
  br label %459

459:                                              ; preds = %443, %436
  br label %474

460:                                              ; preds = %422
  %461 = load ptr, ptr %3, align 8
  %462 = load ptr, ptr %3, align 8
  %463 = getelementptr inbounds %struct.tdefl_compressor, ptr %462, i32 0, i32 20
  %464 = load i32, ptr %463, align 8
  %465 = load ptr, ptr %3, align 8
  %466 = getelementptr inbounds %struct.tdefl_compressor, ptr %465, i32 0, i32 19
  %467 = load i32, ptr %466, align 4
  call void @tdefl_record_match(ptr noundef %461, i32 noundef %464, i32 noundef %467)
  %468 = load ptr, ptr %3, align 8
  %469 = getelementptr inbounds %struct.tdefl_compressor, ptr %468, i32 0, i32 20
  %470 = load i32, ptr %469, align 8
  %471 = sub i32 %470, 1
  store i32 %471, ptr %7, align 4
  %472 = load ptr, ptr %3, align 8
  %473 = getelementptr inbounds %struct.tdefl_compressor, ptr %472, i32 0, i32 20
  store i32 0, ptr %473, align 8
  br label %474

474:                                              ; preds = %460, %459
  br label %523

475:                                              ; preds = %417
  %476 = load i32, ptr %8, align 4
  %477 = icmp ne i32 %476, 0
  br i1 %477, label %486, label %478

478:                                              ; preds = %475
  %479 = load ptr, ptr %3, align 8
  %480 = load ptr, ptr %3, align 8
  %481 = getelementptr inbounds %struct.tdefl_compressor, ptr %480, i32 0, i32 36
  %482 = load i32, ptr %10, align 4
  %483 = zext i32 %482 to i64
  %484 = getelementptr inbounds [33025 x i8], ptr %481, i64 0, i64 %483
  %485 = load i8, ptr %484, align 1
  call void @tdefl_record_literal(ptr noundef %479, i8 noundef zeroext %485)
  br label %522

486:                                              ; preds = %475
  %487 = load ptr, ptr %3, align 8
  %488 = getelementptr inbounds %struct.tdefl_compressor, ptr %487, i32 0, i32 4
  %489 = load i32, ptr %488, align 4
  %490 = icmp ne i32 %489, 0
  br i1 %490, label %500, label %491

491:                                              ; preds = %486
  %492 = load ptr, ptr %3, align 8
  %493 = getelementptr inbounds %struct.tdefl_compressor, ptr %492, i32 0, i32 2
  %494 = load i32, ptr %493, align 8
  %495 = and i32 %494, 131072
  %496 = icmp ne i32 %495, 0
  br i1 %496, label %500, label %497

497:                                              ; preds = %491
  %498 = load i32, ptr %9, align 4
  %499 = icmp uge i32 %498, 128
  br i1 %499, label %500, label %505

500:                                              ; preds = %497, %491, %486
  %501 = load ptr, ptr %3, align 8
  %502 = load i32, ptr %9, align 4
  %503 = load i32, ptr %8, align 4
  call void @tdefl_record_match(ptr noundef %501, i32 noundef %502, i32 noundef %503)
  %504 = load i32, ptr %9, align 4
  store i32 %504, ptr %7, align 4
  br label %521

505:                                              ; preds = %497
  %506 = load ptr, ptr %3, align 8
  %507 = getelementptr inbounds %struct.tdefl_compressor, ptr %506, i32 0, i32 36
  %508 = load i32, ptr %10, align 4
  %509 = zext i32 %508 to i64
  %510 = getelementptr inbounds [33025 x i8], ptr %507, i64 0, i64 %509
  %511 = load i8, ptr %510, align 1
  %512 = zext i8 %511 to i32
  %513 = load ptr, ptr %3, align 8
  %514 = getelementptr inbounds %struct.tdefl_compressor, ptr %513, i32 0, i32 21
  store i32 %512, ptr %514, align 4
  %515 = load i32, ptr %8, align 4
  %516 = load ptr, ptr %3, align 8
  %517 = getelementptr inbounds %struct.tdefl_compressor, ptr %516, i32 0, i32 19
  store i32 %515, ptr %517, align 4
  %518 = load i32, ptr %9, align 4
  %519 = load ptr, ptr %3, align 8
  %520 = getelementptr inbounds %struct.tdefl_compressor, ptr %519, i32 0, i32 20
  store i32 %518, ptr %520, align 8
  br label %521

521:                                              ; preds = %505, %500
  br label %522

522:                                              ; preds = %521, %478
  br label %523

523:                                              ; preds = %522, %474
  %524 = load i32, ptr %7, align 4
  %525 = load ptr, ptr %3, align 8
  %526 = getelementptr inbounds %struct.tdefl_compressor, ptr %525, i32 0, i32 7
  %527 = load i32, ptr %526, align 8
  %528 = add i32 %527, %524
  store i32 %528, ptr %526, align 8
  %529 = load ptr, ptr %3, align 8
  %530 = getelementptr inbounds %struct.tdefl_compressor, ptr %529, i32 0, i32 8
  %531 = load i32, ptr %530, align 4
  %532 = load i32, ptr %7, align 4
  %533 = icmp uge i32 %531, %532
  %534 = xor i1 %533, true
  %535 = zext i1 %534 to i32
  %536 = sext i32 %535 to i64
  %537 = icmp ne i64 %536, 0
  br i1 %537, label %538, label %540

538:                                              ; preds = %523
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_normal, ptr noundef @.str.14, i32 noundef 2253, ptr noundef @.str.34) #14
  unreachable

539:                                              ; No predecessors!
  br label %541

540:                                              ; preds = %523
  br label %541

541:                                              ; preds = %540, %539
  %542 = load i32, ptr %7, align 4
  %543 = load ptr, ptr %3, align 8
  %544 = getelementptr inbounds %struct.tdefl_compressor, ptr %543, i32 0, i32 8
  %545 = load i32, ptr %544, align 4
  %546 = sub i32 %545, %542
  store i32 %546, ptr %544, align 4
  %547 = load ptr, ptr %3, align 8
  %548 = getelementptr inbounds %struct.tdefl_compressor, ptr %547, i32 0, i32 9
  %549 = load i32, ptr %548, align 8
  %550 = load i32, ptr %7, align 4
  %551 = add i32 %549, %550
  %552 = icmp ult i32 %551, 32768
  br i1 %552, label %553, label %559

553:                                              ; preds = %541
  %554 = load ptr, ptr %3, align 8
  %555 = getelementptr inbounds %struct.tdefl_compressor, ptr %554, i32 0, i32 9
  %556 = load i32, ptr %555, align 8
  %557 = load i32, ptr %7, align 4
  %558 = add i32 %556, %557
  br label %560

559:                                              ; preds = %541
  br label %560

560:                                              ; preds = %559, %553
  %561 = phi i32 [ %558, %553 ], [ 32768, %559 ]
  %562 = load ptr, ptr %3, align 8
  %563 = getelementptr inbounds %struct.tdefl_compressor, ptr %562, i32 0, i32 9
  store i32 %561, ptr %563, align 8
  %564 = load ptr, ptr %3, align 8
  %565 = getelementptr inbounds %struct.tdefl_compressor, ptr %564, i32 0, i32 10
  %566 = load ptr, ptr %565, align 8
  %567 = load ptr, ptr %3, align 8
  %568 = getelementptr inbounds %struct.tdefl_compressor, ptr %567, i32 0, i32 40
  %569 = getelementptr inbounds [65536 x i8], ptr %568, i64 0, i64 65528
  %570 = icmp ugt ptr %566, %569
  br i1 %570, label %599, label %571

571:                                              ; preds = %560
  %572 = load ptr, ptr %3, align 8
  %573 = getelementptr inbounds %struct.tdefl_compressor, ptr %572, i32 0, i32 15
  %574 = load i32, ptr %573, align 4
  %575 = icmp ugt i32 %574, 31744
  br i1 %575, label %576, label %615

576:                                              ; preds = %571
  %577 = load ptr, ptr %3, align 8
  %578 = getelementptr inbounds %struct.tdefl_compressor, ptr %577, i32 0, i32 10
  %579 = load ptr, ptr %578, align 8
  %580 = load ptr, ptr %3, align 8
  %581 = getelementptr inbounds %struct.tdefl_compressor, ptr %580, i32 0, i32 40
  %582 = getelementptr inbounds [65536 x i8], ptr %581, i64 0, i64 0
  %583 = ptrtoint ptr %579 to i64
  %584 = ptrtoint ptr %582 to i64
  %585 = sub i64 %583, %584
  %586 = trunc i64 %585 to i32
  %587 = mul i32 %586, 115
  %588 = lshr i32 %587, 7
  %589 = load ptr, ptr %3, align 8
  %590 = getelementptr inbounds %struct.tdefl_compressor, ptr %589, i32 0, i32 15
  %591 = load i32, ptr %590, align 4
  %592 = icmp uge i32 %588, %591
  br i1 %592, label %599, label %593

593:                                              ; preds = %576
  %594 = load ptr, ptr %3, align 8
  %595 = getelementptr inbounds %struct.tdefl_compressor, ptr %594, i32 0, i32 2
  %596 = load i32, ptr %595, align 8
  %597 = and i32 %596, 1048576
  %598 = icmp ne i32 %597, 0
  br i1 %598, label %599, label %615

599:                                              ; preds = %593, %576, %560
  %600 = load ptr, ptr %4, align 8
  %601 = load ptr, ptr %3, align 8
  %602 = getelementptr inbounds %struct.tdefl_compressor, ptr %601, i32 0, i32 33
  store ptr %600, ptr %602, align 8
  %603 = load i64, ptr %5, align 8
  %604 = load ptr, ptr %3, align 8
  %605 = getelementptr inbounds %struct.tdefl_compressor, ptr %604, i32 0, i32 34
  store i64 %603, ptr %605, align 8
  %606 = load ptr, ptr %3, align 8
  %607 = call i32 @tdefl_flush_block(ptr noundef %606, i32 noundef 0)
  store i32 %607, ptr %22, align 4
  %608 = icmp ne i32 %607, 0
  br i1 %608, label %609, label %614

609:                                              ; preds = %599
  %610 = load i32, ptr %22, align 4
  %611 = icmp slt i32 %610, 0
  %612 = zext i1 %611 to i64
  %613 = select i1 %611, i32 0, i32 1
  store i32 %613, ptr %2, align 4
  br label %623

614:                                              ; preds = %599
  br label %615

615:                                              ; preds = %614, %593, %571
  br label %32, !llvm.loop !71

616:                                              ; preds = %314, %45
  %617 = load ptr, ptr %4, align 8
  %618 = load ptr, ptr %3, align 8
  %619 = getelementptr inbounds %struct.tdefl_compressor, ptr %618, i32 0, i32 33
  store ptr %617, ptr %619, align 8
  %620 = load i64, ptr %5, align 8
  %621 = load ptr, ptr %3, align 8
  %622 = getelementptr inbounds %struct.tdefl_compressor, ptr %621, i32 0, i32 34
  store i64 %620, ptr %622, align 8
  store i32 1, ptr %2, align 4
  br label %623

623:                                              ; preds = %616, %609
  %624 = load i32, ptr %2, align 4
  ret i32 %624
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_flush_block(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  %32 = alloca i32, align 4
  %33 = alloca i32, align 4
  %34 = alloca i32, align 4
  %35 = alloca i32, align 4
  %36 = alloca i32, align 4
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca i32, align 4
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 0, ptr %9, align 4
  %43 = load ptr, ptr %4, align 8
  %44 = getelementptr inbounds %struct.tdefl_compressor, ptr %43, i32 0, i32 2
  %45 = load i32, ptr %44, align 8
  %46 = and i32 %45, 1048576
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %60

48:                                               ; preds = %2
  %49 = load ptr, ptr %4, align 8
  %50 = getelementptr inbounds %struct.tdefl_compressor, ptr %49, i32 0, i32 7
  %51 = load i32, ptr %50, align 8
  %52 = load ptr, ptr %4, align 8
  %53 = getelementptr inbounds %struct.tdefl_compressor, ptr %52, i32 0, i32 16
  %54 = load i32, ptr %53, align 8
  %55 = sub i32 %51, %54
  %56 = load ptr, ptr %4, align 8
  %57 = getelementptr inbounds %struct.tdefl_compressor, ptr %56, i32 0, i32 9
  %58 = load i32, ptr %57, align 8
  %59 = icmp ule i32 %55, %58
  br label %60

60:                                               ; preds = %48, %2
  %61 = phi i1 [ false, %2 ], [ %59, %48 ]
  %62 = zext i1 %61 to i32
  store i32 %62, ptr %11, align 4
  %63 = load ptr, ptr %4, align 8
  %64 = getelementptr inbounds %struct.tdefl_compressor, ptr %63, i32 0, i32 0
  %65 = load ptr, ptr %64, align 8
  %66 = icmp eq ptr %65, null
  br i1 %66, label %67, label %85

67:                                               ; preds = %60
  %68 = load ptr, ptr %4, align 8
  %69 = getelementptr inbounds %struct.tdefl_compressor, ptr %68, i32 0, i32 31
  %70 = load ptr, ptr %69, align 8
  %71 = load i64, ptr %70, align 8
  %72 = load ptr, ptr %4, align 8
  %73 = getelementptr inbounds %struct.tdefl_compressor, ptr %72, i32 0, i32 35
  %74 = load i64, ptr %73, align 8
  %75 = sub i64 %71, %74
  %76 = icmp uge i64 %75, 85196
  br i1 %76, label %77, label %85

77:                                               ; preds = %67
  %78 = load ptr, ptr %4, align 8
  %79 = getelementptr inbounds %struct.tdefl_compressor, ptr %78, i32 0, i32 29
  %80 = load ptr, ptr %79, align 8
  %81 = load ptr, ptr %4, align 8
  %82 = getelementptr inbounds %struct.tdefl_compressor, ptr %81, i32 0, i32 35
  %83 = load i64, ptr %82, align 8
  %84 = getelementptr inbounds i8, ptr %80, i64 %83
  br label %89

85:                                               ; preds = %67, %60
  %86 = load ptr, ptr %4, align 8
  %87 = getelementptr inbounds %struct.tdefl_compressor, ptr %86, i32 0, i32 43
  %88 = getelementptr inbounds [85196 x i8], ptr %87, i64 0, i64 0
  br label %89

89:                                               ; preds = %85, %77
  %90 = phi ptr [ %84, %77 ], [ %88, %85 ]
  store ptr %90, ptr %12, align 8
  %91 = load ptr, ptr %12, align 8
  %92 = load ptr, ptr %4, align 8
  %93 = getelementptr inbounds %struct.tdefl_compressor, ptr %92, i32 0, i32 12
  store ptr %91, ptr %93, align 8
  %94 = load ptr, ptr %4, align 8
  %95 = getelementptr inbounds %struct.tdefl_compressor, ptr %94, i32 0, i32 12
  %96 = load ptr, ptr %95, align 8
  %97 = getelementptr inbounds i8, ptr %96, i64 85196
  %98 = getelementptr inbounds i8, ptr %97, i64 -16
  %99 = load ptr, ptr %4, align 8
  %100 = getelementptr inbounds %struct.tdefl_compressor, ptr %99, i32 0, i32 13
  store ptr %98, ptr %100, align 8
  %101 = load ptr, ptr %4, align 8
  %102 = getelementptr inbounds %struct.tdefl_compressor, ptr %101, i32 0, i32 23
  %103 = load i32, ptr %102, align 4
  %104 = icmp ne i32 %103, 0
  %105 = xor i1 %104, true
  %106 = xor i1 %105, true
  %107 = zext i1 %106 to i32
  %108 = sext i32 %107 to i64
  %109 = icmp ne i64 %108, 0
  br i1 %109, label %110, label %112

110:                                              ; preds = %89
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1828, ptr noundef @.str.37) #14
  unreachable

111:                                              ; No predecessors!
  br label %113

112:                                              ; preds = %89
  br label %113

113:                                              ; preds = %112, %111
  %114 = load ptr, ptr %4, align 8
  %115 = getelementptr inbounds %struct.tdefl_compressor, ptr %114, i32 0, i32 22
  store i32 0, ptr %115, align 8
  %116 = load ptr, ptr %4, align 8
  %117 = getelementptr inbounds %struct.tdefl_compressor, ptr %116, i32 0, i32 23
  store i32 0, ptr %117, align 4
  %118 = load ptr, ptr %4, align 8
  %119 = getelementptr inbounds %struct.tdefl_compressor, ptr %118, i32 0, i32 11
  %120 = load ptr, ptr %119, align 8
  %121 = load i8, ptr %120, align 1
  %122 = zext i8 %121 to i32
  %123 = load ptr, ptr %4, align 8
  %124 = getelementptr inbounds %struct.tdefl_compressor, ptr %123, i32 0, i32 14
  %125 = load i32, ptr %124, align 8
  %126 = ashr i32 %122, %125
  %127 = trunc i32 %126 to i8
  %128 = load ptr, ptr %4, align 8
  %129 = getelementptr inbounds %struct.tdefl_compressor, ptr %128, i32 0, i32 11
  %130 = load ptr, ptr %129, align 8
  store i8 %127, ptr %130, align 1
  %131 = load ptr, ptr %4, align 8
  %132 = getelementptr inbounds %struct.tdefl_compressor, ptr %131, i32 0, i32 14
  %133 = load i32, ptr %132, align 8
  %134 = icmp eq i32 %133, 8
  %135 = zext i1 %134 to i32
  %136 = load ptr, ptr %4, align 8
  %137 = getelementptr inbounds %struct.tdefl_compressor, ptr %136, i32 0, i32 10
  %138 = load ptr, ptr %137, align 8
  %139 = sext i32 %135 to i64
  %140 = sub i64 0, %139
  %141 = getelementptr inbounds i8, ptr %138, i64 %140
  store ptr %141, ptr %137, align 8
  %142 = load ptr, ptr %4, align 8
  %143 = getelementptr inbounds %struct.tdefl_compressor, ptr %142, i32 0, i32 2
  %144 = load i32, ptr %143, align 8
  %145 = and i32 %144, 4096
  %146 = icmp ne i32 %145, 0
  br i1 %146, label %147, label %275

147:                                              ; preds = %113
  %148 = load ptr, ptr %4, align 8
  %149 = getelementptr inbounds %struct.tdefl_compressor, ptr %148, i32 0, i32 25
  %150 = load i32, ptr %149, align 4
  %151 = icmp ne i32 %150, 0
  br i1 %151, label %275, label %152

152:                                              ; preds = %147
  br label %153

153:                                              ; preds = %152
  store i32 120, ptr %13, align 4
  store i32 8, ptr %14, align 4
  %154 = load i32, ptr %13, align 4
  %155 = load i32, ptr %14, align 4
  %156 = shl i32 1, %155
  %157 = sub i32 %156, 1
  %158 = icmp ule i32 %154, %157
  %159 = xor i1 %158, true
  %160 = zext i1 %159 to i32
  %161 = sext i32 %160 to i64
  %162 = icmp ne i64 %161, 0
  br i1 %162, label %163, label %165

163:                                              ; preds = %153
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1837, ptr noundef @.str.38) #14
  unreachable

164:                                              ; No predecessors!
  br label %166

165:                                              ; preds = %153
  br label %166

166:                                              ; preds = %165, %164
  %167 = load i32, ptr %13, align 4
  %168 = load ptr, ptr %4, align 8
  %169 = getelementptr inbounds %struct.tdefl_compressor, ptr %168, i32 0, i32 17
  %170 = load i32, ptr %169, align 4
  %171 = shl i32 %167, %170
  %172 = load ptr, ptr %4, align 8
  %173 = getelementptr inbounds %struct.tdefl_compressor, ptr %172, i32 0, i32 18
  %174 = load i32, ptr %173, align 8
  %175 = or i32 %174, %171
  store i32 %175, ptr %173, align 8
  %176 = load i32, ptr %14, align 4
  %177 = load ptr, ptr %4, align 8
  %178 = getelementptr inbounds %struct.tdefl_compressor, ptr %177, i32 0, i32 17
  %179 = load i32, ptr %178, align 4
  %180 = add i32 %179, %176
  store i32 %180, ptr %178, align 4
  br label %181

181:                                              ; preds = %203, %166
  %182 = load ptr, ptr %4, align 8
  %183 = getelementptr inbounds %struct.tdefl_compressor, ptr %182, i32 0, i32 17
  %184 = load i32, ptr %183, align 4
  %185 = icmp uge i32 %184, 8
  br i1 %185, label %186, label %212

186:                                              ; preds = %181
  %187 = load ptr, ptr %4, align 8
  %188 = getelementptr inbounds %struct.tdefl_compressor, ptr %187, i32 0, i32 12
  %189 = load ptr, ptr %188, align 8
  %190 = load ptr, ptr %4, align 8
  %191 = getelementptr inbounds %struct.tdefl_compressor, ptr %190, i32 0, i32 13
  %192 = load ptr, ptr %191, align 8
  %193 = icmp ult ptr %189, %192
  br i1 %193, label %194, label %203

194:                                              ; preds = %186
  %195 = load ptr, ptr %4, align 8
  %196 = getelementptr inbounds %struct.tdefl_compressor, ptr %195, i32 0, i32 18
  %197 = load i32, ptr %196, align 8
  %198 = trunc i32 %197 to i8
  %199 = load ptr, ptr %4, align 8
  %200 = getelementptr inbounds %struct.tdefl_compressor, ptr %199, i32 0, i32 12
  %201 = load ptr, ptr %200, align 8
  %202 = getelementptr inbounds i8, ptr %201, i32 1
  store ptr %202, ptr %200, align 8
  store i8 %198, ptr %201, align 1
  br label %203

203:                                              ; preds = %194, %186
  %204 = load ptr, ptr %4, align 8
  %205 = getelementptr inbounds %struct.tdefl_compressor, ptr %204, i32 0, i32 18
  %206 = load i32, ptr %205, align 8
  %207 = lshr i32 %206, 8
  store i32 %207, ptr %205, align 8
  %208 = load ptr, ptr %4, align 8
  %209 = getelementptr inbounds %struct.tdefl_compressor, ptr %208, i32 0, i32 17
  %210 = load i32, ptr %209, align 4
  %211 = sub i32 %210, 8
  store i32 %211, ptr %209, align 4
  br label %181, !llvm.loop !72

212:                                              ; preds = %181
  br label %213

213:                                              ; preds = %212
  br label %214

214:                                              ; preds = %213
  store i32 1, ptr %15, align 4
  store i32 8, ptr %16, align 4
  %215 = load i32, ptr %15, align 4
  %216 = load i32, ptr %16, align 4
  %217 = shl i32 1, %216
  %218 = sub i32 %217, 1
  %219 = icmp ule i32 %215, %218
  %220 = xor i1 %219, true
  %221 = zext i1 %220 to i32
  %222 = sext i32 %221 to i64
  %223 = icmp ne i64 %222, 0
  br i1 %223, label %224, label %226

224:                                              ; preds = %214
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1837, ptr noundef @.str.38) #14
  unreachable

225:                                              ; No predecessors!
  br label %227

226:                                              ; preds = %214
  br label %227

227:                                              ; preds = %226, %225
  %228 = load i32, ptr %15, align 4
  %229 = load ptr, ptr %4, align 8
  %230 = getelementptr inbounds %struct.tdefl_compressor, ptr %229, i32 0, i32 17
  %231 = load i32, ptr %230, align 4
  %232 = shl i32 %228, %231
  %233 = load ptr, ptr %4, align 8
  %234 = getelementptr inbounds %struct.tdefl_compressor, ptr %233, i32 0, i32 18
  %235 = load i32, ptr %234, align 8
  %236 = or i32 %235, %232
  store i32 %236, ptr %234, align 8
  %237 = load i32, ptr %16, align 4
  %238 = load ptr, ptr %4, align 8
  %239 = getelementptr inbounds %struct.tdefl_compressor, ptr %238, i32 0, i32 17
  %240 = load i32, ptr %239, align 4
  %241 = add i32 %240, %237
  store i32 %241, ptr %239, align 4
  br label %242

242:                                              ; preds = %264, %227
  %243 = load ptr, ptr %4, align 8
  %244 = getelementptr inbounds %struct.tdefl_compressor, ptr %243, i32 0, i32 17
  %245 = load i32, ptr %244, align 4
  %246 = icmp uge i32 %245, 8
  br i1 %246, label %247, label %273

247:                                              ; preds = %242
  %248 = load ptr, ptr %4, align 8
  %249 = getelementptr inbounds %struct.tdefl_compressor, ptr %248, i32 0, i32 12
  %250 = load ptr, ptr %249, align 8
  %251 = load ptr, ptr %4, align 8
  %252 = getelementptr inbounds %struct.tdefl_compressor, ptr %251, i32 0, i32 13
  %253 = load ptr, ptr %252, align 8
  %254 = icmp ult ptr %250, %253
  br i1 %254, label %255, label %264

255:                                              ; preds = %247
  %256 = load ptr, ptr %4, align 8
  %257 = getelementptr inbounds %struct.tdefl_compressor, ptr %256, i32 0, i32 18
  %258 = load i32, ptr %257, align 8
  %259 = trunc i32 %258 to i8
  %260 = load ptr, ptr %4, align 8
  %261 = getelementptr inbounds %struct.tdefl_compressor, ptr %260, i32 0, i32 12
  %262 = load ptr, ptr %261, align 8
  %263 = getelementptr inbounds i8, ptr %262, i32 1
  store ptr %263, ptr %261, align 8
  store i8 %259, ptr %262, align 1
  br label %264

264:                                              ; preds = %255, %247
  %265 = load ptr, ptr %4, align 8
  %266 = getelementptr inbounds %struct.tdefl_compressor, ptr %265, i32 0, i32 18
  %267 = load i32, ptr %266, align 8
  %268 = lshr i32 %267, 8
  store i32 %268, ptr %266, align 8
  %269 = load ptr, ptr %4, align 8
  %270 = getelementptr inbounds %struct.tdefl_compressor, ptr %269, i32 0, i32 17
  %271 = load i32, ptr %270, align 4
  %272 = sub i32 %271, 8
  store i32 %272, ptr %270, align 4
  br label %242, !llvm.loop !73

273:                                              ; preds = %242
  br label %274

274:                                              ; preds = %273
  br label %275

275:                                              ; preds = %274, %147, %113
  br label %276

276:                                              ; preds = %275
  %277 = load i32, ptr %5, align 4
  %278 = icmp eq i32 %277, 4
  %279 = zext i1 %278 to i32
  store i32 %279, ptr %17, align 4
  store i32 1, ptr %18, align 4
  %280 = load i32, ptr %17, align 4
  %281 = load i32, ptr %18, align 4
  %282 = shl i32 1, %281
  %283 = sub i32 %282, 1
  %284 = icmp ule i32 %280, %283
  %285 = xor i1 %284, true
  %286 = zext i1 %285 to i32
  %287 = sext i32 %286 to i64
  %288 = icmp ne i64 %287, 0
  br i1 %288, label %289, label %291

289:                                              ; preds = %276
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1840, ptr noundef @.str.38) #14
  unreachable

290:                                              ; No predecessors!
  br label %292

291:                                              ; preds = %276
  br label %292

292:                                              ; preds = %291, %290
  %293 = load i32, ptr %17, align 4
  %294 = load ptr, ptr %4, align 8
  %295 = getelementptr inbounds %struct.tdefl_compressor, ptr %294, i32 0, i32 17
  %296 = load i32, ptr %295, align 4
  %297 = shl i32 %293, %296
  %298 = load ptr, ptr %4, align 8
  %299 = getelementptr inbounds %struct.tdefl_compressor, ptr %298, i32 0, i32 18
  %300 = load i32, ptr %299, align 8
  %301 = or i32 %300, %297
  store i32 %301, ptr %299, align 8
  %302 = load i32, ptr %18, align 4
  %303 = load ptr, ptr %4, align 8
  %304 = getelementptr inbounds %struct.tdefl_compressor, ptr %303, i32 0, i32 17
  %305 = load i32, ptr %304, align 4
  %306 = add i32 %305, %302
  store i32 %306, ptr %304, align 4
  br label %307

307:                                              ; preds = %329, %292
  %308 = load ptr, ptr %4, align 8
  %309 = getelementptr inbounds %struct.tdefl_compressor, ptr %308, i32 0, i32 17
  %310 = load i32, ptr %309, align 4
  %311 = icmp uge i32 %310, 8
  br i1 %311, label %312, label %338

312:                                              ; preds = %307
  %313 = load ptr, ptr %4, align 8
  %314 = getelementptr inbounds %struct.tdefl_compressor, ptr %313, i32 0, i32 12
  %315 = load ptr, ptr %314, align 8
  %316 = load ptr, ptr %4, align 8
  %317 = getelementptr inbounds %struct.tdefl_compressor, ptr %316, i32 0, i32 13
  %318 = load ptr, ptr %317, align 8
  %319 = icmp ult ptr %315, %318
  br i1 %319, label %320, label %329

320:                                              ; preds = %312
  %321 = load ptr, ptr %4, align 8
  %322 = getelementptr inbounds %struct.tdefl_compressor, ptr %321, i32 0, i32 18
  %323 = load i32, ptr %322, align 8
  %324 = trunc i32 %323 to i8
  %325 = load ptr, ptr %4, align 8
  %326 = getelementptr inbounds %struct.tdefl_compressor, ptr %325, i32 0, i32 12
  %327 = load ptr, ptr %326, align 8
  %328 = getelementptr inbounds i8, ptr %327, i32 1
  store ptr %328, ptr %326, align 8
  store i8 %324, ptr %327, align 1
  br label %329

329:                                              ; preds = %320, %312
  %330 = load ptr, ptr %4, align 8
  %331 = getelementptr inbounds %struct.tdefl_compressor, ptr %330, i32 0, i32 18
  %332 = load i32, ptr %331, align 8
  %333 = lshr i32 %332, 8
  store i32 %333, ptr %331, align 8
  %334 = load ptr, ptr %4, align 8
  %335 = getelementptr inbounds %struct.tdefl_compressor, ptr %334, i32 0, i32 17
  %336 = load i32, ptr %335, align 4
  %337 = sub i32 %336, 8
  store i32 %337, ptr %335, align 4
  br label %307, !llvm.loop !74

338:                                              ; preds = %307
  br label %339

339:                                              ; preds = %338
  %340 = load ptr, ptr %4, align 8
  %341 = getelementptr inbounds %struct.tdefl_compressor, ptr %340, i32 0, i32 12
  %342 = load ptr, ptr %341, align 8
  store ptr %342, ptr %8, align 8
  %343 = load ptr, ptr %4, align 8
  %344 = getelementptr inbounds %struct.tdefl_compressor, ptr %343, i32 0, i32 18
  %345 = load i32, ptr %344, align 8
  store i32 %345, ptr %6, align 4
  %346 = load ptr, ptr %4, align 8
  %347 = getelementptr inbounds %struct.tdefl_compressor, ptr %346, i32 0, i32 17
  %348 = load i32, ptr %347, align 4
  store i32 %348, ptr %7, align 4
  %349 = load i32, ptr %11, align 4
  %350 = icmp ne i32 %349, 0
  br i1 %350, label %367, label %351

351:                                              ; preds = %339
  %352 = load ptr, ptr %4, align 8
  %353 = load ptr, ptr %4, align 8
  %354 = getelementptr inbounds %struct.tdefl_compressor, ptr %353, i32 0, i32 2
  %355 = load i32, ptr %354, align 8
  %356 = and i32 %355, 524288
  %357 = icmp ne i32 %356, 0
  br i1 %357, label %363, label %358

358:                                              ; preds = %351
  %359 = load ptr, ptr %4, align 8
  %360 = getelementptr inbounds %struct.tdefl_compressor, ptr %359, i32 0, i32 15
  %361 = load i32, ptr %360, align 4
  %362 = icmp ult i32 %361, 48
  br label %363

363:                                              ; preds = %358, %351
  %364 = phi i1 [ true, %351 ], [ %362, %358 ]
  %365 = zext i1 %364 to i32
  %366 = call i32 @tdefl_compress_block(ptr noundef %352, i32 noundef %365)
  store i32 %366, ptr %9, align 4
  br label %367

367:                                              ; preds = %363, %339
  %368 = load i32, ptr %11, align 4
  %369 = icmp ne i32 %368, 0
  br i1 %369, label %389, label %370

370:                                              ; preds = %367
  %371 = load ptr, ptr %4, align 8
  %372 = getelementptr inbounds %struct.tdefl_compressor, ptr %371, i32 0, i32 15
  %373 = load i32, ptr %372, align 4
  %374 = icmp ne i32 %373, 0
  br i1 %374, label %375, label %704

375:                                              ; preds = %370
  %376 = load ptr, ptr %4, align 8
  %377 = getelementptr inbounds %struct.tdefl_compressor, ptr %376, i32 0, i32 12
  %378 = load ptr, ptr %377, align 8
  %379 = load ptr, ptr %8, align 8
  %380 = ptrtoint ptr %378 to i64
  %381 = ptrtoint ptr %379 to i64
  %382 = sub i64 %380, %381
  %383 = add nsw i64 %382, 1
  %384 = load ptr, ptr %4, align 8
  %385 = getelementptr inbounds %struct.tdefl_compressor, ptr %384, i32 0, i32 15
  %386 = load i32, ptr %385, align 4
  %387 = zext i32 %386 to i64
  %388 = icmp sge i64 %383, %387
  br i1 %388, label %389, label %704

389:                                              ; preds = %375, %367
  %390 = load ptr, ptr %4, align 8
  %391 = getelementptr inbounds %struct.tdefl_compressor, ptr %390, i32 0, i32 7
  %392 = load i32, ptr %391, align 8
  %393 = load ptr, ptr %4, align 8
  %394 = getelementptr inbounds %struct.tdefl_compressor, ptr %393, i32 0, i32 16
  %395 = load i32, ptr %394, align 8
  %396 = sub i32 %392, %395
  %397 = load ptr, ptr %4, align 8
  %398 = getelementptr inbounds %struct.tdefl_compressor, ptr %397, i32 0, i32 9
  %399 = load i32, ptr %398, align 8
  %400 = icmp ule i32 %396, %399
  br i1 %400, label %401, label %704

401:                                              ; preds = %389
  %402 = load ptr, ptr %8, align 8
  %403 = load ptr, ptr %4, align 8
  %404 = getelementptr inbounds %struct.tdefl_compressor, ptr %403, i32 0, i32 12
  store ptr %402, ptr %404, align 8
  %405 = load i32, ptr %6, align 4
  %406 = load ptr, ptr %4, align 8
  %407 = getelementptr inbounds %struct.tdefl_compressor, ptr %406, i32 0, i32 18
  store i32 %405, ptr %407, align 8
  %408 = load i32, ptr %7, align 4
  %409 = load ptr, ptr %4, align 8
  %410 = getelementptr inbounds %struct.tdefl_compressor, ptr %409, i32 0, i32 17
  store i32 %408, ptr %410, align 4
  br label %411

411:                                              ; preds = %401
  store i32 0, ptr %20, align 4
  store i32 2, ptr %21, align 4
  %412 = load i32, ptr %20, align 4
  %413 = load i32, ptr %21, align 4
  %414 = shl i32 1, %413
  %415 = sub i32 %414, 1
  %416 = icmp ule i32 %412, %415
  %417 = xor i1 %416, true
  %418 = zext i1 %417 to i32
  %419 = sext i32 %418 to i64
  %420 = icmp ne i64 %419, 0
  br i1 %420, label %421, label %423

421:                                              ; preds = %411
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1852, ptr noundef @.str.38) #14
  unreachable

422:                                              ; No predecessors!
  br label %424

423:                                              ; preds = %411
  br label %424

424:                                              ; preds = %423, %422
  %425 = load i32, ptr %20, align 4
  %426 = load ptr, ptr %4, align 8
  %427 = getelementptr inbounds %struct.tdefl_compressor, ptr %426, i32 0, i32 17
  %428 = load i32, ptr %427, align 4
  %429 = shl i32 %425, %428
  %430 = load ptr, ptr %4, align 8
  %431 = getelementptr inbounds %struct.tdefl_compressor, ptr %430, i32 0, i32 18
  %432 = load i32, ptr %431, align 8
  %433 = or i32 %432, %429
  store i32 %433, ptr %431, align 8
  %434 = load i32, ptr %21, align 4
  %435 = load ptr, ptr %4, align 8
  %436 = getelementptr inbounds %struct.tdefl_compressor, ptr %435, i32 0, i32 17
  %437 = load i32, ptr %436, align 4
  %438 = add i32 %437, %434
  store i32 %438, ptr %436, align 4
  br label %439

439:                                              ; preds = %461, %424
  %440 = load ptr, ptr %4, align 8
  %441 = getelementptr inbounds %struct.tdefl_compressor, ptr %440, i32 0, i32 17
  %442 = load i32, ptr %441, align 4
  %443 = icmp uge i32 %442, 8
  br i1 %443, label %444, label %470

444:                                              ; preds = %439
  %445 = load ptr, ptr %4, align 8
  %446 = getelementptr inbounds %struct.tdefl_compressor, ptr %445, i32 0, i32 12
  %447 = load ptr, ptr %446, align 8
  %448 = load ptr, ptr %4, align 8
  %449 = getelementptr inbounds %struct.tdefl_compressor, ptr %448, i32 0, i32 13
  %450 = load ptr, ptr %449, align 8
  %451 = icmp ult ptr %447, %450
  br i1 %451, label %452, label %461

452:                                              ; preds = %444
  %453 = load ptr, ptr %4, align 8
  %454 = getelementptr inbounds %struct.tdefl_compressor, ptr %453, i32 0, i32 18
  %455 = load i32, ptr %454, align 8
  %456 = trunc i32 %455 to i8
  %457 = load ptr, ptr %4, align 8
  %458 = getelementptr inbounds %struct.tdefl_compressor, ptr %457, i32 0, i32 12
  %459 = load ptr, ptr %458, align 8
  %460 = getelementptr inbounds i8, ptr %459, i32 1
  store ptr %460, ptr %458, align 8
  store i8 %456, ptr %459, align 1
  br label %461

461:                                              ; preds = %452, %444
  %462 = load ptr, ptr %4, align 8
  %463 = getelementptr inbounds %struct.tdefl_compressor, ptr %462, i32 0, i32 18
  %464 = load i32, ptr %463, align 8
  %465 = lshr i32 %464, 8
  store i32 %465, ptr %463, align 8
  %466 = load ptr, ptr %4, align 8
  %467 = getelementptr inbounds %struct.tdefl_compressor, ptr %466, i32 0, i32 17
  %468 = load i32, ptr %467, align 4
  %469 = sub i32 %468, 8
  store i32 %469, ptr %467, align 4
  br label %439, !llvm.loop !75

470:                                              ; preds = %439
  br label %471

471:                                              ; preds = %470
  %472 = load ptr, ptr %4, align 8
  %473 = getelementptr inbounds %struct.tdefl_compressor, ptr %472, i32 0, i32 17
  %474 = load i32, ptr %473, align 4
  %475 = icmp ne i32 %474, 0
  br i1 %475, label %476, label %542

476:                                              ; preds = %471
  br label %477

477:                                              ; preds = %476
  store i32 0, ptr %22, align 4
  %478 = load ptr, ptr %4, align 8
  %479 = getelementptr inbounds %struct.tdefl_compressor, ptr %478, i32 0, i32 17
  %480 = load i32, ptr %479, align 4
  %481 = sub i32 8, %480
  store i32 %481, ptr %23, align 4
  %482 = load i32, ptr %22, align 4
  %483 = load i32, ptr %23, align 4
  %484 = shl i32 1, %483
  %485 = sub i32 %484, 1
  %486 = icmp ule i32 %482, %485
  %487 = xor i1 %486, true
  %488 = zext i1 %487 to i32
  %489 = sext i32 %488 to i64
  %490 = icmp ne i64 %489, 0
  br i1 %490, label %491, label %493

491:                                              ; preds = %477
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1853, ptr noundef @.str.38) #14
  unreachable

492:                                              ; No predecessors!
  br label %494

493:                                              ; preds = %477
  br label %494

494:                                              ; preds = %493, %492
  %495 = load i32, ptr %22, align 4
  %496 = load ptr, ptr %4, align 8
  %497 = getelementptr inbounds %struct.tdefl_compressor, ptr %496, i32 0, i32 17
  %498 = load i32, ptr %497, align 4
  %499 = shl i32 %495, %498
  %500 = load ptr, ptr %4, align 8
  %501 = getelementptr inbounds %struct.tdefl_compressor, ptr %500, i32 0, i32 18
  %502 = load i32, ptr %501, align 8
  %503 = or i32 %502, %499
  store i32 %503, ptr %501, align 8
  %504 = load i32, ptr %23, align 4
  %505 = load ptr, ptr %4, align 8
  %506 = getelementptr inbounds %struct.tdefl_compressor, ptr %505, i32 0, i32 17
  %507 = load i32, ptr %506, align 4
  %508 = add i32 %507, %504
  store i32 %508, ptr %506, align 4
  br label %509

509:                                              ; preds = %531, %494
  %510 = load ptr, ptr %4, align 8
  %511 = getelementptr inbounds %struct.tdefl_compressor, ptr %510, i32 0, i32 17
  %512 = load i32, ptr %511, align 4
  %513 = icmp uge i32 %512, 8
  br i1 %513, label %514, label %540

514:                                              ; preds = %509
  %515 = load ptr, ptr %4, align 8
  %516 = getelementptr inbounds %struct.tdefl_compressor, ptr %515, i32 0, i32 12
  %517 = load ptr, ptr %516, align 8
  %518 = load ptr, ptr %4, align 8
  %519 = getelementptr inbounds %struct.tdefl_compressor, ptr %518, i32 0, i32 13
  %520 = load ptr, ptr %519, align 8
  %521 = icmp ult ptr %517, %520
  br i1 %521, label %522, label %531

522:                                              ; preds = %514
  %523 = load ptr, ptr %4, align 8
  %524 = getelementptr inbounds %struct.tdefl_compressor, ptr %523, i32 0, i32 18
  %525 = load i32, ptr %524, align 8
  %526 = trunc i32 %525 to i8
  %527 = load ptr, ptr %4, align 8
  %528 = getelementptr inbounds %struct.tdefl_compressor, ptr %527, i32 0, i32 12
  %529 = load ptr, ptr %528, align 8
  %530 = getelementptr inbounds i8, ptr %529, i32 1
  store ptr %530, ptr %528, align 8
  store i8 %526, ptr %529, align 1
  br label %531

531:                                              ; preds = %522, %514
  %532 = load ptr, ptr %4, align 8
  %533 = getelementptr inbounds %struct.tdefl_compressor, ptr %532, i32 0, i32 18
  %534 = load i32, ptr %533, align 8
  %535 = lshr i32 %534, 8
  store i32 %535, ptr %533, align 8
  %536 = load ptr, ptr %4, align 8
  %537 = getelementptr inbounds %struct.tdefl_compressor, ptr %536, i32 0, i32 17
  %538 = load i32, ptr %537, align 4
  %539 = sub i32 %538, 8
  store i32 %539, ptr %537, align 4
  br label %509, !llvm.loop !76

540:                                              ; preds = %509
  br label %541

541:                                              ; preds = %540
  br label %542

542:                                              ; preds = %541, %471
  store i32 2, ptr %19, align 4
  br label %543

543:                                              ; preds = %612, %542
  %544 = load i32, ptr %19, align 4
  %545 = icmp ne i32 %544, 0
  br i1 %545, label %546, label %619

546:                                              ; preds = %543
  br label %547

547:                                              ; preds = %546
  %548 = load ptr, ptr %4, align 8
  %549 = getelementptr inbounds %struct.tdefl_compressor, ptr %548, i32 0, i32 15
  %550 = load i32, ptr %549, align 4
  %551 = and i32 %550, 65535
  store i32 %551, ptr %24, align 4
  store i32 16, ptr %25, align 4
  %552 = load i32, ptr %24, align 4
  %553 = load i32, ptr %25, align 4
  %554 = shl i32 1, %553
  %555 = sub i32 %554, 1
  %556 = icmp ule i32 %552, %555
  %557 = xor i1 %556, true
  %558 = zext i1 %557 to i32
  %559 = sext i32 %558 to i64
  %560 = icmp ne i64 %559, 0
  br i1 %560, label %561, label %563

561:                                              ; preds = %547
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1856, ptr noundef @.str.38) #14
  unreachable

562:                                              ; No predecessors!
  br label %564

563:                                              ; preds = %547
  br label %564

564:                                              ; preds = %563, %562
  %565 = load i32, ptr %24, align 4
  %566 = load ptr, ptr %4, align 8
  %567 = getelementptr inbounds %struct.tdefl_compressor, ptr %566, i32 0, i32 17
  %568 = load i32, ptr %567, align 4
  %569 = shl i32 %565, %568
  %570 = load ptr, ptr %4, align 8
  %571 = getelementptr inbounds %struct.tdefl_compressor, ptr %570, i32 0, i32 18
  %572 = load i32, ptr %571, align 8
  %573 = or i32 %572, %569
  store i32 %573, ptr %571, align 8
  %574 = load i32, ptr %25, align 4
  %575 = load ptr, ptr %4, align 8
  %576 = getelementptr inbounds %struct.tdefl_compressor, ptr %575, i32 0, i32 17
  %577 = load i32, ptr %576, align 4
  %578 = add i32 %577, %574
  store i32 %578, ptr %576, align 4
  br label %579

579:                                              ; preds = %601, %564
  %580 = load ptr, ptr %4, align 8
  %581 = getelementptr inbounds %struct.tdefl_compressor, ptr %580, i32 0, i32 17
  %582 = load i32, ptr %581, align 4
  %583 = icmp uge i32 %582, 8
  br i1 %583, label %584, label %610

584:                                              ; preds = %579
  %585 = load ptr, ptr %4, align 8
  %586 = getelementptr inbounds %struct.tdefl_compressor, ptr %585, i32 0, i32 12
  %587 = load ptr, ptr %586, align 8
  %588 = load ptr, ptr %4, align 8
  %589 = getelementptr inbounds %struct.tdefl_compressor, ptr %588, i32 0, i32 13
  %590 = load ptr, ptr %589, align 8
  %591 = icmp ult ptr %587, %590
  br i1 %591, label %592, label %601

592:                                              ; preds = %584
  %593 = load ptr, ptr %4, align 8
  %594 = getelementptr inbounds %struct.tdefl_compressor, ptr %593, i32 0, i32 18
  %595 = load i32, ptr %594, align 8
  %596 = trunc i32 %595 to i8
  %597 = load ptr, ptr %4, align 8
  %598 = getelementptr inbounds %struct.tdefl_compressor, ptr %597, i32 0, i32 12
  %599 = load ptr, ptr %598, align 8
  %600 = getelementptr inbounds i8, ptr %599, i32 1
  store ptr %600, ptr %598, align 8
  store i8 %596, ptr %599, align 1
  br label %601

601:                                              ; preds = %592, %584
  %602 = load ptr, ptr %4, align 8
  %603 = getelementptr inbounds %struct.tdefl_compressor, ptr %602, i32 0, i32 18
  %604 = load i32, ptr %603, align 8
  %605 = lshr i32 %604, 8
  store i32 %605, ptr %603, align 8
  %606 = load ptr, ptr %4, align 8
  %607 = getelementptr inbounds %struct.tdefl_compressor, ptr %606, i32 0, i32 17
  %608 = load i32, ptr %607, align 4
  %609 = sub i32 %608, 8
  store i32 %609, ptr %607, align 4
  br label %579, !llvm.loop !77

610:                                              ; preds = %579
  br label %611

611:                                              ; preds = %610
  br label %612

612:                                              ; preds = %611
  %613 = load i32, ptr %19, align 4
  %614 = add i32 %613, -1
  store i32 %614, ptr %19, align 4
  %615 = load ptr, ptr %4, align 8
  %616 = getelementptr inbounds %struct.tdefl_compressor, ptr %615, i32 0, i32 15
  %617 = load i32, ptr %616, align 4
  %618 = xor i32 %617, 65535
  store i32 %618, ptr %616, align 4
  br label %543, !llvm.loop !78

619:                                              ; preds = %543
  store i32 0, ptr %19, align 4
  br label %620

620:                                              ; preds = %700, %619
  %621 = load i32, ptr %19, align 4
  %622 = load ptr, ptr %4, align 8
  %623 = getelementptr inbounds %struct.tdefl_compressor, ptr %622, i32 0, i32 15
  %624 = load i32, ptr %623, align 4
  %625 = icmp ult i32 %621, %624
  br i1 %625, label %626, label %703

626:                                              ; preds = %620
  br label %627

627:                                              ; preds = %626
  %628 = load ptr, ptr %4, align 8
  %629 = getelementptr inbounds %struct.tdefl_compressor, ptr %628, i32 0, i32 36
  %630 = load ptr, ptr %4, align 8
  %631 = getelementptr inbounds %struct.tdefl_compressor, ptr %630, i32 0, i32 16
  %632 = load i32, ptr %631, align 8
  %633 = load i32, ptr %19, align 4
  %634 = add i32 %632, %633
  %635 = and i32 %634, 32767
  %636 = zext i32 %635 to i64
  %637 = getelementptr inbounds [33025 x i8], ptr %629, i64 0, i64 %636
  %638 = load i8, ptr %637, align 1
  %639 = zext i8 %638 to i32
  store i32 %639, ptr %26, align 4
  store i32 8, ptr %27, align 4
  %640 = load i32, ptr %26, align 4
  %641 = load i32, ptr %27, align 4
  %642 = shl i32 1, %641
  %643 = sub i32 %642, 1
  %644 = icmp ule i32 %640, %643
  %645 = xor i1 %644, true
  %646 = zext i1 %645 to i32
  %647 = sext i32 %646 to i64
  %648 = icmp ne i64 %647, 0
  br i1 %648, label %649, label %651

649:                                              ; preds = %627
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1860, ptr noundef @.str.38) #14
  unreachable

650:                                              ; No predecessors!
  br label %652

651:                                              ; preds = %627
  br label %652

652:                                              ; preds = %651, %650
  %653 = load i32, ptr %26, align 4
  %654 = load ptr, ptr %4, align 8
  %655 = getelementptr inbounds %struct.tdefl_compressor, ptr %654, i32 0, i32 17
  %656 = load i32, ptr %655, align 4
  %657 = shl i32 %653, %656
  %658 = load ptr, ptr %4, align 8
  %659 = getelementptr inbounds %struct.tdefl_compressor, ptr %658, i32 0, i32 18
  %660 = load i32, ptr %659, align 8
  %661 = or i32 %660, %657
  store i32 %661, ptr %659, align 8
  %662 = load i32, ptr %27, align 4
  %663 = load ptr, ptr %4, align 8
  %664 = getelementptr inbounds %struct.tdefl_compressor, ptr %663, i32 0, i32 17
  %665 = load i32, ptr %664, align 4
  %666 = add i32 %665, %662
  store i32 %666, ptr %664, align 4
  br label %667

667:                                              ; preds = %689, %652
  %668 = load ptr, ptr %4, align 8
  %669 = getelementptr inbounds %struct.tdefl_compressor, ptr %668, i32 0, i32 17
  %670 = load i32, ptr %669, align 4
  %671 = icmp uge i32 %670, 8
  br i1 %671, label %672, label %698

672:                                              ; preds = %667
  %673 = load ptr, ptr %4, align 8
  %674 = getelementptr inbounds %struct.tdefl_compressor, ptr %673, i32 0, i32 12
  %675 = load ptr, ptr %674, align 8
  %676 = load ptr, ptr %4, align 8
  %677 = getelementptr inbounds %struct.tdefl_compressor, ptr %676, i32 0, i32 13
  %678 = load ptr, ptr %677, align 8
  %679 = icmp ult ptr %675, %678
  br i1 %679, label %680, label %689

680:                                              ; preds = %672
  %681 = load ptr, ptr %4, align 8
  %682 = getelementptr inbounds %struct.tdefl_compressor, ptr %681, i32 0, i32 18
  %683 = load i32, ptr %682, align 8
  %684 = trunc i32 %683 to i8
  %685 = load ptr, ptr %4, align 8
  %686 = getelementptr inbounds %struct.tdefl_compressor, ptr %685, i32 0, i32 12
  %687 = load ptr, ptr %686, align 8
  %688 = getelementptr inbounds i8, ptr %687, i32 1
  store ptr %688, ptr %686, align 8
  store i8 %684, ptr %687, align 1
  br label %689

689:                                              ; preds = %680, %672
  %690 = load ptr, ptr %4, align 8
  %691 = getelementptr inbounds %struct.tdefl_compressor, ptr %690, i32 0, i32 18
  %692 = load i32, ptr %691, align 8
  %693 = lshr i32 %692, 8
  store i32 %693, ptr %691, align 8
  %694 = load ptr, ptr %4, align 8
  %695 = getelementptr inbounds %struct.tdefl_compressor, ptr %694, i32 0, i32 17
  %696 = load i32, ptr %695, align 4
  %697 = sub i32 %696, 8
  store i32 %697, ptr %695, align 4
  br label %667, !llvm.loop !79

698:                                              ; preds = %667
  br label %699

699:                                              ; preds = %698
  br label %700

700:                                              ; preds = %699
  %701 = load i32, ptr %19, align 4
  %702 = add i32 %701, 1
  store i32 %702, ptr %19, align 4
  br label %620, !llvm.loop !80

703:                                              ; preds = %620
  br label %720

704:                                              ; preds = %389, %375, %370
  %705 = load i32, ptr %9, align 4
  %706 = icmp ne i32 %705, 0
  br i1 %706, label %719, label %707

707:                                              ; preds = %704
  %708 = load ptr, ptr %8, align 8
  %709 = load ptr, ptr %4, align 8
  %710 = getelementptr inbounds %struct.tdefl_compressor, ptr %709, i32 0, i32 12
  store ptr %708, ptr %710, align 8
  %711 = load i32, ptr %6, align 4
  %712 = load ptr, ptr %4, align 8
  %713 = getelementptr inbounds %struct.tdefl_compressor, ptr %712, i32 0, i32 18
  store i32 %711, ptr %713, align 8
  %714 = load i32, ptr %7, align 4
  %715 = load ptr, ptr %4, align 8
  %716 = getelementptr inbounds %struct.tdefl_compressor, ptr %715, i32 0, i32 17
  store i32 %714, ptr %716, align 4
  %717 = load ptr, ptr %4, align 8
  %718 = call i32 @tdefl_compress_block(ptr noundef %717, i32 noundef 1)
  br label %719

719:                                              ; preds = %707, %704
  br label %720

720:                                              ; preds = %719, %703
  %721 = load i32, ptr %5, align 4
  %722 = icmp ne i32 %721, 0
  br i1 %722, label %723, label %1089

723:                                              ; preds = %720
  %724 = load i32, ptr %5, align 4
  %725 = icmp eq i32 %724, 4
  br i1 %725, label %726, label %882

726:                                              ; preds = %723
  %727 = load ptr, ptr %4, align 8
  %728 = getelementptr inbounds %struct.tdefl_compressor, ptr %727, i32 0, i32 17
  %729 = load i32, ptr %728, align 4
  %730 = icmp ne i32 %729, 0
  br i1 %730, label %731, label %797

731:                                              ; preds = %726
  br label %732

732:                                              ; preds = %731
  store i32 0, ptr %28, align 4
  %733 = load ptr, ptr %4, align 8
  %734 = getelementptr inbounds %struct.tdefl_compressor, ptr %733, i32 0, i32 17
  %735 = load i32, ptr %734, align 4
  %736 = sub i32 8, %735
  store i32 %736, ptr %29, align 4
  %737 = load i32, ptr %28, align 4
  %738 = load i32, ptr %29, align 4
  %739 = shl i32 1, %738
  %740 = sub i32 %739, 1
  %741 = icmp ule i32 %737, %740
  %742 = xor i1 %741, true
  %743 = zext i1 %742 to i32
  %744 = sext i32 %743 to i64
  %745 = icmp ne i64 %744, 0
  br i1 %745, label %746, label %748

746:                                              ; preds = %732
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1874, ptr noundef @.str.38) #14
  unreachable

747:                                              ; No predecessors!
  br label %749

748:                                              ; preds = %732
  br label %749

749:                                              ; preds = %748, %747
  %750 = load i32, ptr %28, align 4
  %751 = load ptr, ptr %4, align 8
  %752 = getelementptr inbounds %struct.tdefl_compressor, ptr %751, i32 0, i32 17
  %753 = load i32, ptr %752, align 4
  %754 = shl i32 %750, %753
  %755 = load ptr, ptr %4, align 8
  %756 = getelementptr inbounds %struct.tdefl_compressor, ptr %755, i32 0, i32 18
  %757 = load i32, ptr %756, align 8
  %758 = or i32 %757, %754
  store i32 %758, ptr %756, align 8
  %759 = load i32, ptr %29, align 4
  %760 = load ptr, ptr %4, align 8
  %761 = getelementptr inbounds %struct.tdefl_compressor, ptr %760, i32 0, i32 17
  %762 = load i32, ptr %761, align 4
  %763 = add i32 %762, %759
  store i32 %763, ptr %761, align 4
  br label %764

764:                                              ; preds = %786, %749
  %765 = load ptr, ptr %4, align 8
  %766 = getelementptr inbounds %struct.tdefl_compressor, ptr %765, i32 0, i32 17
  %767 = load i32, ptr %766, align 4
  %768 = icmp uge i32 %767, 8
  br i1 %768, label %769, label %795

769:                                              ; preds = %764
  %770 = load ptr, ptr %4, align 8
  %771 = getelementptr inbounds %struct.tdefl_compressor, ptr %770, i32 0, i32 12
  %772 = load ptr, ptr %771, align 8
  %773 = load ptr, ptr %4, align 8
  %774 = getelementptr inbounds %struct.tdefl_compressor, ptr %773, i32 0, i32 13
  %775 = load ptr, ptr %774, align 8
  %776 = icmp ult ptr %772, %775
  br i1 %776, label %777, label %786

777:                                              ; preds = %769
  %778 = load ptr, ptr %4, align 8
  %779 = getelementptr inbounds %struct.tdefl_compressor, ptr %778, i32 0, i32 18
  %780 = load i32, ptr %779, align 8
  %781 = trunc i32 %780 to i8
  %782 = load ptr, ptr %4, align 8
  %783 = getelementptr inbounds %struct.tdefl_compressor, ptr %782, i32 0, i32 12
  %784 = load ptr, ptr %783, align 8
  %785 = getelementptr inbounds i8, ptr %784, i32 1
  store ptr %785, ptr %783, align 8
  store i8 %781, ptr %784, align 1
  br label %786

786:                                              ; preds = %777, %769
  %787 = load ptr, ptr %4, align 8
  %788 = getelementptr inbounds %struct.tdefl_compressor, ptr %787, i32 0, i32 18
  %789 = load i32, ptr %788, align 8
  %790 = lshr i32 %789, 8
  store i32 %790, ptr %788, align 8
  %791 = load ptr, ptr %4, align 8
  %792 = getelementptr inbounds %struct.tdefl_compressor, ptr %791, i32 0, i32 17
  %793 = load i32, ptr %792, align 4
  %794 = sub i32 %793, 8
  store i32 %794, ptr %792, align 4
  br label %764, !llvm.loop !81

795:                                              ; preds = %764
  br label %796

796:                                              ; preds = %795
  br label %797

797:                                              ; preds = %796, %726
  %798 = load ptr, ptr %4, align 8
  %799 = getelementptr inbounds %struct.tdefl_compressor, ptr %798, i32 0, i32 2
  %800 = load i32, ptr %799, align 8
  %801 = and i32 %800, 4096
  %802 = icmp ne i32 %801, 0
  br i1 %802, label %803, label %881

803:                                              ; preds = %797
  %804 = load ptr, ptr %4, align 8
  %805 = getelementptr inbounds %struct.tdefl_compressor, ptr %804, i32 0, i32 5
  %806 = load i32, ptr %805, align 8
  store i32 %806, ptr %31, align 4
  store i32 0, ptr %30, align 4
  br label %807

807:                                              ; preds = %877, %803
  %808 = load i32, ptr %30, align 4
  %809 = icmp ult i32 %808, 4
  br i1 %809, label %810, label %880

810:                                              ; preds = %807
  br label %811

811:                                              ; preds = %810
  %812 = load i32, ptr %31, align 4
  %813 = lshr i32 %812, 24
  %814 = and i32 %813, 255
  store i32 %814, ptr %32, align 4
  store i32 8, ptr %33, align 4
  %815 = load i32, ptr %32, align 4
  %816 = load i32, ptr %33, align 4
  %817 = shl i32 1, %816
  %818 = sub i32 %817, 1
  %819 = icmp ule i32 %815, %818
  %820 = xor i1 %819, true
  %821 = zext i1 %820 to i32
  %822 = sext i32 %821 to i64
  %823 = icmp ne i64 %822, 0
  br i1 %823, label %824, label %826

824:                                              ; preds = %811
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1875, ptr noundef @.str.38) #14
  unreachable

825:                                              ; No predecessors!
  br label %827

826:                                              ; preds = %811
  br label %827

827:                                              ; preds = %826, %825
  %828 = load i32, ptr %32, align 4
  %829 = load ptr, ptr %4, align 8
  %830 = getelementptr inbounds %struct.tdefl_compressor, ptr %829, i32 0, i32 17
  %831 = load i32, ptr %830, align 4
  %832 = shl i32 %828, %831
  %833 = load ptr, ptr %4, align 8
  %834 = getelementptr inbounds %struct.tdefl_compressor, ptr %833, i32 0, i32 18
  %835 = load i32, ptr %834, align 8
  %836 = or i32 %835, %832
  store i32 %836, ptr %834, align 8
  %837 = load i32, ptr %33, align 4
  %838 = load ptr, ptr %4, align 8
  %839 = getelementptr inbounds %struct.tdefl_compressor, ptr %838, i32 0, i32 17
  %840 = load i32, ptr %839, align 4
  %841 = add i32 %840, %837
  store i32 %841, ptr %839, align 4
  br label %842

842:                                              ; preds = %864, %827
  %843 = load ptr, ptr %4, align 8
  %844 = getelementptr inbounds %struct.tdefl_compressor, ptr %843, i32 0, i32 17
  %845 = load i32, ptr %844, align 4
  %846 = icmp uge i32 %845, 8
  br i1 %846, label %847, label %873

847:                                              ; preds = %842
  %848 = load ptr, ptr %4, align 8
  %849 = getelementptr inbounds %struct.tdefl_compressor, ptr %848, i32 0, i32 12
  %850 = load ptr, ptr %849, align 8
  %851 = load ptr, ptr %4, align 8
  %852 = getelementptr inbounds %struct.tdefl_compressor, ptr %851, i32 0, i32 13
  %853 = load ptr, ptr %852, align 8
  %854 = icmp ult ptr %850, %853
  br i1 %854, label %855, label %864

855:                                              ; preds = %847
  %856 = load ptr, ptr %4, align 8
  %857 = getelementptr inbounds %struct.tdefl_compressor, ptr %856, i32 0, i32 18
  %858 = load i32, ptr %857, align 8
  %859 = trunc i32 %858 to i8
  %860 = load ptr, ptr %4, align 8
  %861 = getelementptr inbounds %struct.tdefl_compressor, ptr %860, i32 0, i32 12
  %862 = load ptr, ptr %861, align 8
  %863 = getelementptr inbounds i8, ptr %862, i32 1
  store ptr %863, ptr %861, align 8
  store i8 %859, ptr %862, align 1
  br label %864

864:                                              ; preds = %855, %847
  %865 = load ptr, ptr %4, align 8
  %866 = getelementptr inbounds %struct.tdefl_compressor, ptr %865, i32 0, i32 18
  %867 = load i32, ptr %866, align 8
  %868 = lshr i32 %867, 8
  store i32 %868, ptr %866, align 8
  %869 = load ptr, ptr %4, align 8
  %870 = getelementptr inbounds %struct.tdefl_compressor, ptr %869, i32 0, i32 17
  %871 = load i32, ptr %870, align 4
  %872 = sub i32 %871, 8
  store i32 %872, ptr %870, align 4
  br label %842, !llvm.loop !82

873:                                              ; preds = %842
  br label %874

874:                                              ; preds = %873
  %875 = load i32, ptr %31, align 4
  %876 = shl i32 %875, 8
  store i32 %876, ptr %31, align 4
  br label %877

877:                                              ; preds = %874
  %878 = load i32, ptr %30, align 4
  %879 = add i32 %878, 1
  store i32 %879, ptr %30, align 4
  br label %807, !llvm.loop !83

880:                                              ; preds = %807
  br label %881

881:                                              ; preds = %880, %797
  br label %1088

882:                                              ; preds = %723
  store i32 0, ptr %35, align 4
  br label %883

883:                                              ; preds = %882
  store i32 0, ptr %36, align 4
  store i32 3, ptr %37, align 4
  %884 = load i32, ptr %36, align 4
  %885 = load i32, ptr %37, align 4
  %886 = shl i32 1, %885
  %887 = sub i32 %886, 1
  %888 = icmp ule i32 %884, %887
  %889 = xor i1 %888, true
  %890 = zext i1 %889 to i32
  %891 = sext i32 %890 to i64
  %892 = icmp ne i64 %891, 0
  br i1 %892, label %893, label %895

893:                                              ; preds = %883
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1879, ptr noundef @.str.38) #14
  unreachable

894:                                              ; No predecessors!
  br label %896

895:                                              ; preds = %883
  br label %896

896:                                              ; preds = %895, %894
  %897 = load i32, ptr %36, align 4
  %898 = load ptr, ptr %4, align 8
  %899 = getelementptr inbounds %struct.tdefl_compressor, ptr %898, i32 0, i32 17
  %900 = load i32, ptr %899, align 4
  %901 = shl i32 %897, %900
  %902 = load ptr, ptr %4, align 8
  %903 = getelementptr inbounds %struct.tdefl_compressor, ptr %902, i32 0, i32 18
  %904 = load i32, ptr %903, align 8
  %905 = or i32 %904, %901
  store i32 %905, ptr %903, align 8
  %906 = load i32, ptr %37, align 4
  %907 = load ptr, ptr %4, align 8
  %908 = getelementptr inbounds %struct.tdefl_compressor, ptr %907, i32 0, i32 17
  %909 = load i32, ptr %908, align 4
  %910 = add i32 %909, %906
  store i32 %910, ptr %908, align 4
  br label %911

911:                                              ; preds = %933, %896
  %912 = load ptr, ptr %4, align 8
  %913 = getelementptr inbounds %struct.tdefl_compressor, ptr %912, i32 0, i32 17
  %914 = load i32, ptr %913, align 4
  %915 = icmp uge i32 %914, 8
  br i1 %915, label %916, label %942

916:                                              ; preds = %911
  %917 = load ptr, ptr %4, align 8
  %918 = getelementptr inbounds %struct.tdefl_compressor, ptr %917, i32 0, i32 12
  %919 = load ptr, ptr %918, align 8
  %920 = load ptr, ptr %4, align 8
  %921 = getelementptr inbounds %struct.tdefl_compressor, ptr %920, i32 0, i32 13
  %922 = load ptr, ptr %921, align 8
  %923 = icmp ult ptr %919, %922
  br i1 %923, label %924, label %933

924:                                              ; preds = %916
  %925 = load ptr, ptr %4, align 8
  %926 = getelementptr inbounds %struct.tdefl_compressor, ptr %925, i32 0, i32 18
  %927 = load i32, ptr %926, align 8
  %928 = trunc i32 %927 to i8
  %929 = load ptr, ptr %4, align 8
  %930 = getelementptr inbounds %struct.tdefl_compressor, ptr %929, i32 0, i32 12
  %931 = load ptr, ptr %930, align 8
  %932 = getelementptr inbounds i8, ptr %931, i32 1
  store ptr %932, ptr %930, align 8
  store i8 %928, ptr %931, align 1
  br label %933

933:                                              ; preds = %924, %916
  %934 = load ptr, ptr %4, align 8
  %935 = getelementptr inbounds %struct.tdefl_compressor, ptr %934, i32 0, i32 18
  %936 = load i32, ptr %935, align 8
  %937 = lshr i32 %936, 8
  store i32 %937, ptr %935, align 8
  %938 = load ptr, ptr %4, align 8
  %939 = getelementptr inbounds %struct.tdefl_compressor, ptr %938, i32 0, i32 17
  %940 = load i32, ptr %939, align 4
  %941 = sub i32 %940, 8
  store i32 %941, ptr %939, align 4
  br label %911, !llvm.loop !84

942:                                              ; preds = %911
  br label %943

943:                                              ; preds = %942
  %944 = load ptr, ptr %4, align 8
  %945 = getelementptr inbounds %struct.tdefl_compressor, ptr %944, i32 0, i32 17
  %946 = load i32, ptr %945, align 4
  %947 = icmp ne i32 %946, 0
  br i1 %947, label %948, label %1014

948:                                              ; preds = %943
  br label %949

949:                                              ; preds = %948
  store i32 0, ptr %38, align 4
  %950 = load ptr, ptr %4, align 8
  %951 = getelementptr inbounds %struct.tdefl_compressor, ptr %950, i32 0, i32 17
  %952 = load i32, ptr %951, align 4
  %953 = sub i32 8, %952
  store i32 %953, ptr %39, align 4
  %954 = load i32, ptr %38, align 4
  %955 = load i32, ptr %39, align 4
  %956 = shl i32 1, %955
  %957 = sub i32 %956, 1
  %958 = icmp ule i32 %954, %957
  %959 = xor i1 %958, true
  %960 = zext i1 %959 to i32
  %961 = sext i32 %960 to i64
  %962 = icmp ne i64 %961, 0
  br i1 %962, label %963, label %965

963:                                              ; preds = %949
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1879, ptr noundef @.str.38) #14
  unreachable

964:                                              ; No predecessors!
  br label %966

965:                                              ; preds = %949
  br label %966

966:                                              ; preds = %965, %964
  %967 = load i32, ptr %38, align 4
  %968 = load ptr, ptr %4, align 8
  %969 = getelementptr inbounds %struct.tdefl_compressor, ptr %968, i32 0, i32 17
  %970 = load i32, ptr %969, align 4
  %971 = shl i32 %967, %970
  %972 = load ptr, ptr %4, align 8
  %973 = getelementptr inbounds %struct.tdefl_compressor, ptr %972, i32 0, i32 18
  %974 = load i32, ptr %973, align 8
  %975 = or i32 %974, %971
  store i32 %975, ptr %973, align 8
  %976 = load i32, ptr %39, align 4
  %977 = load ptr, ptr %4, align 8
  %978 = getelementptr inbounds %struct.tdefl_compressor, ptr %977, i32 0, i32 17
  %979 = load i32, ptr %978, align 4
  %980 = add i32 %979, %976
  store i32 %980, ptr %978, align 4
  br label %981

981:                                              ; preds = %1003, %966
  %982 = load ptr, ptr %4, align 8
  %983 = getelementptr inbounds %struct.tdefl_compressor, ptr %982, i32 0, i32 17
  %984 = load i32, ptr %983, align 4
  %985 = icmp uge i32 %984, 8
  br i1 %985, label %986, label %1012

986:                                              ; preds = %981
  %987 = load ptr, ptr %4, align 8
  %988 = getelementptr inbounds %struct.tdefl_compressor, ptr %987, i32 0, i32 12
  %989 = load ptr, ptr %988, align 8
  %990 = load ptr, ptr %4, align 8
  %991 = getelementptr inbounds %struct.tdefl_compressor, ptr %990, i32 0, i32 13
  %992 = load ptr, ptr %991, align 8
  %993 = icmp ult ptr %989, %992
  br i1 %993, label %994, label %1003

994:                                              ; preds = %986
  %995 = load ptr, ptr %4, align 8
  %996 = getelementptr inbounds %struct.tdefl_compressor, ptr %995, i32 0, i32 18
  %997 = load i32, ptr %996, align 8
  %998 = trunc i32 %997 to i8
  %999 = load ptr, ptr %4, align 8
  %1000 = getelementptr inbounds %struct.tdefl_compressor, ptr %999, i32 0, i32 12
  %1001 = load ptr, ptr %1000, align 8
  %1002 = getelementptr inbounds i8, ptr %1001, i32 1
  store ptr %1002, ptr %1000, align 8
  store i8 %998, ptr %1001, align 1
  br label %1003

1003:                                             ; preds = %994, %986
  %1004 = load ptr, ptr %4, align 8
  %1005 = getelementptr inbounds %struct.tdefl_compressor, ptr %1004, i32 0, i32 18
  %1006 = load i32, ptr %1005, align 8
  %1007 = lshr i32 %1006, 8
  store i32 %1007, ptr %1005, align 8
  %1008 = load ptr, ptr %4, align 8
  %1009 = getelementptr inbounds %struct.tdefl_compressor, ptr %1008, i32 0, i32 17
  %1010 = load i32, ptr %1009, align 4
  %1011 = sub i32 %1010, 8
  store i32 %1011, ptr %1009, align 4
  br label %981, !llvm.loop !85

1012:                                             ; preds = %981
  br label %1013

1013:                                             ; preds = %1012
  br label %1014

1014:                                             ; preds = %1013, %943
  store i32 2, ptr %34, align 4
  br label %1015

1015:                                             ; preds = %1082, %1014
  %1016 = load i32, ptr %34, align 4
  %1017 = icmp ne i32 %1016, 0
  br i1 %1017, label %1018, label %1087

1018:                                             ; preds = %1015
  br label %1019

1019:                                             ; preds = %1018
  %1020 = load i32, ptr %35, align 4
  %1021 = and i32 %1020, 65535
  store i32 %1021, ptr %40, align 4
  store i32 16, ptr %41, align 4
  %1022 = load i32, ptr %40, align 4
  %1023 = load i32, ptr %41, align 4
  %1024 = shl i32 1, %1023
  %1025 = sub i32 %1024, 1
  %1026 = icmp ule i32 %1022, %1025
  %1027 = xor i1 %1026, true
  %1028 = zext i1 %1027 to i32
  %1029 = sext i32 %1028 to i64
  %1030 = icmp ne i64 %1029, 0
  br i1 %1030, label %1031, label %1033

1031:                                             ; preds = %1019
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1879, ptr noundef @.str.38) #14
  unreachable

1032:                                             ; No predecessors!
  br label %1034

1033:                                             ; preds = %1019
  br label %1034

1034:                                             ; preds = %1033, %1032
  %1035 = load i32, ptr %40, align 4
  %1036 = load ptr, ptr %4, align 8
  %1037 = getelementptr inbounds %struct.tdefl_compressor, ptr %1036, i32 0, i32 17
  %1038 = load i32, ptr %1037, align 4
  %1039 = shl i32 %1035, %1038
  %1040 = load ptr, ptr %4, align 8
  %1041 = getelementptr inbounds %struct.tdefl_compressor, ptr %1040, i32 0, i32 18
  %1042 = load i32, ptr %1041, align 8
  %1043 = or i32 %1042, %1039
  store i32 %1043, ptr %1041, align 8
  %1044 = load i32, ptr %41, align 4
  %1045 = load ptr, ptr %4, align 8
  %1046 = getelementptr inbounds %struct.tdefl_compressor, ptr %1045, i32 0, i32 17
  %1047 = load i32, ptr %1046, align 4
  %1048 = add i32 %1047, %1044
  store i32 %1048, ptr %1046, align 4
  br label %1049

1049:                                             ; preds = %1071, %1034
  %1050 = load ptr, ptr %4, align 8
  %1051 = getelementptr inbounds %struct.tdefl_compressor, ptr %1050, i32 0, i32 17
  %1052 = load i32, ptr %1051, align 4
  %1053 = icmp uge i32 %1052, 8
  br i1 %1053, label %1054, label %1080

1054:                                             ; preds = %1049
  %1055 = load ptr, ptr %4, align 8
  %1056 = getelementptr inbounds %struct.tdefl_compressor, ptr %1055, i32 0, i32 12
  %1057 = load ptr, ptr %1056, align 8
  %1058 = load ptr, ptr %4, align 8
  %1059 = getelementptr inbounds %struct.tdefl_compressor, ptr %1058, i32 0, i32 13
  %1060 = load ptr, ptr %1059, align 8
  %1061 = icmp ult ptr %1057, %1060
  br i1 %1061, label %1062, label %1071

1062:                                             ; preds = %1054
  %1063 = load ptr, ptr %4, align 8
  %1064 = getelementptr inbounds %struct.tdefl_compressor, ptr %1063, i32 0, i32 18
  %1065 = load i32, ptr %1064, align 8
  %1066 = trunc i32 %1065 to i8
  %1067 = load ptr, ptr %4, align 8
  %1068 = getelementptr inbounds %struct.tdefl_compressor, ptr %1067, i32 0, i32 12
  %1069 = load ptr, ptr %1068, align 8
  %1070 = getelementptr inbounds i8, ptr %1069, i32 1
  store ptr %1070, ptr %1068, align 8
  store i8 %1066, ptr %1069, align 1
  br label %1071

1071:                                             ; preds = %1062, %1054
  %1072 = load ptr, ptr %4, align 8
  %1073 = getelementptr inbounds %struct.tdefl_compressor, ptr %1072, i32 0, i32 18
  %1074 = load i32, ptr %1073, align 8
  %1075 = lshr i32 %1074, 8
  store i32 %1075, ptr %1073, align 8
  %1076 = load ptr, ptr %4, align 8
  %1077 = getelementptr inbounds %struct.tdefl_compressor, ptr %1076, i32 0, i32 17
  %1078 = load i32, ptr %1077, align 4
  %1079 = sub i32 %1078, 8
  store i32 %1079, ptr %1077, align 4
  br label %1049, !llvm.loop !86

1080:                                             ; preds = %1049
  br label %1081

1081:                                             ; preds = %1080
  br label %1082

1082:                                             ; preds = %1081
  %1083 = load i32, ptr %34, align 4
  %1084 = add i32 %1083, -1
  store i32 %1084, ptr %34, align 4
  %1085 = load i32, ptr %35, align 4
  %1086 = xor i32 %1085, 65535
  store i32 %1086, ptr %35, align 4
  br label %1015, !llvm.loop !87

1087:                                             ; preds = %1015
  br label %1088

1088:                                             ; preds = %1087, %881
  br label %1089

1089:                                             ; preds = %1088, %720
  %1090 = load ptr, ptr %4, align 8
  %1091 = getelementptr inbounds %struct.tdefl_compressor, ptr %1090, i32 0, i32 12
  %1092 = load ptr, ptr %1091, align 8
  %1093 = load ptr, ptr %4, align 8
  %1094 = getelementptr inbounds %struct.tdefl_compressor, ptr %1093, i32 0, i32 13
  %1095 = load ptr, ptr %1094, align 8
  %1096 = icmp ult ptr %1092, %1095
  %1097 = xor i1 %1096, true
  %1098 = zext i1 %1097 to i32
  %1099 = sext i32 %1098 to i64
  %1100 = icmp ne i64 %1099, 0
  br i1 %1100, label %1101, label %1103

1101:                                             ; preds = %1089
  call void @__assert_rtn(ptr noundef @__func__.tdefl_flush_block, ptr noundef @.str.14, i32 noundef 1883, ptr noundef @.str.39) #14
  unreachable

1102:                                             ; No predecessors!
  br label %1104

1103:                                             ; preds = %1089
  br label %1104

1104:                                             ; preds = %1103, %1102
  %1105 = load ptr, ptr %4, align 8
  %1106 = getelementptr inbounds %struct.tdefl_compressor, ptr %1105, i32 0, i32 37
  %1107 = getelementptr inbounds [3 x [288 x i32]], ptr %1106, i64 0, i64 0
  %1108 = getelementptr inbounds [288 x i32], ptr %1107, i64 0, i64 0
  %1109 = load ptr, ptr %4, align 8
  %1110 = getelementptr inbounds %struct.tdefl_compressor, ptr %1109, i32 0, i32 37
  %1111 = getelementptr inbounds [3 x [288 x i32]], ptr %1110, i64 0, i64 0
  %1112 = getelementptr inbounds [288 x i32], ptr %1111, i64 0, i64 0
  %1113 = call i64 @llvm.objectsize.i64.p0(ptr %1112, i1 false, i1 true, i1 false)
  %1114 = call ptr @__memset_chk(ptr noundef %1108, i32 noundef 0, i64 noundef 576, i64 noundef %1113) #12
  %1115 = load ptr, ptr %4, align 8
  %1116 = getelementptr inbounds %struct.tdefl_compressor, ptr %1115, i32 0, i32 37
  %1117 = getelementptr inbounds [3 x [288 x i32]], ptr %1116, i64 0, i64 1
  %1118 = getelementptr inbounds [288 x i32], ptr %1117, i64 0, i64 0
  %1119 = load ptr, ptr %4, align 8
  %1120 = getelementptr inbounds %struct.tdefl_compressor, ptr %1119, i32 0, i32 37
  %1121 = getelementptr inbounds [3 x [288 x i32]], ptr %1120, i64 0, i64 1
  %1122 = getelementptr inbounds [288 x i32], ptr %1121, i64 0, i64 0
  %1123 = call i64 @llvm.objectsize.i64.p0(ptr %1122, i1 false, i1 true, i1 false)
  %1124 = call ptr @__memset_chk(ptr noundef %1118, i32 noundef 0, i64 noundef 64, i64 noundef %1123) #12
  %1125 = load ptr, ptr %4, align 8
  %1126 = getelementptr inbounds %struct.tdefl_compressor, ptr %1125, i32 0, i32 40
  %1127 = getelementptr inbounds [65536 x i8], ptr %1126, i64 0, i64 0
  %1128 = getelementptr inbounds i8, ptr %1127, i64 1
  %1129 = load ptr, ptr %4, align 8
  %1130 = getelementptr inbounds %struct.tdefl_compressor, ptr %1129, i32 0, i32 10
  store ptr %1128, ptr %1130, align 8
  %1131 = load ptr, ptr %4, align 8
  %1132 = getelementptr inbounds %struct.tdefl_compressor, ptr %1131, i32 0, i32 40
  %1133 = getelementptr inbounds [65536 x i8], ptr %1132, i64 0, i64 0
  %1134 = load ptr, ptr %4, align 8
  %1135 = getelementptr inbounds %struct.tdefl_compressor, ptr %1134, i32 0, i32 11
  store ptr %1133, ptr %1135, align 8
  %1136 = load ptr, ptr %4, align 8
  %1137 = getelementptr inbounds %struct.tdefl_compressor, ptr %1136, i32 0, i32 14
  store i32 8, ptr %1137, align 8
  %1138 = load ptr, ptr %4, align 8
  %1139 = getelementptr inbounds %struct.tdefl_compressor, ptr %1138, i32 0, i32 15
  %1140 = load i32, ptr %1139, align 4
  %1141 = load ptr, ptr %4, align 8
  %1142 = getelementptr inbounds %struct.tdefl_compressor, ptr %1141, i32 0, i32 16
  %1143 = load i32, ptr %1142, align 8
  %1144 = add i32 %1143, %1140
  store i32 %1144, ptr %1142, align 8
  %1145 = load ptr, ptr %4, align 8
  %1146 = getelementptr inbounds %struct.tdefl_compressor, ptr %1145, i32 0, i32 15
  store i32 0, ptr %1146, align 4
  %1147 = load ptr, ptr %4, align 8
  %1148 = getelementptr inbounds %struct.tdefl_compressor, ptr %1147, i32 0, i32 25
  %1149 = load i32, ptr %1148, align 4
  %1150 = add i32 %1149, 1
  store i32 %1150, ptr %1148, align 4
  %1151 = load ptr, ptr %4, align 8
  %1152 = getelementptr inbounds %struct.tdefl_compressor, ptr %1151, i32 0, i32 12
  %1153 = load ptr, ptr %1152, align 8
  %1154 = load ptr, ptr %12, align 8
  %1155 = ptrtoint ptr %1153 to i64
  %1156 = ptrtoint ptr %1154 to i64
  %1157 = sub i64 %1155, %1156
  %1158 = trunc i64 %1157 to i32
  store i32 %1158, ptr %10, align 4
  %1159 = icmp ne i32 %1158, 0
  br i1 %1159, label %1160, label %1275

1160:                                             ; preds = %1104
  %1161 = load ptr, ptr %4, align 8
  %1162 = getelementptr inbounds %struct.tdefl_compressor, ptr %1161, i32 0, i32 0
  %1163 = load ptr, ptr %1162, align 8
  %1164 = icmp ne ptr %1163, null
  br i1 %1164, label %1165, label %1194

1165:                                             ; preds = %1160
  %1166 = load ptr, ptr %4, align 8
  %1167 = getelementptr inbounds %struct.tdefl_compressor, ptr %1166, i32 0, i32 33
  %1168 = load ptr, ptr %1167, align 8
  %1169 = load ptr, ptr %4, align 8
  %1170 = getelementptr inbounds %struct.tdefl_compressor, ptr %1169, i32 0, i32 28
  %1171 = load ptr, ptr %1170, align 8
  %1172 = ptrtoint ptr %1168 to i64
  %1173 = ptrtoint ptr %1171 to i64
  %1174 = sub i64 %1172, %1173
  %1175 = load ptr, ptr %4, align 8
  %1176 = getelementptr inbounds %struct.tdefl_compressor, ptr %1175, i32 0, i32 30
  %1177 = load ptr, ptr %1176, align 8
  store i64 %1174, ptr %1177, align 8
  %1178 = load ptr, ptr %4, align 8
  %1179 = getelementptr inbounds %struct.tdefl_compressor, ptr %1178, i32 0, i32 0
  %1180 = load ptr, ptr %1179, align 8
  %1181 = load ptr, ptr %4, align 8
  %1182 = getelementptr inbounds %struct.tdefl_compressor, ptr %1181, i32 0, i32 43
  %1183 = getelementptr inbounds [85196 x i8], ptr %1182, i64 0, i64 0
  %1184 = load i32, ptr %10, align 4
  %1185 = load ptr, ptr %4, align 8
  %1186 = getelementptr inbounds %struct.tdefl_compressor, ptr %1185, i32 0, i32 1
  %1187 = load ptr, ptr %1186, align 8
  %1188 = call i32 %1180(ptr noundef %1183, i32 noundef %1184, ptr noundef %1187)
  %1189 = icmp ne i32 %1188, 0
  br i1 %1189, label %1193, label %1190

1190:                                             ; preds = %1165
  %1191 = load ptr, ptr %4, align 8
  %1192 = getelementptr inbounds %struct.tdefl_compressor, ptr %1191, i32 0, i32 27
  store i32 -1, ptr %1192, align 4
  store i32 -1, ptr %3, align 4
  br label %1279

1193:                                             ; preds = %1165
  br label %1274

1194:                                             ; preds = %1160
  %1195 = load ptr, ptr %12, align 8
  %1196 = load ptr, ptr %4, align 8
  %1197 = getelementptr inbounds %struct.tdefl_compressor, ptr %1196, i32 0, i32 43
  %1198 = getelementptr inbounds [85196 x i8], ptr %1197, i64 0, i64 0
  %1199 = icmp eq ptr %1195, %1198
  br i1 %1199, label %1200, label %1266

1200:                                             ; preds = %1194
  %1201 = load i32, ptr %10, align 4
  %1202 = sext i32 %1201 to i64
  %1203 = load ptr, ptr %4, align 8
  %1204 = getelementptr inbounds %struct.tdefl_compressor, ptr %1203, i32 0, i32 31
  %1205 = load ptr, ptr %1204, align 8
  %1206 = load i64, ptr %1205, align 8
  %1207 = load ptr, ptr %4, align 8
  %1208 = getelementptr inbounds %struct.tdefl_compressor, ptr %1207, i32 0, i32 35
  %1209 = load i64, ptr %1208, align 8
  %1210 = sub i64 %1206, %1209
  %1211 = icmp ult i64 %1202, %1210
  br i1 %1211, label %1212, label %1215

1212:                                             ; preds = %1200
  %1213 = load i32, ptr %10, align 4
  %1214 = sext i32 %1213 to i64
  br label %1224

1215:                                             ; preds = %1200
  %1216 = load ptr, ptr %4, align 8
  %1217 = getelementptr inbounds %struct.tdefl_compressor, ptr %1216, i32 0, i32 31
  %1218 = load ptr, ptr %1217, align 8
  %1219 = load i64, ptr %1218, align 8
  %1220 = load ptr, ptr %4, align 8
  %1221 = getelementptr inbounds %struct.tdefl_compressor, ptr %1220, i32 0, i32 35
  %1222 = load i64, ptr %1221, align 8
  %1223 = sub i64 %1219, %1222
  br label %1224

1224:                                             ; preds = %1215, %1212
  %1225 = phi i64 [ %1214, %1212 ], [ %1223, %1215 ]
  %1226 = trunc i64 %1225 to i32
  store i32 %1226, ptr %42, align 4
  %1227 = load ptr, ptr %4, align 8
  %1228 = getelementptr inbounds %struct.tdefl_compressor, ptr %1227, i32 0, i32 29
  %1229 = load ptr, ptr %1228, align 8
  %1230 = load ptr, ptr %4, align 8
  %1231 = getelementptr inbounds %struct.tdefl_compressor, ptr %1230, i32 0, i32 35
  %1232 = load i64, ptr %1231, align 8
  %1233 = getelementptr inbounds i8, ptr %1229, i64 %1232
  %1234 = load ptr, ptr %4, align 8
  %1235 = getelementptr inbounds %struct.tdefl_compressor, ptr %1234, i32 0, i32 43
  %1236 = getelementptr inbounds [85196 x i8], ptr %1235, i64 0, i64 0
  %1237 = load i32, ptr %42, align 4
  %1238 = sext i32 %1237 to i64
  %1239 = load ptr, ptr %4, align 8
  %1240 = getelementptr inbounds %struct.tdefl_compressor, ptr %1239, i32 0, i32 29
  %1241 = load ptr, ptr %1240, align 8
  %1242 = load ptr, ptr %4, align 8
  %1243 = getelementptr inbounds %struct.tdefl_compressor, ptr %1242, i32 0, i32 35
  %1244 = load i64, ptr %1243, align 8
  %1245 = getelementptr inbounds i8, ptr %1241, i64 %1244
  %1246 = call i64 @llvm.objectsize.i64.p0(ptr %1245, i1 false, i1 true, i1 false)
  %1247 = call ptr @__memcpy_chk(ptr noundef %1233, ptr noundef %1236, i64 noundef %1238, i64 noundef %1246) #12
  %1248 = load i32, ptr %42, align 4
  %1249 = sext i32 %1248 to i64
  %1250 = load ptr, ptr %4, align 8
  %1251 = getelementptr inbounds %struct.tdefl_compressor, ptr %1250, i32 0, i32 35
  %1252 = load i64, ptr %1251, align 8
  %1253 = add i64 %1252, %1249
  store i64 %1253, ptr %1251, align 8
  %1254 = load i32, ptr %42, align 4
  %1255 = load i32, ptr %10, align 4
  %1256 = sub nsw i32 %1255, %1254
  store i32 %1256, ptr %10, align 4
  %1257 = icmp ne i32 %1256, 0
  br i1 %1257, label %1258, label %1265

1258:                                             ; preds = %1224
  %1259 = load i32, ptr %42, align 4
  %1260 = load ptr, ptr %4, align 8
  %1261 = getelementptr inbounds %struct.tdefl_compressor, ptr %1260, i32 0, i32 22
  store i32 %1259, ptr %1261, align 8
  %1262 = load i32, ptr %10, align 4
  %1263 = load ptr, ptr %4, align 8
  %1264 = getelementptr inbounds %struct.tdefl_compressor, ptr %1263, i32 0, i32 23
  store i32 %1262, ptr %1264, align 4
  br label %1265

1265:                                             ; preds = %1258, %1224
  br label %1273

1266:                                             ; preds = %1194
  %1267 = load i32, ptr %10, align 4
  %1268 = sext i32 %1267 to i64
  %1269 = load ptr, ptr %4, align 8
  %1270 = getelementptr inbounds %struct.tdefl_compressor, ptr %1269, i32 0, i32 35
  %1271 = load i64, ptr %1270, align 8
  %1272 = add i64 %1271, %1268
  store i64 %1272, ptr %1270, align 8
  br label %1273

1273:                                             ; preds = %1266, %1265
  br label %1274

1274:                                             ; preds = %1273, %1193
  br label %1275

1275:                                             ; preds = %1274, %1104
  %1276 = load ptr, ptr %4, align 8
  %1277 = getelementptr inbounds %struct.tdefl_compressor, ptr %1276, i32 0, i32 23
  %1278 = load i32, ptr %1277, align 4
  store i32 %1278, ptr %3, align 4
  br label %1279

1279:                                             ; preds = %1275, %1190
  %1280 = load i32, ptr %3, align 4
  ret i32 %1280
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_compress_buffer(ptr noundef %0, ptr noundef %1, i64 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  store i32 %3, ptr %8, align 4
  %9 = load ptr, ptr %5, align 8
  %10 = getelementptr inbounds %struct.tdefl_compressor, ptr %9, i32 0, i32 0
  %11 = load ptr, ptr %10, align 8
  %12 = icmp ne ptr %11, null
  %13 = xor i1 %12, true
  %14 = zext i1 %13 to i32
  %15 = sext i32 %14 to i64
  %16 = icmp ne i64 %15, 0
  br i1 %16, label %17, label %19

17:                                               ; preds = %4
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_buffer, ptr noundef @.str.14, i32 noundef 2353, ptr noundef @.str.15) #14
  unreachable

18:                                               ; No predecessors!
  br label %20

19:                                               ; preds = %4
  br label %20

20:                                               ; preds = %19, %18
  %21 = load ptr, ptr %5, align 8
  %22 = load ptr, ptr %6, align 8
  %23 = load i32, ptr %8, align 4
  %24 = call i32 @tdefl_compress(ptr noundef %21, ptr noundef %22, ptr noundef %7, ptr noundef null, ptr noundef null, i32 noundef %23)
  ret i32 %24
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #7

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_get_prev_return_status(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.tdefl_compressor, ptr %3, i32 0, i32 27
  %5 = load i32, ptr %4, align 4
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @tdefl_compress_mem_to_output(ptr noundef %0, i64 noundef %1, ptr noundef %2, ptr noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  store ptr %0, ptr %7, align 8
  store i64 %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store ptr %3, ptr %10, align 8
  store i32 %4, ptr %11, align 4
  %14 = load i64, ptr %8, align 8
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %5
  %17 = load ptr, ptr %7, align 8
  %18 = icmp ne ptr %17, null
  br i1 %18, label %19, label %22

19:                                               ; preds = %16, %5
  %20 = load ptr, ptr %9, align 8
  %21 = icmp ne ptr %20, null
  br i1 %21, label %23, label %22

22:                                               ; preds = %19, %16
  store i32 0, ptr %6, align 4
  br label %49

23:                                               ; preds = %19
  %24 = call ptr @malloc(i64 noundef 319360) #11
  store ptr %24, ptr %12, align 8
  %25 = load ptr, ptr %12, align 8
  %26 = icmp ne ptr %25, null
  br i1 %26, label %28, label %27

27:                                               ; preds = %23
  store i32 0, ptr %6, align 4
  br label %49

28:                                               ; preds = %23
  %29 = load ptr, ptr %12, align 8
  %30 = load ptr, ptr %9, align 8
  %31 = load ptr, ptr %10, align 8
  %32 = load i32, ptr %11, align 4
  %33 = call i32 @tdefl_init(ptr noundef %29, ptr noundef %30, ptr noundef %31, i32 noundef %32)
  %34 = icmp eq i32 %33, 0
  %35 = zext i1 %34 to i32
  store i32 %35, ptr %13, align 4
  %36 = load i32, ptr %13, align 4
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %38, label %44

38:                                               ; preds = %28
  %39 = load ptr, ptr %12, align 8
  %40 = load ptr, ptr %7, align 8
  %41 = load i64, ptr %8, align 8
  %42 = call i32 @tdefl_compress_buffer(ptr noundef %39, ptr noundef %40, i64 noundef %41, i32 noundef 4)
  %43 = icmp eq i32 %42, 1
  br label %44

44:                                               ; preds = %38, %28
  %45 = phi i1 [ false, %28 ], [ %43, %38 ]
  %46 = zext i1 %45 to i32
  store i32 %46, ptr %13, align 4
  %47 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %47)
  %48 = load i32, ptr %13, align 4
  store i32 %48, ptr %6, align 4
  br label %49

49:                                               ; preds = %44, %27, %22
  %50 = load i32, ptr %6, align 4
  ret i32 %50
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define ptr @tdefl_compress_mem_to_heap(ptr noundef %0, i64 noundef %1, ptr noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca %struct.tdefl_output_buffer, align 8
  store ptr %0, ptr %6, align 8
  store i64 %1, ptr %7, align 8
  store ptr %2, ptr %8, align 8
  store i32 %3, ptr %9, align 4
  call void @llvm.memset.p0.i64(ptr align 8 %10, i8 0, i64 32, i1 false)
  %11 = load ptr, ptr %8, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %14, label %13

13:                                               ; preds = %4
  store ptr null, ptr %5, align 8
  br label %30

14:                                               ; preds = %4
  %15 = load ptr, ptr %8, align 8
  store i64 0, ptr %15, align 8
  br label %16

16:                                               ; preds = %14
  %17 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %10, i32 0, i32 3
  store i32 1, ptr %17, align 8
  %18 = load ptr, ptr %6, align 8
  %19 = load i64, ptr %7, align 8
  %20 = load i32, ptr %9, align 4
  %21 = call i32 @tdefl_compress_mem_to_output(ptr noundef %18, i64 noundef %19, ptr noundef @tdefl_output_buffer_putter, ptr noundef %10, i32 noundef %20)
  %22 = icmp ne i32 %21, 0
  br i1 %22, label %24, label %23

23:                                               ; preds = %16
  store ptr null, ptr %5, align 8
  br label %30

24:                                               ; preds = %16
  %25 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %10, i32 0, i32 0
  %26 = load i64, ptr %25, align 8
  %27 = load ptr, ptr %8, align 8
  store i64 %26, ptr %27, align 8
  %28 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %10, i32 0, i32 2
  %29 = load ptr, ptr %28, align 8
  store ptr %29, ptr %5, align 8
  br label %30

30:                                               ; preds = %24, %23, %13
  %31 = load ptr, ptr %5, align 8
  ret ptr %31
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_output_buffer_putter(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca ptr, align 8
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store ptr %2, ptr %7, align 8
  %12 = load ptr, ptr %7, align 8
  store ptr %12, ptr %8, align 8
  %13 = load ptr, ptr %8, align 8
  %14 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 0
  %15 = load i64, ptr %14, align 8
  %16 = load i32, ptr %6, align 4
  %17 = sext i32 %16 to i64
  %18 = add i64 %15, %17
  store i64 %18, ptr %9, align 8
  %19 = load i64, ptr %9, align 8
  %20 = load ptr, ptr %8, align 8
  %21 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %20, i32 0, i32 1
  %22 = load i64, ptr %21, align 8
  %23 = icmp ugt i64 %19, %22
  br i1 %23, label %24, label %64

24:                                               ; preds = %3
  %25 = load ptr, ptr %8, align 8
  %26 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %25, i32 0, i32 1
  %27 = load i64, ptr %26, align 8
  store i64 %27, ptr %10, align 8
  %28 = load ptr, ptr %8, align 8
  %29 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %28, i32 0, i32 3
  %30 = load i32, ptr %29, align 8
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %33, label %32

32:                                               ; preds = %24
  store i32 0, ptr %4, align 4
  br label %87

33:                                               ; preds = %24
  br label %34

34:                                               ; preds = %44, %33
  %35 = load i64, ptr %10, align 8
  %36 = shl i64 %35, 1
  %37 = icmp ugt i64 128, %36
  br i1 %37, label %38, label %39

38:                                               ; preds = %34
  br label %42

39:                                               ; preds = %34
  %40 = load i64, ptr %10, align 8
  %41 = shl i64 %40, 1
  br label %42

42:                                               ; preds = %39, %38
  %43 = phi i64 [ 128, %38 ], [ %41, %39 ]
  store i64 %43, ptr %10, align 8
  br label %44

44:                                               ; preds = %42
  %45 = load i64, ptr %9, align 8
  %46 = load i64, ptr %10, align 8
  %47 = icmp ugt i64 %45, %46
  br i1 %47, label %34, label %48, !llvm.loop !88

48:                                               ; preds = %44
  %49 = load ptr, ptr %8, align 8
  %50 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %49, i32 0, i32 2
  %51 = load ptr, ptr %50, align 8
  %52 = load i64, ptr %10, align 8
  %53 = call ptr @realloc(ptr noundef %51, i64 noundef %52) #13
  store ptr %53, ptr %11, align 8
  %54 = load ptr, ptr %11, align 8
  %55 = icmp ne ptr %54, null
  br i1 %55, label %57, label %56

56:                                               ; preds = %48
  store i32 0, ptr %4, align 4
  br label %87

57:                                               ; preds = %48
  %58 = load ptr, ptr %11, align 8
  %59 = load ptr, ptr %8, align 8
  %60 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %59, i32 0, i32 2
  store ptr %58, ptr %60, align 8
  %61 = load i64, ptr %10, align 8
  %62 = load ptr, ptr %8, align 8
  %63 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %62, i32 0, i32 1
  store i64 %61, ptr %63, align 8
  br label %64

64:                                               ; preds = %57, %3
  %65 = load ptr, ptr %8, align 8
  %66 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %65, i32 0, i32 2
  %67 = load ptr, ptr %66, align 8
  %68 = load ptr, ptr %8, align 8
  %69 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %68, i32 0, i32 0
  %70 = load i64, ptr %69, align 8
  %71 = getelementptr inbounds i8, ptr %67, i64 %70
  %72 = load ptr, ptr %5, align 8
  %73 = load i32, ptr %6, align 4
  %74 = sext i32 %73 to i64
  %75 = load ptr, ptr %8, align 8
  %76 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %75, i32 0, i32 2
  %77 = load ptr, ptr %76, align 8
  %78 = load ptr, ptr %8, align 8
  %79 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %78, i32 0, i32 0
  %80 = load i64, ptr %79, align 8
  %81 = getelementptr inbounds i8, ptr %77, i64 %80
  %82 = call i64 @llvm.objectsize.i64.p0(ptr %81, i1 false, i1 true, i1 false)
  %83 = call ptr @__memcpy_chk(ptr noundef %71, ptr noundef %72, i64 noundef %74, i64 noundef %82) #12
  %84 = load i64, ptr %9, align 8
  %85 = load ptr, ptr %8, align 8
  %86 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %85, i32 0, i32 0
  store i64 %84, ptr %86, align 8
  store i32 1, ptr %4, align 4
  br label %87

87:                                               ; preds = %64, %56, %32
  %88 = load i32, ptr %4, align 4
  ret i32 %88
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i64 @tdefl_compress_mem_to_mem(ptr noundef %0, i64 noundef %1, ptr noundef %2, i64 noundef %3, i32 noundef %4) #0 {
  %6 = alloca i64, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.tdefl_output_buffer, align 8
  store ptr %0, ptr %7, align 8
  store i64 %1, ptr %8, align 8
  store ptr %2, ptr %9, align 8
  store i64 %3, ptr %10, align 8
  store i32 %4, ptr %11, align 4
  call void @llvm.memset.p0.i64(ptr align 8 %12, i8 0, i64 32, i1 false)
  %13 = load ptr, ptr %7, align 8
  %14 = icmp ne ptr %13, null
  br i1 %14, label %16, label %15

15:                                               ; preds = %5
  store i64 0, ptr %6, align 8
  br label %30

16:                                               ; preds = %5
  %17 = load ptr, ptr %7, align 8
  %18 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %12, i32 0, i32 2
  store ptr %17, ptr %18, align 8
  %19 = load i64, ptr %8, align 8
  %20 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %12, i32 0, i32 1
  store i64 %19, ptr %20, align 8
  %21 = load ptr, ptr %9, align 8
  %22 = load i64, ptr %10, align 8
  %23 = load i32, ptr %11, align 4
  %24 = call i32 @tdefl_compress_mem_to_output(ptr noundef %21, i64 noundef %22, ptr noundef @tdefl_output_buffer_putter, ptr noundef %12, i32 noundef %23)
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %27, label %26

26:                                               ; preds = %16
  store i64 0, ptr %6, align 8
  br label %30

27:                                               ; preds = %16
  %28 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %12, i32 0, i32 0
  %29 = load i64, ptr %28, align 8
  store i64 %29, ptr %6, align 8
  br label %30

30:                                               ; preds = %27, %26, %15
  %31 = load i64, ptr %6, align 8
  ret i64 %31
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define ptr @tdefl_write_image_to_png_file_in_memory(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, ptr noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca %struct.tdefl_output_buffer, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca [41 x i8], align 16
  store ptr %0, ptr %7, align 8
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store ptr %4, ptr %11, align 8
  %20 = call ptr @malloc(i64 noundef 319360) #11
  store ptr %20, ptr %12, align 8
  %21 = load i32, ptr %8, align 4
  %22 = load i32, ptr %10, align 4
  %23 = mul nsw i32 %21, %22
  store i32 %23, ptr %15, align 4
  %24 = load ptr, ptr %11, align 8
  store i64 0, ptr %24, align 8
  %25 = load ptr, ptr %12, align 8
  %26 = icmp ne ptr %25, null
  br i1 %26, label %28, label %27

27:                                               ; preds = %5
  store ptr null, ptr %6, align 8
  br label %242

28:                                               ; preds = %5
  call void @llvm.memset.p0.i64(ptr align 8 %13, i8 0, i64 32, i1 false)
  %29 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 3
  store i32 1, ptr %29, align 8
  %30 = load i32, ptr %15, align 4
  %31 = add nsw i32 1, %30
  %32 = load i32, ptr %9, align 4
  %33 = mul nsw i32 %31, %32
  %34 = icmp sgt i32 64, %33
  br i1 %34, label %35, label %36

35:                                               ; preds = %28
  br label %41

36:                                               ; preds = %28
  %37 = load i32, ptr %15, align 4
  %38 = add nsw i32 1, %37
  %39 = load i32, ptr %9, align 4
  %40 = mul nsw i32 %38, %39
  br label %41

41:                                               ; preds = %36, %35
  %42 = phi i32 [ 64, %35 ], [ %40, %36 ]
  %43 = add nsw i32 57, %42
  %44 = sext i32 %43 to i64
  %45 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 1
  store i64 %44, ptr %45, align 8
  %46 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 1
  %47 = load i64, ptr %46, align 8
  %48 = call ptr @malloc(i64 noundef %47) #11
  %49 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  store ptr %48, ptr %49, align 8
  %50 = icmp eq ptr null, %48
  br i1 %50, label %51, label %53

51:                                               ; preds = %41
  %52 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %52)
  store ptr null, ptr %6, align 8
  br label %242

53:                                               ; preds = %41
  store i32 41, ptr %17, align 4
  br label %54

54:                                               ; preds = %59, %53
  %55 = load i32, ptr %17, align 4
  %56 = icmp ne i32 %55, 0
  br i1 %56, label %57, label %62

57:                                               ; preds = %54
  %58 = call i32 @tdefl_output_buffer_putter(ptr noundef %17, i32 noundef 1, ptr noundef %13)
  br label %59

59:                                               ; preds = %57
  %60 = load i32, ptr %17, align 4
  %61 = add nsw i32 %60, -1
  store i32 %61, ptr %17, align 4
  br label %54, !llvm.loop !89

62:                                               ; preds = %54
  %63 = load ptr, ptr %12, align 8
  %64 = call i32 @tdefl_init(ptr noundef %63, ptr noundef @tdefl_output_buffer_putter, ptr noundef %13, i32 noundef 4224)
  store i32 0, ptr %16, align 4
  br label %65

65:                                               ; preds = %82, %62
  %66 = load i32, ptr %16, align 4
  %67 = load i32, ptr %9, align 4
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %85

69:                                               ; preds = %65
  %70 = load ptr, ptr %12, align 8
  %71 = call i32 @tdefl_compress_buffer(ptr noundef %70, ptr noundef %17, i64 noundef 1, i32 noundef 0)
  %72 = load ptr, ptr %12, align 8
  %73 = load ptr, ptr %7, align 8
  %74 = load i32, ptr %16, align 4
  %75 = load i32, ptr %15, align 4
  %76 = mul nsw i32 %74, %75
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds i8, ptr %73, i64 %77
  %79 = load i32, ptr %15, align 4
  %80 = sext i32 %79 to i64
  %81 = call i32 @tdefl_compress_buffer(ptr noundef %72, ptr noundef %78, i64 noundef %80, i32 noundef 0)
  br label %82

82:                                               ; preds = %69
  %83 = load i32, ptr %16, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr %16, align 4
  br label %65, !llvm.loop !90

85:                                               ; preds = %65
  %86 = load ptr, ptr %12, align 8
  %87 = call i32 @tdefl_compress_buffer(ptr noundef %86, ptr noundef null, i64 noundef 0, i32 noundef 4)
  %88 = icmp ne i32 %87, 1
  br i1 %88, label %89, label %93

89:                                               ; preds = %85
  %90 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %90)
  %91 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %92 = load ptr, ptr %91, align 8
  call void @free(ptr noundef %92)
  store ptr null, ptr %6, align 8
  br label %242

93:                                               ; preds = %85
  %94 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 0
  %95 = load i64, ptr %94, align 8
  %96 = sub i64 %95, 41
  %97 = load ptr, ptr %11, align 8
  store i64 %96, ptr %97, align 8
  %98 = getelementptr inbounds [41 x i8], ptr %19, i64 0, i64 0
  store i8 -119, ptr %98, align 1
  %99 = getelementptr inbounds i8, ptr %98, i64 1
  store i8 80, ptr %99, align 1
  %100 = getelementptr inbounds i8, ptr %99, i64 1
  store i8 78, ptr %100, align 1
  %101 = getelementptr inbounds i8, ptr %100, i64 1
  store i8 71, ptr %101, align 1
  %102 = getelementptr inbounds i8, ptr %101, i64 1
  store i8 13, ptr %102, align 1
  %103 = getelementptr inbounds i8, ptr %102, i64 1
  store i8 10, ptr %103, align 1
  %104 = getelementptr inbounds i8, ptr %103, i64 1
  store i8 26, ptr %104, align 1
  %105 = getelementptr inbounds i8, ptr %104, i64 1
  store i8 10, ptr %105, align 1
  %106 = getelementptr inbounds i8, ptr %105, i64 1
  store i8 0, ptr %106, align 1
  %107 = getelementptr inbounds i8, ptr %106, i64 1
  store i8 0, ptr %107, align 1
  %108 = getelementptr inbounds i8, ptr %107, i64 1
  store i8 0, ptr %108, align 1
  %109 = getelementptr inbounds i8, ptr %108, i64 1
  store i8 13, ptr %109, align 1
  %110 = getelementptr inbounds i8, ptr %109, i64 1
  store i8 73, ptr %110, align 1
  %111 = getelementptr inbounds i8, ptr %110, i64 1
  store i8 72, ptr %111, align 1
  %112 = getelementptr inbounds i8, ptr %111, i64 1
  store i8 68, ptr %112, align 1
  %113 = getelementptr inbounds i8, ptr %112, i64 1
  store i8 82, ptr %113, align 1
  %114 = getelementptr inbounds i8, ptr %113, i64 1
  store i8 0, ptr %114, align 1
  %115 = getelementptr inbounds i8, ptr %114, i64 1
  store i8 0, ptr %115, align 1
  %116 = getelementptr inbounds i8, ptr %115, i64 1
  %117 = load i32, ptr %8, align 4
  %118 = ashr i32 %117, 8
  %119 = trunc i32 %118 to i8
  store i8 %119, ptr %116, align 1
  %120 = getelementptr inbounds i8, ptr %116, i64 1
  %121 = load i32, ptr %8, align 4
  %122 = trunc i32 %121 to i8
  store i8 %122, ptr %120, align 1
  %123 = getelementptr inbounds i8, ptr %120, i64 1
  store i8 0, ptr %123, align 1
  %124 = getelementptr inbounds i8, ptr %123, i64 1
  store i8 0, ptr %124, align 1
  %125 = getelementptr inbounds i8, ptr %124, i64 1
  %126 = load i32, ptr %9, align 4
  %127 = ashr i32 %126, 8
  %128 = trunc i32 %127 to i8
  store i8 %128, ptr %125, align 1
  %129 = getelementptr inbounds i8, ptr %125, i64 1
  %130 = load i32, ptr %9, align 4
  %131 = trunc i32 %130 to i8
  store i8 %131, ptr %129, align 1
  %132 = getelementptr inbounds i8, ptr %129, i64 1
  store i8 8, ptr %132, align 1
  %133 = getelementptr inbounds i8, ptr %132, i64 1
  %134 = load i32, ptr %10, align 4
  %135 = sext i32 %134 to i64
  %136 = getelementptr inbounds [6 x i8], ptr @.str.16, i64 0, i64 %135
  %137 = load i8, ptr %136, align 1
  store i8 %137, ptr %133, align 1
  %138 = getelementptr inbounds i8, ptr %133, i64 1
  store i8 0, ptr %138, align 1
  %139 = getelementptr inbounds i8, ptr %138, i64 1
  store i8 0, ptr %139, align 1
  %140 = getelementptr inbounds i8, ptr %139, i64 1
  store i8 0, ptr %140, align 1
  %141 = getelementptr inbounds i8, ptr %140, i64 1
  store i8 0, ptr %141, align 1
  %142 = getelementptr inbounds i8, ptr %141, i64 1
  store i8 0, ptr %142, align 1
  %143 = getelementptr inbounds i8, ptr %142, i64 1
  store i8 0, ptr %143, align 1
  %144 = getelementptr inbounds i8, ptr %143, i64 1
  store i8 0, ptr %144, align 1
  %145 = getelementptr inbounds i8, ptr %144, i64 1
  %146 = load ptr, ptr %11, align 8
  %147 = load i64, ptr %146, align 8
  %148 = lshr i64 %147, 24
  %149 = trunc i64 %148 to i8
  store i8 %149, ptr %145, align 1
  %150 = getelementptr inbounds i8, ptr %145, i64 1
  %151 = load ptr, ptr %11, align 8
  %152 = load i64, ptr %151, align 8
  %153 = lshr i64 %152, 16
  %154 = trunc i64 %153 to i8
  store i8 %154, ptr %150, align 1
  %155 = getelementptr inbounds i8, ptr %150, i64 1
  %156 = load ptr, ptr %11, align 8
  %157 = load i64, ptr %156, align 8
  %158 = lshr i64 %157, 8
  %159 = trunc i64 %158 to i8
  store i8 %159, ptr %155, align 1
  %160 = getelementptr inbounds i8, ptr %155, i64 1
  %161 = load ptr, ptr %11, align 8
  %162 = load i64, ptr %161, align 8
  %163 = trunc i64 %162 to i8
  store i8 %163, ptr %160, align 1
  %164 = getelementptr inbounds i8, ptr %160, i64 1
  store i8 73, ptr %164, align 1
  %165 = getelementptr inbounds i8, ptr %164, i64 1
  store i8 68, ptr %165, align 1
  %166 = getelementptr inbounds i8, ptr %165, i64 1
  store i8 65, ptr %166, align 1
  %167 = getelementptr inbounds i8, ptr %166, i64 1
  store i8 84, ptr %167, align 1
  %168 = getelementptr inbounds [41 x i8], ptr %19, i64 0, i64 0
  %169 = getelementptr inbounds i8, ptr %168, i64 12
  %170 = call i64 @mz_crc32(i64 noundef 0, ptr noundef %169, i64 noundef 17)
  %171 = trunc i64 %170 to i32
  store i32 %171, ptr %18, align 4
  store i32 0, ptr %14, align 4
  br label %172

172:                                              ; preds = %184, %93
  %173 = load i32, ptr %14, align 4
  %174 = icmp slt i32 %173, 4
  br i1 %174, label %175, label %189

175:                                              ; preds = %172
  %176 = load i32, ptr %18, align 4
  %177 = lshr i32 %176, 24
  %178 = trunc i32 %177 to i8
  %179 = getelementptr inbounds [41 x i8], ptr %19, i64 0, i64 0
  %180 = getelementptr inbounds i8, ptr %179, i64 29
  %181 = load i32, ptr %14, align 4
  %182 = sext i32 %181 to i64
  %183 = getelementptr inbounds i8, ptr %180, i64 %182
  store i8 %178, ptr %183, align 1
  br label %184

184:                                              ; preds = %175
  %185 = load i32, ptr %14, align 4
  %186 = add nsw i32 %185, 1
  store i32 %186, ptr %14, align 4
  %187 = load i32, ptr %18, align 4
  %188 = shl i32 %187, 8
  store i32 %188, ptr %18, align 4
  br label %172, !llvm.loop !91

189:                                              ; preds = %172
  %190 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %191 = load ptr, ptr %190, align 8
  %192 = getelementptr inbounds [41 x i8], ptr %19, i64 0, i64 0
  %193 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %194 = load ptr, ptr %193, align 8
  %195 = call i64 @llvm.objectsize.i64.p0(ptr %194, i1 false, i1 true, i1 false)
  %196 = call ptr @__memcpy_chk(ptr noundef %191, ptr noundef %192, i64 noundef 41, i64 noundef %195) #12
  %197 = call i32 @tdefl_output_buffer_putter(ptr noundef @.str.17, i32 noundef 16, ptr noundef %13)
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %204, label %199

199:                                              ; preds = %189
  %200 = load ptr, ptr %11, align 8
  store i64 0, ptr %200, align 8
  %201 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %201)
  %202 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %203 = load ptr, ptr %202, align 8
  call void @free(ptr noundef %203)
  store ptr null, ptr %6, align 8
  br label %242

204:                                              ; preds = %189
  %205 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %206 = load ptr, ptr %205, align 8
  %207 = getelementptr inbounds i8, ptr %206, i64 41
  %208 = getelementptr inbounds i8, ptr %207, i64 -4
  %209 = load ptr, ptr %11, align 8
  %210 = load i64, ptr %209, align 8
  %211 = add i64 %210, 4
  %212 = call i64 @mz_crc32(i64 noundef 0, ptr noundef %208, i64 noundef %211)
  %213 = trunc i64 %212 to i32
  store i32 %213, ptr %18, align 4
  store i32 0, ptr %14, align 4
  br label %214

214:                                              ; preds = %230, %204
  %215 = load i32, ptr %14, align 4
  %216 = icmp slt i32 %215, 4
  br i1 %216, label %217, label %235

217:                                              ; preds = %214
  %218 = load i32, ptr %18, align 4
  %219 = lshr i32 %218, 24
  %220 = trunc i32 %219 to i8
  %221 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %222 = load ptr, ptr %221, align 8
  %223 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 0
  %224 = load i64, ptr %223, align 8
  %225 = getelementptr inbounds i8, ptr %222, i64 %224
  %226 = getelementptr inbounds i8, ptr %225, i64 -16
  %227 = load i32, ptr %14, align 4
  %228 = sext i32 %227 to i64
  %229 = getelementptr inbounds i8, ptr %226, i64 %228
  store i8 %220, ptr %229, align 1
  br label %230

230:                                              ; preds = %217
  %231 = load i32, ptr %14, align 4
  %232 = add nsw i32 %231, 1
  store i32 %232, ptr %14, align 4
  %233 = load i32, ptr %18, align 4
  %234 = shl i32 %233, 8
  store i32 %234, ptr %18, align 4
  br label %214, !llvm.loop !92

235:                                              ; preds = %214
  %236 = load ptr, ptr %11, align 8
  %237 = load i64, ptr %236, align 8
  %238 = add i64 %237, 57
  store i64 %238, ptr %236, align 8
  %239 = load ptr, ptr %12, align 8
  call void @free(ptr noundef %239)
  %240 = getelementptr inbounds %struct.tdefl_output_buffer, ptr %13, i32 0, i32 2
  %241 = load ptr, ptr %240, align 8
  store ptr %241, ptr %6, align 8
  br label %242

242:                                              ; preds = %235, %199, %89, %51, %27
  %243 = load ptr, ptr %6, align 8
  ret ptr %243
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mini_gz_start(ptr noundef %0, ptr noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 2
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = icmp ne ptr %12, null
  %14 = xor i1 %13, true
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %3
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_start, ptr noundef @.str.14, i32 noundef 2553, ptr noundef @.str.18) #14
  unreachable

19:                                               ; No predecessors!
  br label %21

20:                                               ; preds = %3
  br label %21

21:                                               ; preds = %20, %19
  %22 = load ptr, ptr %6, align 8
  store ptr %22, ptr %10, align 8
  %23 = load ptr, ptr %10, align 8
  %24 = getelementptr inbounds i8, ptr %23, i64 0
  store ptr %24, ptr %8, align 8
  %25 = load ptr, ptr %10, align 8
  %26 = getelementptr inbounds i8, ptr %25, i64 10
  store ptr %26, ptr %9, align 8
  %27 = load ptr, ptr %8, align 8
  %28 = load ptr, ptr %5, align 8
  %29 = getelementptr inbounds %struct.mini_gzip, ptr %28, i32 0, i32 6
  store ptr %27, ptr %29, align 8
  %30 = load ptr, ptr %5, align 8
  %31 = getelementptr inbounds %struct.mini_gzip, ptr %30, i32 0, i32 10
  store ptr null, ptr %31, align 8
  %32 = load ptr, ptr %5, align 8
  %33 = getelementptr inbounds %struct.mini_gzip, ptr %32, i32 0, i32 1
  store i64 0, ptr %33, align 8
  %34 = load i64, ptr %7, align 8
  %35 = load ptr, ptr %5, align 8
  %36 = getelementptr inbounds %struct.mini_gzip, ptr %35, i32 0, i32 0
  store i64 %34, ptr %36, align 8
  %37 = load ptr, ptr %5, align 8
  %38 = getelementptr inbounds %struct.mini_gzip, ptr %37, i32 0, i32 2
  store i64 1024, ptr %38, align 8
  %39 = load ptr, ptr %8, align 8
  %40 = getelementptr inbounds i8, ptr %39, i64 0
  %41 = load i8, ptr %40, align 1
  %42 = zext i8 %41 to i32
  %43 = icmp ne i32 %42, 31
  br i1 %43, label %50, label %44

44:                                               ; preds = %21
  %45 = load ptr, ptr %8, align 8
  %46 = getelementptr inbounds i8, ptr %45, i64 1
  %47 = load i8, ptr %46, align 1
  %48 = zext i8 %47 to i32
  %49 = icmp ne i32 %48, 139
  br i1 %49, label %50, label %51

50:                                               ; preds = %44, %21
  store i32 -1, ptr %4, align 4
  br label %158

51:                                               ; preds = %44
  %52 = load ptr, ptr %8, align 8
  %53 = getelementptr inbounds i8, ptr %52, i64 2
  %54 = load i8, ptr %53, align 1
  %55 = zext i8 %54 to i32
  %56 = icmp ne i32 %55, 8
  br i1 %56, label %57, label %58

57:                                               ; preds = %51
  store i32 -2, ptr %4, align 4
  br label %158

58:                                               ; preds = %51
  %59 = load ptr, ptr %8, align 8
  %60 = getelementptr inbounds i8, ptr %59, i64 3
  %61 = load i8, ptr %60, align 1
  %62 = zext i8 %61 to i32
  %63 = and i32 %62, 4
  %64 = icmp ne i32 %63, 0
  br i1 %64, label %65, label %85

65:                                               ; preds = %58
  %66 = load ptr, ptr %9, align 8
  %67 = getelementptr inbounds i8, ptr %66, i64 1
  %68 = load i8, ptr %67, align 1
  %69 = zext i8 %68 to i32
  %70 = shl i32 %69, 8
  %71 = load ptr, ptr %9, align 8
  %72 = getelementptr inbounds i8, ptr %71, i64 0
  %73 = load i8, ptr %72, align 1
  %74 = zext i8 %73 to i32
  %75 = or i32 %70, %74
  %76 = add i32 %75, 0
  store i32 %76, ptr %11, align 2
  %77 = load i32, ptr %11, align 2
  %78 = load ptr, ptr %5, align 8
  %79 = getelementptr inbounds %struct.mini_gzip, ptr %78, i32 0, i32 5
  store i32 %77, ptr %79, align 2
  %80 = load ptr, ptr %9, align 8
  %81 = getelementptr inbounds i8, ptr %80, i64 2
  store ptr %81, ptr %9, align 8
  %82 = load ptr, ptr %9, align 8
  %83 = load ptr, ptr %5, align 8
  %84 = getelementptr inbounds %struct.mini_gzip, ptr %83, i32 0, i32 7
  store ptr %82, ptr %84, align 8
  br label %85

85:                                               ; preds = %65, %58
  %86 = load ptr, ptr %8, align 8
  %87 = getelementptr inbounds i8, ptr %86, i64 3
  %88 = load i8, ptr %87, align 1
  %89 = zext i8 %88 to i32
  %90 = and i32 %89, 8
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %92, label %107

92:                                               ; preds = %85
  %93 = load ptr, ptr %9, align 8
  %94 = load ptr, ptr %5, align 8
  %95 = getelementptr inbounds %struct.mini_gzip, ptr %94, i32 0, i32 8
  store ptr %93, ptr %95, align 8
  br label %96

96:                                               ; preds = %101, %92
  %97 = load ptr, ptr %9, align 8
  %98 = load i8, ptr %97, align 1
  %99 = zext i8 %98 to i32
  %100 = icmp ne i32 %99, 0
  br i1 %100, label %101, label %104

101:                                              ; preds = %96
  %102 = load ptr, ptr %9, align 8
  %103 = getelementptr inbounds i8, ptr %102, i32 1
  store ptr %103, ptr %9, align 8
  br label %96, !llvm.loop !93

104:                                              ; preds = %96
  %105 = load ptr, ptr %9, align 8
  %106 = getelementptr inbounds i8, ptr %105, i32 1
  store ptr %106, ptr %9, align 8
  br label %107

107:                                              ; preds = %104, %85
  %108 = load ptr, ptr %8, align 8
  %109 = getelementptr inbounds i8, ptr %108, i64 3
  %110 = load i8, ptr %109, align 1
  %111 = zext i8 %110 to i32
  %112 = and i32 %111, 16
  %113 = icmp ne i32 %112, 0
  br i1 %113, label %114, label %129

114:                                              ; preds = %107
  %115 = load ptr, ptr %9, align 8
  %116 = load ptr, ptr %5, align 8
  %117 = getelementptr inbounds %struct.mini_gzip, ptr %116, i32 0, i32 9
  store ptr %115, ptr %117, align 8
  br label %118

118:                                              ; preds = %123, %114
  %119 = load ptr, ptr %9, align 8
  %120 = load i8, ptr %119, align 1
  %121 = zext i8 %120 to i32
  %122 = icmp ne i32 %121, 0
  br i1 %122, label %123, label %126

123:                                              ; preds = %118
  %124 = load ptr, ptr %9, align 8
  %125 = getelementptr inbounds i8, ptr %124, i32 1
  store ptr %125, ptr %9, align 8
  br label %118, !llvm.loop !94

126:                                              ; preds = %118
  %127 = load ptr, ptr %9, align 8
  %128 = getelementptr inbounds i8, ptr %127, i32 1
  store ptr %128, ptr %9, align 8
  br label %129

129:                                              ; preds = %126, %107
  %130 = load ptr, ptr %8, align 8
  %131 = getelementptr inbounds i8, ptr %130, i64 3
  %132 = load i8, ptr %131, align 1
  %133 = zext i8 %132 to i32
  %134 = and i32 %133, 2
  %135 = icmp ne i32 %134, 0
  br i1 %135, label %136, label %143

136:                                              ; preds = %129
  %137 = load ptr, ptr %9, align 8
  %138 = load i32, ptr %137, align 2
  %139 = load ptr, ptr %5, align 8
  %140 = getelementptr inbounds %struct.mini_gzip, ptr %139, i32 0, i32 4
  store i32 %138, ptr %140, align 4
  %141 = load ptr, ptr %9, align 8
  %142 = getelementptr inbounds i8, ptr %141, i64 2
  store ptr %142, ptr %9, align 8
  br label %143

143:                                              ; preds = %136, %129
  %144 = load ptr, ptr %9, align 8
  %145 = load ptr, ptr %5, align 8
  %146 = getelementptr inbounds %struct.mini_gzip, ptr %145, i32 0, i32 10
  store ptr %144, ptr %146, align 8
  %147 = load i64, ptr %7, align 8
  %148 = load ptr, ptr %9, align 8
  %149 = load ptr, ptr %8, align 8
  %150 = ptrtoint ptr %148 to i64
  %151 = ptrtoint ptr %149 to i64
  %152 = sub i64 %150, %151
  %153 = sub i64 %147, %152
  %154 = load ptr, ptr %5, align 8
  %155 = getelementptr inbounds %struct.mini_gzip, ptr %154, i32 0, i32 1
  store i64 %153, ptr %155, align 8
  %156 = load ptr, ptr %5, align 8
  %157 = getelementptr inbounds %struct.mini_gzip, ptr %156, i32 0, i32 3
  store i32 -1091850229, ptr %157, align 8
  store i32 0, ptr %4, align 4
  br label %158

158:                                              ; preds = %143, %57, %50
  %159 = load i32, ptr %4, align 4
  ret i32 %159
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @mini_gz_chunksize_set(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = icmp ne ptr %5, null
  %7 = xor i1 %6, true
  %8 = zext i1 %7 to i32
  %9 = sext i32 %8 to i64
  %10 = icmp ne i64 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %2
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_chunksize_set, ptr noundef @.str.14, i32 noundef 2606, ptr noundef @.str.19) #14
  unreachable

12:                                               ; No predecessors!
  br label %14

13:                                               ; preds = %2
  br label %14

14:                                               ; preds = %13, %12
  %15 = load ptr, ptr %3, align 8
  %16 = getelementptr inbounds %struct.mini_gzip, ptr %15, i32 0, i32 3
  %17 = load i32, ptr %16, align 8
  %18 = icmp eq i32 %17, -1091850229
  %19 = xor i1 %18, true
  %20 = zext i1 %19 to i32
  %21 = sext i32 %20 to i64
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %23, label %25

23:                                               ; preds = %14
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_chunksize_set, ptr noundef @.str.14, i32 noundef 2607, ptr noundef @.str.20) #14
  unreachable

24:                                               ; No predecessors!
  br label %26

25:                                               ; preds = %14
  br label %26

26:                                               ; preds = %25, %24
  %27 = load i32, ptr %4, align 4
  %28 = sext i32 %27 to i64
  %29 = load ptr, ptr %3, align 8
  %30 = getelementptr inbounds %struct.mini_gzip, ptr %29, i32 0, i32 2
  store i64 %28, ptr %30, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @mini_gz_init(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = call i64 @llvm.objectsize.i64.p0(ptr %4, i1 false, i1 true, i1 false)
  %6 = call ptr @__memset_chk(ptr noundef %3, i32 noundef -1, i64 noundef 80, i64 noundef %5) #12
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.mini_gzip, ptr %7, i32 0, i32 3
  store i32 -1091850229, ptr %8, align 8
  %9 = load ptr, ptr %2, align 8
  call void @mini_gz_chunksize_set(ptr noundef %9, i32 noundef 1024)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @mini_gz_unpack(ptr noundef %0, ptr noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  %8 = alloca %struct.mz_stream_s, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store ptr %1, ptr %6, align 8
  store i64 %2, ptr %7, align 8
  %12 = load ptr, ptr %5, align 8
  %13 = icmp ne ptr %12, null
  %14 = xor i1 %13, true
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %3
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_unpack, ptr noundef @.str.14, i32 noundef 2627, ptr noundef @.str.19) #14
  unreachable

19:                                               ; No predecessors!
  br label %21

20:                                               ; preds = %3
  br label %21

21:                                               ; preds = %20, %19
  %22 = load ptr, ptr %5, align 8
  %23 = getelementptr inbounds %struct.mini_gzip, ptr %22, i32 0, i32 1
  %24 = load i64, ptr %23, align 8
  %25 = icmp ugt i64 %24, 0
  %26 = xor i1 %25, true
  %27 = zext i1 %26 to i32
  %28 = sext i32 %27 to i64
  %29 = icmp ne i64 %28, 0
  br i1 %29, label %30, label %32

30:                                               ; preds = %21
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_unpack, ptr noundef @.str.14, i32 noundef 2628, ptr noundef @.str.21) #14
  unreachable

31:                                               ; No predecessors!
  br label %33

32:                                               ; preds = %21
  br label %33

33:                                               ; preds = %32, %31
  %34 = load ptr, ptr %5, align 8
  %35 = getelementptr inbounds %struct.mini_gzip, ptr %34, i32 0, i32 3
  %36 = load i32, ptr %35, align 8
  %37 = icmp eq i32 %36, -1091850229
  %38 = xor i1 %37, true
  %39 = zext i1 %38 to i32
  %40 = sext i32 %39 to i64
  %41 = icmp ne i64 %40, 0
  br i1 %41, label %42, label %44

42:                                               ; preds = %33
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_unpack, ptr noundef @.str.14, i32 noundef 2629, ptr noundef @.str.20) #14
  unreachable

43:                                               ; No predecessors!
  br label %45

44:                                               ; preds = %33
  br label %45

45:                                               ; preds = %44, %43
  call void @llvm.memset.p0.i64(ptr align 8 %8, i8 0, i64 120, i1 false)
  %46 = call i32 @mz_inflateInit2(ptr noundef %8, i32 noundef -15)
  %47 = load ptr, ptr %5, align 8
  %48 = getelementptr inbounds %struct.mini_gzip, ptr %47, i32 0, i32 1
  %49 = load i64, ptr %48, align 8
  %50 = trunc i64 %49 to i32
  store i32 %50, ptr %10, align 4
  %51 = load i64, ptr %7, align 8
  %52 = trunc i64 %51 to i32
  %53 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 4
  store i32 %52, ptr %53, align 8
  %54 = load ptr, ptr %5, align 8
  %55 = getelementptr inbounds %struct.mini_gzip, ptr %54, i32 0, i32 10
  %56 = load ptr, ptr %55, align 8
  %57 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 0
  store ptr %56, ptr %57, align 8
  %58 = load ptr, ptr %6, align 8
  %59 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 3
  store ptr %58, ptr %59, align 8
  br label %60

60:                                               ; preds = %114, %45
  %61 = load ptr, ptr %5, align 8
  %62 = getelementptr inbounds %struct.mini_gzip, ptr %61, i32 0, i32 2
  %63 = load i64, ptr %62, align 8
  %64 = load i32, ptr %10, align 4
  %65 = sext i32 %64 to i64
  %66 = icmp ult i64 %63, %65
  br i1 %66, label %67, label %71

67:                                               ; preds = %60
  %68 = load ptr, ptr %5, align 8
  %69 = getelementptr inbounds %struct.mini_gzip, ptr %68, i32 0, i32 2
  %70 = load i64, ptr %69, align 8
  br label %74

71:                                               ; preds = %60
  %72 = load i32, ptr %10, align 4
  %73 = sext i32 %72 to i64
  br label %74

74:                                               ; preds = %71, %67
  %75 = phi i64 [ %70, %67 ], [ %73, %71 ]
  %76 = trunc i64 %75 to i32
  store i32 %76, ptr %11, align 4
  %77 = load i32, ptr %11, align 4
  %78 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 1
  %79 = load i32, ptr %78, align 8
  %80 = add i32 %79, %77
  store i32 %80, ptr %78, align 8
  %81 = call i32 @mz_inflate(ptr noundef %8, i32 noundef 2)
  store i32 %81, ptr %9, align 4
  %82 = load i32, ptr %11, align 4
  %83 = load i32, ptr %10, align 4
  %84 = sub nsw i32 %83, %82
  store i32 %84, ptr %10, align 4
  %85 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 4
  %86 = load i32, ptr %85, align 8
  %87 = icmp eq i32 %86, 0
  br i1 %87, label %88, label %92

88:                                               ; preds = %74
  %89 = load i32, ptr %10, align 4
  %90 = icmp ne i32 %89, 0
  br i1 %90, label %91, label %92

91:                                               ; preds = %88
  store i32 -3, ptr %4, align 4
  br label %124

92:                                               ; preds = %88, %74
  %93 = load i32, ptr %9, align 4
  %94 = icmp ne i32 %93, -5
  %95 = xor i1 %94, true
  %96 = zext i1 %95 to i32
  %97 = sext i32 %96 to i64
  %98 = icmp ne i64 %97, 0
  br i1 %98, label %99, label %101

99:                                               ; preds = %92
  call void @__assert_rtn(ptr noundef @__func__.mini_gz_unpack, ptr noundef @.str.14, i32 noundef 2645, ptr noundef @.str.22) #14
  unreachable

100:                                              ; No predecessors!
  br label %102

101:                                              ; preds = %92
  br label %102

102:                                              ; preds = %101, %100
  %103 = load i32, ptr %9, align 4
  %104 = icmp eq i32 %103, -10000
  br i1 %104, label %105, label %106

105:                                              ; preds = %102
  store i32 -1, ptr %4, align 4
  br label %124

106:                                              ; preds = %102
  %107 = load i32, ptr %9, align 4
  %108 = icmp eq i32 %107, -3
  br i1 %108, label %109, label %110

109:                                              ; preds = %106
  store i32 -2, ptr %4, align 4
  br label %124

110:                                              ; preds = %106
  %111 = load i32, ptr %9, align 4
  %112 = icmp eq i32 %111, 1
  br i1 %112, label %113, label %114

113:                                              ; preds = %110
  br label %115

114:                                              ; preds = %110
  br label %60

115:                                              ; preds = %113
  %116 = call i32 @mz_inflateEnd(ptr noundef %8)
  store i32 %116, ptr %9, align 4
  %117 = load i32, ptr %9, align 4
  %118 = icmp ne i32 %117, 0
  br i1 %118, label %119, label %120

119:                                              ; preds = %115
  store i32 -4, ptr %4, align 4
  br label %124

120:                                              ; preds = %115
  %121 = getelementptr inbounds %struct.mz_stream_s, ptr %8, i32 0, i32 5
  %122 = load i64, ptr %121, align 8
  %123 = trunc i64 %122 to i32
  store i32 %123, ptr %4, align 4
  br label %124

124:                                              ; preds = %120, %119, %109, %105, %91
  %125 = load i32, ptr %4, align 4
  ret i32 %125
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca %struct.mini_gzip, align 8
  %7 = alloca %struct.stat, align 8
  %8 = alloca [1024 x i8], align 16
  %9 = alloca [1024 x i8], align 16
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store i32 6, ptr %13, align 4
  store i32 0, ptr %14, align 4
  br label %21

21:                                               ; preds = %44, %2
  %22 = load i32, ptr %4, align 4
  %23 = load ptr, ptr %5, align 8
  %24 = call i32 @getopt(i32 noundef %22, ptr noundef %23, ptr noundef @.str.23)
  store i32 %24, ptr %15, align 4
  %25 = icmp ne i32 %24, -1
  br i1 %25, label %26, label %45

26:                                               ; preds = %21
  %27 = load i32, ptr %15, align 4
  switch i32 %27, label %43 [
    i32 100, label %28
    i32 99, label %29
    i32 48, label %30
    i32 49, label %30
    i32 50, label %30
    i32 51, label %30
    i32 52, label %30
    i32 53, label %30
    i32 54, label %30
    i32 55, label %30
    i32 56, label %30
    i32 57, label %30
  ]

28:                                               ; preds = %26
  store i32 0, ptr %13, align 4
  br label %44

29:                                               ; preds = %26
  store i32 1, ptr %14, align 4
  br label %44

30:                                               ; preds = %26, %26, %26, %26, %26, %26, %26, %26, %26, %26
  %31 = load i32, ptr %15, align 4
  %32 = icmp ne i32 %31, 48
  %33 = xor i1 %32, true
  %34 = zext i1 %33 to i32
  %35 = sext i32 %34 to i64
  %36 = icmp ne i64 %35, 0
  br i1 %36, label %37, label %39

37:                                               ; preds = %30
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str.14, i32 noundef 2709, ptr noundef @.str.24) #14
  unreachable

38:                                               ; No predecessors!
  br label %40

39:                                               ; preds = %30
  br label %40

40:                                               ; preds = %39, %38
  %41 = load i32, ptr %15, align 4
  %42 = sub nsw i32 %41, 48
  store i32 %42, ptr %13, align 4
  br label %44

43:                                               ; preds = %26
  call void @abort() #14
  unreachable

44:                                               ; preds = %40, %29, %28
  br label %21, !llvm.loop !95

45:                                               ; preds = %21
  %46 = load i32, ptr @optind, align 4
  %47 = load i32, ptr %4, align 4
  %48 = sub nsw i32 %47, %46
  store i32 %48, ptr %4, align 4
  %49 = load i32, ptr @optind, align 4
  %50 = load ptr, ptr %5, align 8
  %51 = sext i32 %49 to i64
  %52 = getelementptr inbounds ptr, ptr %50, i64 %51
  store ptr %52, ptr %5, align 8
  store i32 0, ptr %19, align 4
  %53 = load ptr, ptr %5, align 8
  %54 = getelementptr inbounds ptr, ptr %53, i64 0
  %55 = load ptr, ptr %54, align 8
  %56 = call ptr @strstr(ptr noundef %55, ptr noundef @.str.25)
  store ptr %56, ptr %10, align 8
  %57 = load ptr, ptr %10, align 8
  %58 = icmp ne ptr %57, null
  br i1 %58, label %59, label %60

59:                                               ; preds = %45
  store i32 1, ptr %19, align 4
  br label %60

60:                                               ; preds = %59, %45
  %61 = load i32, ptr %14, align 4
  %62 = load i32, ptr %19, align 4
  %63 = call i32 (ptr, ...) @printf(ptr noundef @.str.26, i32 noundef %61, i32 noundef %62)
  %64 = load i32, ptr %19, align 4
  %65 = icmp ne i32 %64, 0
  br i1 %65, label %66, label %67

66:                                               ; preds = %60
  br label %68

67:                                               ; preds = %60
  br label %68

68:                                               ; preds = %67, %66
  %69 = getelementptr inbounds [1024 x i8], ptr %8, i64 0, i64 0
  %70 = load ptr, ptr %5, align 8
  %71 = getelementptr inbounds ptr, ptr %70, i64 0
  %72 = load ptr, ptr %71, align 8
  %73 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %69, i64 noundef 1023, i32 noundef 0, i64 noundef 1024, ptr noundef @.str.27, ptr noundef %72)
  %74 = getelementptr inbounds [1024 x i8], ptr %9, i64 0, i64 0
  %75 = load ptr, ptr %5, align 8
  %76 = getelementptr inbounds ptr, ptr %75, i64 1
  %77 = load ptr, ptr %76, align 8
  %78 = call i32 (ptr, i64, i32, i64, ptr, ...) @__snprintf_chk(ptr noundef %74, i64 noundef 1023, i32 noundef 0, i64 noundef 1024, ptr noundef @.str.27, ptr noundef %77)
  %79 = getelementptr inbounds [1024 x i8], ptr %8, i64 0, i64 0
  %80 = getelementptr inbounds [1024 x i8], ptr %9, i64 0, i64 0
  %81 = load i32, ptr %13, align 4
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.28, ptr noundef %79, ptr noundef %80, i32 noundef %81)
  %83 = call ptr @calloc(i64 noundef 1048576, i64 noundef 1) #15
  store ptr %83, ptr %11, align 8
  %84 = call ptr @calloc(i64 noundef 1048576, i64 noundef 1) #15
  store ptr %84, ptr %12, align 8
  %85 = getelementptr inbounds [1024 x i8], ptr %8, i64 0, i64 0
  %86 = call i32 (ptr, i32, ...) @open(ptr noundef %85, i32 noundef 0)
  store i32 %86, ptr %16, align 4
  %87 = load i32, ptr %16, align 4
  %88 = call i32 @fstat(i32 noundef %87, ptr noundef %7)
  store i32 %88, ptr %18, align 4
  %89 = load i32, ptr %16, align 4
  %90 = load ptr, ptr %11, align 8
  %91 = getelementptr inbounds %struct.stat, ptr %7, i32 0, i32 11
  %92 = load i64, ptr %91, align 8
  %93 = call i64 @read(i32 noundef %89, ptr noundef %90, i64 noundef %92)
  %94 = trunc i64 %93 to i32
  store i32 %94, ptr %18, align 4
  %95 = getelementptr inbounds [1024 x i8], ptr %9, i64 0, i64 0
  %96 = getelementptr inbounds %struct.stat, ptr %7, i32 0, i32 1
  %97 = load i32, ptr %96, align 4
  %98 = add i32 %97, 0
  %99 = call i32 (ptr, i32, ...) @open(ptr noundef %95, i32 noundef 513, i32 noundef %98)
  store i32 %99, ptr %17, align 4
  %100 = load i32, ptr %14, align 4
  %101 = icmp ne i32 %100, 0
  br i1 %101, label %102, label %103

102:                                              ; preds = %68
  call void @abort() #14
  unreachable

103:                                              ; preds = %68
  %104 = call i32 (ptr, ...) @printf(ptr noundef @.str.29)
  %105 = load ptr, ptr %11, align 8
  %106 = getelementptr inbounds %struct.stat, ptr %7, i32 0, i32 11
  %107 = load i64, ptr %106, align 8
  %108 = call i32 @mini_gz_start(ptr noundef %6, ptr noundef %105, i64 noundef %107)
  store i32 %108, ptr %18, align 4
  %109 = load ptr, ptr %12, align 8
  %110 = call i32 @mini_gz_unpack(ptr noundef %6, ptr noundef %109, i64 noundef 1048576)
  store i32 %110, ptr %20, align 4
  %111 = load i32, ptr %20, align 4
  %112 = call i32 (ptr, ...) @printf(ptr noundef @.str.30, i32 noundef %111)
  %113 = load i32, ptr %17, align 4
  %114 = load ptr, ptr %12, align 8
  %115 = load i32, ptr %20, align 4
  %116 = sext i32 %115 to i64
  %117 = call i64 @write(i32 noundef %113, ptr noundef %114, i64 noundef %116)
  %118 = trunc i64 %117 to i32
  store i32 %118, ptr %18, align 4
  %119 = load i32, ptr %18, align 4
  %120 = call i32 (ptr, ...) @printf(ptr noundef @.str.31, i32 noundef %119)
  br label %121

121:                                              ; preds = %103
  %122 = load i32, ptr %16, align 4
  %123 = call i32 @close(i32 noundef %122)
  %124 = load i32, ptr %17, align 4
  %125 = call i32 @close(i32 noundef %124)
  ret i32 0
}

declare i32 @getopt(i32 noundef, ptr noundef, ptr noundef) #4

; Function Attrs: cold noreturn
declare void @abort() #8

declare ptr @strstr(ptr noundef, ptr noundef) #4

declare i32 @printf(ptr noundef, ...) #4

declare i32 @__snprintf_chk(ptr noundef, i64 noundef, i32 noundef, i64 noundef, ptr noundef, ...) #4

; Function Attrs: allocsize(0,1)
declare ptr @calloc(i64 noundef, i64 noundef) #9

declare i32 @open(ptr noundef, i32 noundef, ...) #4

declare i32 @fstat(i32 noundef, ptr noundef) #4

declare i64 @read(i32 noundef, ptr noundef, i64 noundef) #4

declare i64 @write(i32 noundef, ptr noundef, i64 noundef) #4

declare i32 @close(i32 noundef) #4

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_find_match(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  %21 = alloca ptr, align 8
  %22 = alloca ptr, align 8
  %23 = alloca i32, align 2
  %24 = alloca i32, align 2
  store ptr %0, ptr %7, align 8
  store i32 %1, ptr %8, align 4
  store i32 %2, ptr %9, align 4
  store i32 %3, ptr %10, align 4
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  %25 = load i32, ptr %8, align 4
  %26 = and i32 %25, 32767
  store i32 %26, ptr %14, align 4
  %27 = load ptr, ptr %12, align 8
  %28 = load i32, ptr %27, align 4
  store i32 %28, ptr %15, align 4
  %29 = load i32, ptr %14, align 4
  store i32 %29, ptr %16, align 4
  %30 = load ptr, ptr %7, align 8
  %31 = getelementptr inbounds %struct.tdefl_compressor, ptr %30, i32 0, i32 3
  %32 = load i32, ptr %15, align 4
  %33 = icmp uge i32 %32, 32
  %34 = zext i1 %33 to i32
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [2 x i32], ptr %31, i64 0, i64 %35
  %37 = load i32, ptr %36, align 4
  store i32 %37, ptr %19, align 4
  %38 = load ptr, ptr %7, align 8
  %39 = getelementptr inbounds %struct.tdefl_compressor, ptr %38, i32 0, i32 36
  %40 = getelementptr inbounds [33025 x i8], ptr %39, i64 0, i64 0
  %41 = load i32, ptr %14, align 4
  %42 = zext i32 %41 to i64
  %43 = getelementptr inbounds i8, ptr %40, i64 %42
  store ptr %43, ptr %20, align 8
  %44 = load ptr, ptr %7, align 8
  %45 = getelementptr inbounds %struct.tdefl_compressor, ptr %44, i32 0, i32 36
  %46 = load i32, ptr %14, align 4
  %47 = load i32, ptr %15, align 4
  %48 = add i32 %46, %47
  %49 = sub i32 %48, 1
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds [33025 x i8], ptr %45, i64 0, i64 %50
  %52 = load i32, ptr %51, align 1
  store i32 %52, ptr %23, align 2
  %53 = load ptr, ptr %20, align 8
  %54 = load i32, ptr %53, align 2
  store i32 %54, ptr %24, align 2
  %55 = load i32, ptr %10, align 4
  %56 = icmp ule i32 %55, 258
  %57 = xor i1 %56, true
  %58 = zext i1 %57 to i32
  %59 = sext i32 %58 to i64
  %60 = icmp ne i64 %59, 0
  br i1 %60, label %61, label %63

61:                                               ; preds = %6
  call void @__assert_rtn(ptr noundef @__func__.tdefl_find_match, ptr noundef @.str.14, i32 noundef 1927, ptr noundef @.str.35) #14
  unreachable

62:                                               ; No predecessors!
  br label %64

63:                                               ; preds = %6
  br label %64

64:                                               ; preds = %63, %62
  %65 = load i32, ptr %10, align 4
  %66 = load i32, ptr %15, align 4
  %67 = icmp ule i32 %65, %66
  br i1 %67, label %68, label %69

68:                                               ; preds = %64
  br label %314

69:                                               ; preds = %64
  br label %70

70:                                               ; preds = %313, %202, %69
  br label %71

71:                                               ; preds = %184, %70
  %72 = load i32, ptr %19, align 4
  %73 = add i32 %72, -1
  store i32 %73, ptr %19, align 4
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %75, label %76

75:                                               ; preds = %71
  br label %314

76:                                               ; preds = %71
  %77 = load ptr, ptr %7, align 8
  %78 = getelementptr inbounds %struct.tdefl_compressor, ptr %77, i32 0, i32 41
  %79 = load i32, ptr %16, align 4
  %80 = zext i32 %79 to i64
  %81 = getelementptr inbounds [32768 x i32], ptr %78, i64 0, i64 %80
  %82 = load i32, ptr %81, align 2
  %83 = add i32 %82, 0
  store i32 %83, ptr %17, align 4
  %84 = load i32, ptr %17, align 4
  %85 = icmp ne i32 %84, 0
  br i1 %85, label %86, label %94

86:                                               ; preds = %76
  %87 = load i32, ptr %8, align 4
  %88 = load i32, ptr %17, align 4
  %89 = sub i32 %87, %88
  %90 = add i32 %89, 0
  %91 = add i32 %90, 0
  store i32 %91, ptr %13, align 4
  %92 = load i32, ptr %9, align 4
  %93 = icmp ugt i32 %91, %92
  br i1 %93, label %94, label %95

94:                                               ; preds = %86, %76
  br label %314

95:                                               ; preds = %86
  %96 = load i32, ptr %17, align 4
  %97 = and i32 %96, 32767
  store i32 %97, ptr %16, align 4
  %98 = load ptr, ptr %7, align 8
  %99 = getelementptr inbounds %struct.tdefl_compressor, ptr %98, i32 0, i32 36
  %100 = load i32, ptr %16, align 4
  %101 = load i32, ptr %15, align 4
  %102 = add i32 %100, %101
  %103 = sub i32 %102, 1
  %104 = zext i32 %103 to i64
  %105 = getelementptr inbounds [33025 x i8], ptr %99, i64 0, i64 %104
  %106 = load i32, ptr %105, align 1
  %107 = add i32 %106, 0
  %108 = load i32, ptr %23, align 2
  %109 = add i32 %108, 0
  %110 = icmp eq i32 %107, %109
  br i1 %110, label %111, label %112

111:                                              ; preds = %95
  br label %185

112:                                              ; preds = %95
  %113 = load ptr, ptr %7, align 8
  %114 = getelementptr inbounds %struct.tdefl_compressor, ptr %113, i32 0, i32 41
  %115 = load i32, ptr %16, align 4
  %116 = zext i32 %115 to i64
  %117 = getelementptr inbounds [32768 x i32], ptr %114, i64 0, i64 %116
  %118 = load i32, ptr %117, align 2
  %119 = add i32 %118, 0
  store i32 %119, ptr %17, align 4
  %120 = load i32, ptr %17, align 4
  %121 = icmp ne i32 %120, 0
  br i1 %121, label %122, label %130

122:                                              ; preds = %112
  %123 = load i32, ptr %8, align 4
  %124 = load i32, ptr %17, align 4
  %125 = sub i32 %123, %124
  %126 = add i32 %125, 0
  %127 = add i32 %126, 0
  store i32 %127, ptr %13, align 4
  %128 = load i32, ptr %9, align 4
  %129 = icmp ugt i32 %127, %128
  br i1 %129, label %130, label %131

130:                                              ; preds = %122, %112
  br label %314

131:                                              ; preds = %122
  %132 = load i32, ptr %17, align 4
  %133 = and i32 %132, 32767
  store i32 %133, ptr %16, align 4
  %134 = load ptr, ptr %7, align 8
  %135 = getelementptr inbounds %struct.tdefl_compressor, ptr %134, i32 0, i32 36
  %136 = load i32, ptr %16, align 4
  %137 = load i32, ptr %15, align 4
  %138 = add i32 %136, %137
  %139 = sub i32 %138, 1
  %140 = zext i32 %139 to i64
  %141 = getelementptr inbounds [33025 x i8], ptr %135, i64 0, i64 %140
  %142 = load i32, ptr %141, align 1
  %143 = add i32 %142, 0
  %144 = load i32, ptr %23, align 2
  %145 = add i32 %144, 0
  %146 = icmp eq i32 %143, %145
  br i1 %146, label %147, label %148

147:                                              ; preds = %131
  br label %185

148:                                              ; preds = %131
  %149 = load ptr, ptr %7, align 8
  %150 = getelementptr inbounds %struct.tdefl_compressor, ptr %149, i32 0, i32 41
  %151 = load i32, ptr %16, align 4
  %152 = zext i32 %151 to i64
  %153 = getelementptr inbounds [32768 x i32], ptr %150, i64 0, i64 %152
  %154 = load i32, ptr %153, align 2
  %155 = add i32 %154, 0
  store i32 %155, ptr %17, align 4
  %156 = load i32, ptr %17, align 4
  %157 = icmp ne i32 %156, 0
  br i1 %157, label %158, label %166

158:                                              ; preds = %148
  %159 = load i32, ptr %8, align 4
  %160 = load i32, ptr %17, align 4
  %161 = sub i32 %159, %160
  %162 = add i32 %161, 0
  %163 = add i32 %162, 0
  store i32 %163, ptr %13, align 4
  %164 = load i32, ptr %9, align 4
  %165 = icmp ugt i32 %163, %164
  br i1 %165, label %166, label %167

166:                                              ; preds = %158, %148
  br label %314

167:                                              ; preds = %158
  %168 = load i32, ptr %17, align 4
  %169 = and i32 %168, 32767
  store i32 %169, ptr %16, align 4
  %170 = load ptr, ptr %7, align 8
  %171 = getelementptr inbounds %struct.tdefl_compressor, ptr %170, i32 0, i32 36
  %172 = load i32, ptr %16, align 4
  %173 = load i32, ptr %15, align 4
  %174 = add i32 %172, %173
  %175 = sub i32 %174, 1
  %176 = zext i32 %175 to i64
  %177 = getelementptr inbounds [33025 x i8], ptr %171, i64 0, i64 %176
  %178 = load i32, ptr %177, align 1
  %179 = add i32 %178, 0
  %180 = load i32, ptr %23, align 2
  %181 = add i32 %180, 0
  %182 = icmp eq i32 %179, %181
  br i1 %182, label %183, label %184

183:                                              ; preds = %167
  br label %185

184:                                              ; preds = %167
  br label %71

185:                                              ; preds = %183, %147, %111
  %186 = load i32, ptr %13, align 4
  %187 = icmp ne i32 %186, 0
  br i1 %187, label %189, label %188

188:                                              ; preds = %185
  br label %314

189:                                              ; preds = %185
  %190 = load ptr, ptr %7, align 8
  %191 = getelementptr inbounds %struct.tdefl_compressor, ptr %190, i32 0, i32 36
  %192 = getelementptr inbounds [33025 x i8], ptr %191, i64 0, i64 0
  %193 = load i32, ptr %16, align 4
  %194 = zext i32 %193 to i64
  %195 = getelementptr inbounds i8, ptr %192, i64 %194
  store ptr %195, ptr %22, align 8
  %196 = load ptr, ptr %22, align 8
  %197 = load i32, ptr %196, align 2
  %198 = add i32 %197, 0
  %199 = load i32, ptr %24, align 2
  %200 = add i32 %199, 0
  %201 = icmp ne i32 %198, %200
  br i1 %201, label %202, label %203

202:                                              ; preds = %189
  br label %70

203:                                              ; preds = %189
  %204 = load ptr, ptr %20, align 8
  store ptr %204, ptr %21, align 8
  store i32 32, ptr %18, align 4
  br label %205

205:                                              ; preds = %250, %203
  br label %206

206:                                              ; preds = %205
  %207 = load ptr, ptr %21, align 8
  %208 = getelementptr inbounds i32, ptr %207, i32 1
  store ptr %208, ptr %21, align 8
  %209 = load i32, ptr %208, align 2
  %210 = add i32 %209, 0
  %211 = load ptr, ptr %22, align 8
  %212 = getelementptr inbounds i32, ptr %211, i32 1
  store ptr %212, ptr %22, align 8
  %213 = load i32, ptr %212, align 2
  %214 = add i32 %213, 0
  %215 = icmp eq i32 %210, %214
  br i1 %215, label %216, label %250

216:                                              ; preds = %206
  %217 = load ptr, ptr %21, align 8
  %218 = getelementptr inbounds i32, ptr %217, i32 1
  store ptr %218, ptr %21, align 8
  %219 = load i32, ptr %218, align 2
  %220 = add i32 %219, 0
  %221 = load ptr, ptr %22, align 8
  %222 = getelementptr inbounds i32, ptr %221, i32 1
  store ptr %222, ptr %22, align 8
  %223 = load i32, ptr %222, align 2
  %224 = add i32 %223, 0
  %225 = icmp eq i32 %220, %224
  br i1 %225, label %226, label %250

226:                                              ; preds = %216
  %227 = load ptr, ptr %21, align 8
  %228 = getelementptr inbounds i32, ptr %227, i32 1
  store ptr %228, ptr %21, align 8
  %229 = load i32, ptr %228, align 2
  %230 = add i32 %229, 0
  %231 = load ptr, ptr %22, align 8
  %232 = getelementptr inbounds i32, ptr %231, i32 1
  store ptr %232, ptr %22, align 8
  %233 = load i32, ptr %232, align 2
  %234 = add i32 %233, 0
  %235 = icmp eq i32 %230, %234
  br i1 %235, label %236, label %250

236:                                              ; preds = %226
  %237 = load ptr, ptr %21, align 8
  %238 = getelementptr inbounds i32, ptr %237, i32 1
  store ptr %238, ptr %21, align 8
  %239 = load i32, ptr %238, align 2
  %240 = add i32 %239, 0
  %241 = load ptr, ptr %22, align 8
  %242 = getelementptr inbounds i32, ptr %241, i32 1
  store ptr %242, ptr %22, align 8
  %243 = load i32, ptr %242, align 2
  %244 = add i32 %243, 0
  %245 = icmp eq i32 %240, %244
  br i1 %245, label %246, label %250

246:                                              ; preds = %236
  %247 = load i32, ptr %18, align 4
  %248 = add i32 %247, -1
  store i32 %248, ptr %18, align 4
  %249 = icmp ugt i32 %248, 0
  br label %250

250:                                              ; preds = %246, %236, %226, %216, %206
  %251 = phi i1 [ false, %236 ], [ false, %226 ], [ false, %216 ], [ false, %206 ], [ %249, %246 ]
  br i1 %251, label %205, label %252, !llvm.loop !96

252:                                              ; preds = %250
  %253 = load i32, ptr %18, align 4
  %254 = icmp ne i32 %253, 0
  br i1 %254, label %266, label %255

255:                                              ; preds = %252
  %256 = load i32, ptr %13, align 4
  %257 = load ptr, ptr %11, align 8
  store i32 %256, ptr %257, align 4
  %258 = load i32, ptr %10, align 4
  %259 = icmp ult i32 %258, 258
  br i1 %259, label %260, label %262

260:                                              ; preds = %255
  %261 = load i32, ptr %10, align 4
  br label %263

262:                                              ; preds = %255
  br label %263

263:                                              ; preds = %262, %260
  %264 = phi i32 [ %261, %260 ], [ 258, %262 ]
  %265 = load ptr, ptr %12, align 8
  store i32 %264, ptr %265, align 4
  br label %314

266:                                              ; preds = %252
  %267 = load ptr, ptr %21, align 8
  %268 = load ptr, ptr %20, align 8
  %269 = ptrtoint ptr %267 to i64
  %270 = ptrtoint ptr %268 to i64
  %271 = sub i64 %269, %270
  %272 = sdiv exact i64 %271, 2
  %273 = trunc i64 %272 to i32
  %274 = mul i32 %273, 2
  %275 = load ptr, ptr %21, align 8
  %276 = load i8, ptr %275, align 1
  %277 = zext i8 %276 to i32
  %278 = load ptr, ptr %22, align 8
  %279 = load i8, ptr %278, align 1
  %280 = zext i8 %279 to i32
  %281 = icmp eq i32 %277, %280
  %282 = zext i1 %281 to i32
  %283 = add i32 %274, %282
  store i32 %283, ptr %18, align 4
  %284 = load i32, ptr %15, align 4
  %285 = icmp ugt i32 %283, %284
  br i1 %285, label %286, label %312

286:                                              ; preds = %266
  %287 = load i32, ptr %13, align 4
  %288 = load ptr, ptr %11, align 8
  store i32 %287, ptr %288, align 4
  %289 = load i32, ptr %10, align 4
  %290 = load i32, ptr %18, align 4
  %291 = icmp ult i32 %289, %290
  br i1 %291, label %292, label %294

292:                                              ; preds = %286
  %293 = load i32, ptr %10, align 4
  br label %296

294:                                              ; preds = %286
  %295 = load i32, ptr %18, align 4
  br label %296

296:                                              ; preds = %294, %292
  %297 = phi i32 [ %293, %292 ], [ %295, %294 ]
  store i32 %297, ptr %15, align 4
  %298 = load ptr, ptr %12, align 8
  store i32 %297, ptr %298, align 4
  %299 = load i32, ptr %10, align 4
  %300 = icmp eq i32 %297, %299
  br i1 %300, label %301, label %302

301:                                              ; preds = %296
  br label %314

302:                                              ; preds = %296
  %303 = load ptr, ptr %7, align 8
  %304 = getelementptr inbounds %struct.tdefl_compressor, ptr %303, i32 0, i32 36
  %305 = load i32, ptr %14, align 4
  %306 = load i32, ptr %15, align 4
  %307 = add i32 %305, %306
  %308 = sub i32 %307, 1
  %309 = zext i32 %308 to i64
  %310 = getelementptr inbounds [33025 x i8], ptr %304, i64 0, i64 %309
  %311 = load i32, ptr %310, align 1
  store i32 %311, ptr %23, align 2
  br label %312

312:                                              ; preds = %302, %266
  br label %313

313:                                              ; preds = %312
  br label %70

314:                                              ; preds = %68, %75, %94, %130, %166, %301, %263, %188
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_record_literal(ptr noundef %0, i8 noundef zeroext %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i8, align 1
  store ptr %0, ptr %3, align 8
  store i8 %1, ptr %4, align 1
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.tdefl_compressor, ptr %5, i32 0, i32 15
  %7 = load i32, ptr %6, align 4
  %8 = add i32 %7, 1
  store i32 %8, ptr %6, align 4
  %9 = load i8, ptr %4, align 1
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.tdefl_compressor, ptr %10, i32 0, i32 10
  %12 = load ptr, ptr %11, align 8
  %13 = getelementptr inbounds i8, ptr %12, i32 1
  store ptr %13, ptr %11, align 8
  store i8 %9, ptr %12, align 1
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.tdefl_compressor, ptr %14, i32 0, i32 11
  %16 = load ptr, ptr %15, align 8
  %17 = load i8, ptr %16, align 1
  %18 = zext i8 %17 to i32
  %19 = ashr i32 %18, 1
  %20 = trunc i32 %19 to i8
  %21 = load ptr, ptr %3, align 8
  %22 = getelementptr inbounds %struct.tdefl_compressor, ptr %21, i32 0, i32 11
  %23 = load ptr, ptr %22, align 8
  store i8 %20, ptr %23, align 1
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds %struct.tdefl_compressor, ptr %24, i32 0, i32 14
  %26 = load i32, ptr %25, align 8
  %27 = add i32 %26, -1
  store i32 %27, ptr %25, align 8
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %38

29:                                               ; preds = %2
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.tdefl_compressor, ptr %30, i32 0, i32 14
  store i32 8, ptr %31, align 8
  %32 = load ptr, ptr %3, align 8
  %33 = getelementptr inbounds %struct.tdefl_compressor, ptr %32, i32 0, i32 10
  %34 = load ptr, ptr %33, align 8
  %35 = getelementptr inbounds i8, ptr %34, i32 1
  store ptr %35, ptr %33, align 8
  %36 = load ptr, ptr %3, align 8
  %37 = getelementptr inbounds %struct.tdefl_compressor, ptr %36, i32 0, i32 11
  store ptr %34, ptr %37, align 8
  br label %38

38:                                               ; preds = %29, %2
  %39 = load ptr, ptr %3, align 8
  %40 = getelementptr inbounds %struct.tdefl_compressor, ptr %39, i32 0, i32 37
  %41 = getelementptr inbounds [3 x [288 x i32]], ptr %40, i64 0, i64 0
  %42 = load i8, ptr %4, align 1
  %43 = zext i8 %42 to i64
  %44 = getelementptr inbounds [288 x i32], ptr %41, i64 0, i64 %43
  %45 = load i32, ptr %44, align 2
  %46 = add i32 %45, 1
  store i32 %46, ptr %44, align 2
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_record_match(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %5, align 4
  %10 = icmp uge i32 %9, 3
  br i1 %10, label %11, label %17

11:                                               ; preds = %3
  %12 = load i32, ptr %6, align 4
  %13 = icmp uge i32 %12, 1
  br i1 %13, label %14, label %17

14:                                               ; preds = %11
  %15 = load i32, ptr %6, align 4
  %16 = icmp ule i32 %15, 32768
  br label %17

17:                                               ; preds = %14, %11, %3
  %18 = phi i1 [ false, %11 ], [ false, %3 ], [ %16, %14 ]
  %19 = xor i1 %18, true
  %20 = zext i1 %19 to i32
  %21 = sext i32 %20 to i64
  %22 = icmp ne i64 %21, 0
  br i1 %22, label %23, label %25

23:                                               ; preds = %17
  call void @__assert_rtn(ptr noundef @__func__.tdefl_record_match, ptr noundef @.str.14, i32 noundef 2135, ptr noundef @.str.36) #14
  unreachable

24:                                               ; No predecessors!
  br label %26

25:                                               ; preds = %17
  br label %26

26:                                               ; preds = %25, %24
  %27 = load i32, ptr %5, align 4
  %28 = load ptr, ptr %4, align 8
  %29 = getelementptr inbounds %struct.tdefl_compressor, ptr %28, i32 0, i32 15
  %30 = load i32, ptr %29, align 4
  %31 = add i32 %30, %27
  store i32 %31, ptr %29, align 4
  %32 = load i32, ptr %5, align 4
  %33 = sub i32 %32, 3
  %34 = trunc i32 %33 to i8
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds %struct.tdefl_compressor, ptr %35, i32 0, i32 10
  %37 = load ptr, ptr %36, align 8
  %38 = getelementptr inbounds i8, ptr %37, i64 0
  store i8 %34, ptr %38, align 1
  %39 = load i32, ptr %6, align 4
  %40 = sub i32 %39, 1
  store i32 %40, ptr %6, align 4
  %41 = load i32, ptr %6, align 4
  %42 = and i32 %41, 255
  %43 = trunc i32 %42 to i8
  %44 = load ptr, ptr %4, align 8
  %45 = getelementptr inbounds %struct.tdefl_compressor, ptr %44, i32 0, i32 10
  %46 = load ptr, ptr %45, align 8
  %47 = getelementptr inbounds i8, ptr %46, i64 1
  store i8 %43, ptr %47, align 1
  %48 = load i32, ptr %6, align 4
  %49 = lshr i32 %48, 8
  %50 = trunc i32 %49 to i8
  %51 = load ptr, ptr %4, align 8
  %52 = getelementptr inbounds %struct.tdefl_compressor, ptr %51, i32 0, i32 10
  %53 = load ptr, ptr %52, align 8
  %54 = getelementptr inbounds i8, ptr %53, i64 2
  store i8 %50, ptr %54, align 1
  %55 = load ptr, ptr %4, align 8
  %56 = getelementptr inbounds %struct.tdefl_compressor, ptr %55, i32 0, i32 10
  %57 = load ptr, ptr %56, align 8
  %58 = getelementptr inbounds i8, ptr %57, i64 3
  store ptr %58, ptr %56, align 8
  %59 = load ptr, ptr %4, align 8
  %60 = getelementptr inbounds %struct.tdefl_compressor, ptr %59, i32 0, i32 11
  %61 = load ptr, ptr %60, align 8
  %62 = load i8, ptr %61, align 1
  %63 = zext i8 %62 to i32
  %64 = ashr i32 %63, 1
  %65 = or i32 %64, 128
  %66 = trunc i32 %65 to i8
  %67 = load ptr, ptr %4, align 8
  %68 = getelementptr inbounds %struct.tdefl_compressor, ptr %67, i32 0, i32 11
  %69 = load ptr, ptr %68, align 8
  store i8 %66, ptr %69, align 1
  %70 = load ptr, ptr %4, align 8
  %71 = getelementptr inbounds %struct.tdefl_compressor, ptr %70, i32 0, i32 14
  %72 = load i32, ptr %71, align 8
  %73 = add i32 %72, -1
  store i32 %73, ptr %71, align 8
  %74 = icmp eq i32 %73, 0
  br i1 %74, label %75, label %84

75:                                               ; preds = %26
  %76 = load ptr, ptr %4, align 8
  %77 = getelementptr inbounds %struct.tdefl_compressor, ptr %76, i32 0, i32 14
  store i32 8, ptr %77, align 8
  %78 = load ptr, ptr %4, align 8
  %79 = getelementptr inbounds %struct.tdefl_compressor, ptr %78, i32 0, i32 10
  %80 = load ptr, ptr %79, align 8
  %81 = getelementptr inbounds i8, ptr %80, i32 1
  store ptr %81, ptr %79, align 8
  %82 = load ptr, ptr %4, align 8
  %83 = getelementptr inbounds %struct.tdefl_compressor, ptr %82, i32 0, i32 11
  store ptr %80, ptr %83, align 8
  br label %84

84:                                               ; preds = %75, %26
  %85 = load i32, ptr %6, align 4
  %86 = and i32 %85, 511
  %87 = zext i32 %86 to i64
  %88 = getelementptr inbounds [512 x i8], ptr @s_tdefl_small_dist_sym, i64 0, i64 %87
  %89 = load i8, ptr %88, align 1
  %90 = zext i8 %89 to i32
  store i32 %90, ptr %7, align 4
  %91 = load i32, ptr %6, align 4
  %92 = lshr i32 %91, 8
  %93 = zext i32 %92 to i64
  %94 = getelementptr inbounds [128 x i8], ptr @s_tdefl_large_dist_sym, i64 0, i64 %93
  %95 = load i8, ptr %94, align 1
  %96 = zext i8 %95 to i32
  store i32 %96, ptr %8, align 4
  %97 = load ptr, ptr %4, align 8
  %98 = getelementptr inbounds %struct.tdefl_compressor, ptr %97, i32 0, i32 37
  %99 = getelementptr inbounds [3 x [288 x i32]], ptr %98, i64 0, i64 1
  %100 = load i32, ptr %6, align 4
  %101 = icmp ult i32 %100, 512
  br i1 %101, label %102, label %104

102:                                              ; preds = %84
  %103 = load i32, ptr %7, align 4
  br label %106

104:                                              ; preds = %84
  %105 = load i32, ptr %8, align 4
  br label %106

106:                                              ; preds = %104, %102
  %107 = phi i32 [ %103, %102 ], [ %105, %104 ]
  %108 = zext i32 %107 to i64
  %109 = getelementptr inbounds [288 x i32], ptr %99, i64 0, i64 %108
  %110 = load i32, ptr %109, align 2
  %111 = add i32 %110, 1
  store i32 %111, ptr %109, align 2
  %112 = load ptr, ptr %4, align 8
  %113 = getelementptr inbounds %struct.tdefl_compressor, ptr %112, i32 0, i32 37
  %114 = getelementptr inbounds [3 x [288 x i32]], ptr %113, i64 0, i64 0
  %115 = load i32, ptr %5, align 4
  %116 = sub i32 %115, 3
  %117 = zext i32 %116 to i64
  %118 = getelementptr inbounds [256 x i32], ptr @s_tdefl_len_sym, i64 0, i64 %117
  %119 = load i32, ptr %118, align 2
  %120 = zext i32 %119 to i64
  %121 = getelementptr inbounds [288 x i32], ptr %114, i64 0, i64 %120
  %122 = load i32, ptr %121, align 2
  %123 = add i32 %122, 1
  store i32 %123, ptr %121, align 2
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_compress_block(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %4, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %2
  %8 = load ptr, ptr %3, align 8
  call void @tdefl_start_static_block(ptr noundef %8)
  br label %11

9:                                                ; preds = %2
  %10 = load ptr, ptr %3, align 8
  call void @tdefl_start_dynamic_block(ptr noundef %10)
  br label %11

11:                                               ; preds = %9, %7
  %12 = load ptr, ptr %3, align 8
  %13 = call i32 @tdefl_compress_lz_codes(ptr noundef %12)
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_start_static_block(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.tdefl_compressor, ptr %7, i32 0, i32 39
  %9 = getelementptr inbounds [3 x [288 x i8]], ptr %8, i64 0, i64 0
  %10 = getelementptr inbounds [288 x i8], ptr %9, i64 0, i64 0
  store ptr %10, ptr %4, align 8
  store i32 0, ptr %3, align 4
  br label %11

11:                                               ; preds = %17, %1
  %12 = load i32, ptr %3, align 4
  %13 = icmp ule i32 %12, 143
  br i1 %13, label %14, label %20

14:                                               ; preds = %11
  %15 = load ptr, ptr %4, align 8
  %16 = getelementptr inbounds i8, ptr %15, i32 1
  store ptr %16, ptr %4, align 8
  store i8 8, ptr %15, align 1
  br label %17

17:                                               ; preds = %14
  %18 = load i32, ptr %3, align 4
  %19 = add i32 %18, 1
  store i32 %19, ptr %3, align 4
  br label %11, !llvm.loop !97

20:                                               ; preds = %11
  br label %21

21:                                               ; preds = %27, %20
  %22 = load i32, ptr %3, align 4
  %23 = icmp ule i32 %22, 255
  br i1 %23, label %24, label %30

24:                                               ; preds = %21
  %25 = load ptr, ptr %4, align 8
  %26 = getelementptr inbounds i8, ptr %25, i32 1
  store ptr %26, ptr %4, align 8
  store i8 9, ptr %25, align 1
  br label %27

27:                                               ; preds = %24
  %28 = load i32, ptr %3, align 4
  %29 = add i32 %28, 1
  store i32 %29, ptr %3, align 4
  br label %21, !llvm.loop !98

30:                                               ; preds = %21
  br label %31

31:                                               ; preds = %37, %30
  %32 = load i32, ptr %3, align 4
  %33 = icmp ule i32 %32, 279
  br i1 %33, label %34, label %40

34:                                               ; preds = %31
  %35 = load ptr, ptr %4, align 8
  %36 = getelementptr inbounds i8, ptr %35, i32 1
  store ptr %36, ptr %4, align 8
  store i8 7, ptr %35, align 1
  br label %37

37:                                               ; preds = %34
  %38 = load i32, ptr %3, align 4
  %39 = add i32 %38, 1
  store i32 %39, ptr %3, align 4
  br label %31, !llvm.loop !99

40:                                               ; preds = %31
  br label %41

41:                                               ; preds = %47, %40
  %42 = load i32, ptr %3, align 4
  %43 = icmp ule i32 %42, 287
  br i1 %43, label %44, label %50

44:                                               ; preds = %41
  %45 = load ptr, ptr %4, align 8
  %46 = getelementptr inbounds i8, ptr %45, i32 1
  store ptr %46, ptr %4, align 8
  store i8 8, ptr %45, align 1
  br label %47

47:                                               ; preds = %44
  %48 = load i32, ptr %3, align 4
  %49 = add i32 %48, 1
  store i32 %49, ptr %3, align 4
  br label %41, !llvm.loop !100

50:                                               ; preds = %41
  %51 = load ptr, ptr %2, align 8
  %52 = getelementptr inbounds %struct.tdefl_compressor, ptr %51, i32 0, i32 39
  %53 = getelementptr inbounds [3 x [288 x i8]], ptr %52, i64 0, i64 1
  %54 = getelementptr inbounds [288 x i8], ptr %53, i64 0, i64 0
  %55 = load ptr, ptr %2, align 8
  %56 = getelementptr inbounds %struct.tdefl_compressor, ptr %55, i32 0, i32 39
  %57 = getelementptr inbounds [3 x [288 x i8]], ptr %56, i64 0, i64 1
  %58 = getelementptr inbounds [288 x i8], ptr %57, i64 0, i64 0
  %59 = call i64 @llvm.objectsize.i64.p0(ptr %58, i1 false, i1 true, i1 false)
  %60 = call ptr @__memset_chk(ptr noundef %54, i32 noundef 5, i64 noundef 32, i64 noundef %59) #12
  %61 = load ptr, ptr %2, align 8
  call void @tdefl_optimize_huffman_table(ptr noundef %61, i32 noundef 0, i32 noundef 288, i32 noundef 15, i32 noundef 1)
  %62 = load ptr, ptr %2, align 8
  call void @tdefl_optimize_huffman_table(ptr noundef %62, i32 noundef 1, i32 noundef 32, i32 noundef 15, i32 noundef 1)
  br label %63

63:                                               ; preds = %50
  store i32 1, ptr %5, align 4
  store i32 2, ptr %6, align 4
  %64 = load i32, ptr %5, align 4
  %65 = load i32, ptr %6, align 4
  %66 = shl i32 1, %65
  %67 = sub i32 %66, 1
  %68 = icmp ule i32 %64, %67
  %69 = xor i1 %68, true
  %70 = zext i1 %69 to i32
  %71 = sext i32 %70 to i64
  %72 = icmp ne i64 %71, 0
  br i1 %72, label %73, label %75

73:                                               ; preds = %63
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_static_block, ptr noundef @.str.14, i32 noundef 1668, ptr noundef @.str.38) #14
  unreachable

74:                                               ; No predecessors!
  br label %76

75:                                               ; preds = %63
  br label %76

76:                                               ; preds = %75, %74
  %77 = load i32, ptr %5, align 4
  %78 = load ptr, ptr %2, align 8
  %79 = getelementptr inbounds %struct.tdefl_compressor, ptr %78, i32 0, i32 17
  %80 = load i32, ptr %79, align 4
  %81 = shl i32 %77, %80
  %82 = load ptr, ptr %2, align 8
  %83 = getelementptr inbounds %struct.tdefl_compressor, ptr %82, i32 0, i32 18
  %84 = load i32, ptr %83, align 8
  %85 = or i32 %84, %81
  store i32 %85, ptr %83, align 8
  %86 = load i32, ptr %6, align 4
  %87 = load ptr, ptr %2, align 8
  %88 = getelementptr inbounds %struct.tdefl_compressor, ptr %87, i32 0, i32 17
  %89 = load i32, ptr %88, align 4
  %90 = add i32 %89, %86
  store i32 %90, ptr %88, align 4
  br label %91

91:                                               ; preds = %113, %76
  %92 = load ptr, ptr %2, align 8
  %93 = getelementptr inbounds %struct.tdefl_compressor, ptr %92, i32 0, i32 17
  %94 = load i32, ptr %93, align 4
  %95 = icmp uge i32 %94, 8
  br i1 %95, label %96, label %122

96:                                               ; preds = %91
  %97 = load ptr, ptr %2, align 8
  %98 = getelementptr inbounds %struct.tdefl_compressor, ptr %97, i32 0, i32 12
  %99 = load ptr, ptr %98, align 8
  %100 = load ptr, ptr %2, align 8
  %101 = getelementptr inbounds %struct.tdefl_compressor, ptr %100, i32 0, i32 13
  %102 = load ptr, ptr %101, align 8
  %103 = icmp ult ptr %99, %102
  br i1 %103, label %104, label %113

104:                                              ; preds = %96
  %105 = load ptr, ptr %2, align 8
  %106 = getelementptr inbounds %struct.tdefl_compressor, ptr %105, i32 0, i32 18
  %107 = load i32, ptr %106, align 8
  %108 = trunc i32 %107 to i8
  %109 = load ptr, ptr %2, align 8
  %110 = getelementptr inbounds %struct.tdefl_compressor, ptr %109, i32 0, i32 12
  %111 = load ptr, ptr %110, align 8
  %112 = getelementptr inbounds i8, ptr %111, i32 1
  store ptr %112, ptr %110, align 8
  store i8 %108, ptr %111, align 1
  br label %113

113:                                              ; preds = %104, %96
  %114 = load ptr, ptr %2, align 8
  %115 = getelementptr inbounds %struct.tdefl_compressor, ptr %114, i32 0, i32 18
  %116 = load i32, ptr %115, align 8
  %117 = lshr i32 %116, 8
  store i32 %117, ptr %115, align 8
  %118 = load ptr, ptr %2, align 8
  %119 = getelementptr inbounds %struct.tdefl_compressor, ptr %118, i32 0, i32 17
  %120 = load i32, ptr %119, align 4
  %121 = sub i32 %120, 8
  store i32 %121, ptr %119, align 4
  br label %91, !llvm.loop !101

122:                                              ; preds = %91
  br label %123

123:                                              ; preds = %122
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_start_dynamic_block(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca [320 x i8], align 16
  %13 = alloca [320 x i8], align 16
  %14 = alloca i8, align 1
  %15 = alloca i8, align 1
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca i32, align 4
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  store i8 -1, ptr %14, align 1
  %31 = load ptr, ptr %2, align 8
  %32 = getelementptr inbounds %struct.tdefl_compressor, ptr %31, i32 0, i32 37
  %33 = getelementptr inbounds [3 x [288 x i32]], ptr %32, i64 0, i64 0
  %34 = getelementptr inbounds [288 x i32], ptr %33, i64 0, i64 256
  store i32 1, ptr %34, align 2
  %35 = load ptr, ptr %2, align 8
  call void @tdefl_optimize_huffman_table(ptr noundef %35, i32 noundef 0, i32 noundef 288, i32 noundef 15, i32 noundef 0)
  %36 = load ptr, ptr %2, align 8
  call void @tdefl_optimize_huffman_table(ptr noundef %36, i32 noundef 1, i32 noundef 32, i32 noundef 15, i32 noundef 0)
  store i32 286, ptr %3, align 4
  br label %37

37:                                               ; preds = %52, %1
  %38 = load i32, ptr %3, align 4
  %39 = icmp sgt i32 %38, 257
  br i1 %39, label %40, label %55

40:                                               ; preds = %37
  %41 = load ptr, ptr %2, align 8
  %42 = getelementptr inbounds %struct.tdefl_compressor, ptr %41, i32 0, i32 39
  %43 = getelementptr inbounds [3 x [288 x i8]], ptr %42, i64 0, i64 0
  %44 = load i32, ptr %3, align 4
  %45 = sub nsw i32 %44, 1
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [288 x i8], ptr %43, i64 0, i64 %46
  %48 = load i8, ptr %47, align 1
  %49 = icmp ne i8 %48, 0
  br i1 %49, label %50, label %51

50:                                               ; preds = %40
  br label %55

51:                                               ; preds = %40
  br label %52

52:                                               ; preds = %51
  %53 = load i32, ptr %3, align 4
  %54 = add nsw i32 %53, -1
  store i32 %54, ptr %3, align 4
  br label %37, !llvm.loop !102

55:                                               ; preds = %50, %37
  store i32 30, ptr %4, align 4
  br label %56

56:                                               ; preds = %71, %55
  %57 = load i32, ptr %4, align 4
  %58 = icmp sgt i32 %57, 1
  br i1 %58, label %59, label %74

59:                                               ; preds = %56
  %60 = load ptr, ptr %2, align 8
  %61 = getelementptr inbounds %struct.tdefl_compressor, ptr %60, i32 0, i32 39
  %62 = getelementptr inbounds [3 x [288 x i8]], ptr %61, i64 0, i64 1
  %63 = load i32, ptr %4, align 4
  %64 = sub nsw i32 %63, 1
  %65 = sext i32 %64 to i64
  %66 = getelementptr inbounds [288 x i8], ptr %62, i64 0, i64 %65
  %67 = load i8, ptr %66, align 1
  %68 = icmp ne i8 %67, 0
  br i1 %68, label %69, label %70

69:                                               ; preds = %59
  br label %74

70:                                               ; preds = %59
  br label %71

71:                                               ; preds = %70
  %72 = load i32, ptr %4, align 4
  %73 = add nsw i32 %72, -1
  store i32 %73, ptr %4, align 4
  br label %56, !llvm.loop !103

74:                                               ; preds = %69, %56
  %75 = getelementptr inbounds [320 x i8], ptr %12, i64 0, i64 0
  %76 = load ptr, ptr %2, align 8
  %77 = getelementptr inbounds %struct.tdefl_compressor, ptr %76, i32 0, i32 39
  %78 = getelementptr inbounds [3 x [288 x i8]], ptr %77, i64 0, i64 0
  %79 = getelementptr inbounds [288 x i8], ptr %78, i64 0, i64 0
  %80 = load i32, ptr %3, align 4
  %81 = sext i32 %80 to i64
  %82 = call ptr @__memcpy_chk(ptr noundef %75, ptr noundef %79, i64 noundef %81, i64 noundef 320) #12
  %83 = getelementptr inbounds [320 x i8], ptr %12, i64 0, i64 0
  %84 = load i32, ptr %3, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds i8, ptr %83, i64 %85
  %87 = load ptr, ptr %2, align 8
  %88 = getelementptr inbounds %struct.tdefl_compressor, ptr %87, i32 0, i32 39
  %89 = getelementptr inbounds [3 x [288 x i8]], ptr %88, i64 0, i64 1
  %90 = getelementptr inbounds [288 x i8], ptr %89, i64 0, i64 0
  %91 = load i32, ptr %4, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [320 x i8], ptr %12, i64 0, i64 0
  %94 = load i32, ptr %3, align 4
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i8, ptr %93, i64 %95
  %97 = call i64 @llvm.objectsize.i64.p0(ptr %96, i1 false, i1 true, i1 false)
  %98 = call ptr @__memcpy_chk(ptr noundef %86, ptr noundef %90, i64 noundef %92, i64 noundef %97) #12
  %99 = load i32, ptr %3, align 4
  %100 = load i32, ptr %4, align 4
  %101 = add nsw i32 %99, %100
  store i32 %101, ptr %7, align 4
  store i32 0, ptr %8, align 4
  store i32 0, ptr %9, align 4
  store i32 0, ptr %10, align 4
  %102 = load ptr, ptr %2, align 8
  %103 = getelementptr inbounds %struct.tdefl_compressor, ptr %102, i32 0, i32 37
  %104 = getelementptr inbounds [3 x [288 x i32]], ptr %103, i64 0, i64 2
  %105 = getelementptr inbounds [288 x i32], ptr %104, i64 0, i64 0
  %106 = load ptr, ptr %2, align 8
  %107 = getelementptr inbounds %struct.tdefl_compressor, ptr %106, i32 0, i32 37
  %108 = getelementptr inbounds [3 x [288 x i32]], ptr %107, i64 0, i64 2
  %109 = getelementptr inbounds [288 x i32], ptr %108, i64 0, i64 0
  %110 = call i64 @llvm.objectsize.i64.p0(ptr %109, i1 false, i1 true, i1 false)
  %111 = call ptr @__memset_chk(ptr noundef %105, i32 noundef 0, i64 noundef 38, i64 noundef %110) #12
  store i32 0, ptr %6, align 4
  br label %112

112:                                              ; preds = %512, %74
  %113 = load i32, ptr %6, align 4
  %114 = load i32, ptr %7, align 4
  %115 = icmp ult i32 %113, %114
  br i1 %115, label %116, label %515

116:                                              ; preds = %112
  %117 = load i32, ptr %6, align 4
  %118 = zext i32 %117 to i64
  %119 = getelementptr inbounds [320 x i8], ptr %12, i64 0, i64 %118
  %120 = load i8, ptr %119, align 1
  store i8 %120, ptr %15, align 1
  %121 = load i8, ptr %15, align 1
  %122 = icmp ne i8 %121, 0
  br i1 %122, label %272, label %123

123:                                              ; preds = %116
  %124 = load i32, ptr %10, align 4
  %125 = icmp ne i32 %124, 0
  br i1 %125, label %126, label %183

126:                                              ; preds = %123
  %127 = load i32, ptr %10, align 4
  %128 = icmp ult i32 %127, 3
  br i1 %128, label %129, label %158

129:                                              ; preds = %126
  %130 = load ptr, ptr %2, align 8
  %131 = getelementptr inbounds %struct.tdefl_compressor, ptr %130, i32 0, i32 37
  %132 = getelementptr inbounds [3 x [288 x i32]], ptr %131, i64 0, i64 2
  %133 = load i8, ptr %14, align 1
  %134 = zext i8 %133 to i64
  %135 = getelementptr inbounds [288 x i32], ptr %132, i64 0, i64 %134
  %136 = load i32, ptr %135, align 2
  %137 = add i32 %136, 0
  %138 = load i32, ptr %10, align 4
  %139 = add i32 %137, %138
  %140 = add i32 %139, 0
  %141 = load ptr, ptr %2, align 8
  %142 = getelementptr inbounds %struct.tdefl_compressor, ptr %141, i32 0, i32 37
  %143 = getelementptr inbounds [3 x [288 x i32]], ptr %142, i64 0, i64 2
  %144 = load i8, ptr %14, align 1
  %145 = zext i8 %144 to i64
  %146 = getelementptr inbounds [288 x i32], ptr %143, i64 0, i64 %145
  store i32 %140, ptr %146, align 2
  br label %147

147:                                              ; preds = %151, %129
  %148 = load i32, ptr %10, align 4
  %149 = add i32 %148, -1
  store i32 %149, ptr %10, align 4
  %150 = icmp ne i32 %148, 0
  br i1 %150, label %151, label %157

151:                                              ; preds = %147
  %152 = load i8, ptr %14, align 1
  %153 = load i32, ptr %8, align 4
  %154 = add i32 %153, 1
  store i32 %154, ptr %8, align 4
  %155 = zext i32 %153 to i64
  %156 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %155
  store i8 %152, ptr %156, align 1
  br label %147, !llvm.loop !104

157:                                              ; preds = %147
  br label %182

158:                                              ; preds = %126
  %159 = load ptr, ptr %2, align 8
  %160 = getelementptr inbounds %struct.tdefl_compressor, ptr %159, i32 0, i32 37
  %161 = getelementptr inbounds [3 x [288 x i32]], ptr %160, i64 0, i64 2
  %162 = getelementptr inbounds [288 x i32], ptr %161, i64 0, i64 16
  %163 = load i32, ptr %162, align 2
  %164 = add i32 %163, 0
  %165 = add nsw i32 %164, 1
  %166 = add i32 %165, 0
  %167 = load ptr, ptr %2, align 8
  %168 = getelementptr inbounds %struct.tdefl_compressor, ptr %167, i32 0, i32 37
  %169 = getelementptr inbounds [3 x [288 x i32]], ptr %168, i64 0, i64 2
  %170 = getelementptr inbounds [288 x i32], ptr %169, i64 0, i64 16
  store i32 %166, ptr %170, align 2
  %171 = load i32, ptr %8, align 4
  %172 = add i32 %171, 1
  store i32 %172, ptr %8, align 4
  %173 = zext i32 %171 to i64
  %174 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %173
  store i8 16, ptr %174, align 1
  %175 = load i32, ptr %10, align 4
  %176 = sub i32 %175, 3
  %177 = trunc i32 %176 to i8
  %178 = load i32, ptr %8, align 4
  %179 = add i32 %178, 1
  store i32 %179, ptr %8, align 4
  %180 = zext i32 %178 to i64
  %181 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %180
  store i8 %177, ptr %181, align 1
  br label %182

182:                                              ; preds = %158, %157
  store i32 0, ptr %10, align 4
  br label %183

183:                                              ; preds = %182, %123
  %184 = load i32, ptr %9, align 4
  %185 = add i32 %184, 1
  store i32 %185, ptr %9, align 4
  %186 = icmp eq i32 %185, 138
  br i1 %186, label %187, label %271

187:                                              ; preds = %183
  %188 = load i32, ptr %9, align 4
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %190, label %270

190:                                              ; preds = %187
  %191 = load i32, ptr %9, align 4
  %192 = icmp ult i32 %191, 3
  br i1 %192, label %193, label %217

193:                                              ; preds = %190
  %194 = load ptr, ptr %2, align 8
  %195 = getelementptr inbounds %struct.tdefl_compressor, ptr %194, i32 0, i32 37
  %196 = getelementptr inbounds [3 x [288 x i32]], ptr %195, i64 0, i64 2
  %197 = getelementptr inbounds [288 x i32], ptr %196, i64 0, i64 0
  %198 = load i32, ptr %197, align 2
  %199 = add i32 %198, 0
  %200 = load i32, ptr %9, align 4
  %201 = add i32 %199, %200
  %202 = add i32 %201, 0
  %203 = load ptr, ptr %2, align 8
  %204 = getelementptr inbounds %struct.tdefl_compressor, ptr %203, i32 0, i32 37
  %205 = getelementptr inbounds [3 x [288 x i32]], ptr %204, i64 0, i64 2
  %206 = getelementptr inbounds [288 x i32], ptr %205, i64 0, i64 0
  store i32 %202, ptr %206, align 2
  br label %207

207:                                              ; preds = %211, %193
  %208 = load i32, ptr %9, align 4
  %209 = add i32 %208, -1
  store i32 %209, ptr %9, align 4
  %210 = icmp ne i32 %208, 0
  br i1 %210, label %211, label %216

211:                                              ; preds = %207
  %212 = load i32, ptr %8, align 4
  %213 = add i32 %212, 1
  store i32 %213, ptr %8, align 4
  %214 = zext i32 %212 to i64
  %215 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %214
  store i8 0, ptr %215, align 1
  br label %207, !llvm.loop !105

216:                                              ; preds = %207
  br label %269

217:                                              ; preds = %190
  %218 = load i32, ptr %9, align 4
  %219 = icmp ule i32 %218, 10
  br i1 %219, label %220, label %244

220:                                              ; preds = %217
  %221 = load ptr, ptr %2, align 8
  %222 = getelementptr inbounds %struct.tdefl_compressor, ptr %221, i32 0, i32 37
  %223 = getelementptr inbounds [3 x [288 x i32]], ptr %222, i64 0, i64 2
  %224 = getelementptr inbounds [288 x i32], ptr %223, i64 0, i64 17
  %225 = load i32, ptr %224, align 2
  %226 = add i32 %225, 0
  %227 = add nsw i32 %226, 1
  %228 = add i32 %227, 0
  %229 = load ptr, ptr %2, align 8
  %230 = getelementptr inbounds %struct.tdefl_compressor, ptr %229, i32 0, i32 37
  %231 = getelementptr inbounds [3 x [288 x i32]], ptr %230, i64 0, i64 2
  %232 = getelementptr inbounds [288 x i32], ptr %231, i64 0, i64 17
  store i32 %228, ptr %232, align 2
  %233 = load i32, ptr %8, align 4
  %234 = add i32 %233, 1
  store i32 %234, ptr %8, align 4
  %235 = zext i32 %233 to i64
  %236 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %235
  store i8 17, ptr %236, align 1
  %237 = load i32, ptr %9, align 4
  %238 = sub i32 %237, 3
  %239 = trunc i32 %238 to i8
  %240 = load i32, ptr %8, align 4
  %241 = add i32 %240, 1
  store i32 %241, ptr %8, align 4
  %242 = zext i32 %240 to i64
  %243 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %242
  store i8 %239, ptr %243, align 1
  br label %268

244:                                              ; preds = %217
  %245 = load ptr, ptr %2, align 8
  %246 = getelementptr inbounds %struct.tdefl_compressor, ptr %245, i32 0, i32 37
  %247 = getelementptr inbounds [3 x [288 x i32]], ptr %246, i64 0, i64 2
  %248 = getelementptr inbounds [288 x i32], ptr %247, i64 0, i64 18
  %249 = load i32, ptr %248, align 2
  %250 = add i32 %249, 0
  %251 = add nsw i32 %250, 1
  %252 = add i32 %251, 0
  %253 = load ptr, ptr %2, align 8
  %254 = getelementptr inbounds %struct.tdefl_compressor, ptr %253, i32 0, i32 37
  %255 = getelementptr inbounds [3 x [288 x i32]], ptr %254, i64 0, i64 2
  %256 = getelementptr inbounds [288 x i32], ptr %255, i64 0, i64 18
  store i32 %252, ptr %256, align 2
  %257 = load i32, ptr %8, align 4
  %258 = add i32 %257, 1
  store i32 %258, ptr %8, align 4
  %259 = zext i32 %257 to i64
  %260 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %259
  store i8 18, ptr %260, align 1
  %261 = load i32, ptr %9, align 4
  %262 = sub i32 %261, 11
  %263 = trunc i32 %262 to i8
  %264 = load i32, ptr %8, align 4
  %265 = add i32 %264, 1
  store i32 %265, ptr %8, align 4
  %266 = zext i32 %264 to i64
  %267 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %266
  store i8 %263, ptr %267, align 1
  br label %268

268:                                              ; preds = %244, %220
  br label %269

269:                                              ; preds = %268, %216
  store i32 0, ptr %9, align 4
  br label %270

270:                                              ; preds = %269, %187
  br label %271

271:                                              ; preds = %270, %183
  br label %510

272:                                              ; preds = %116
  %273 = load i32, ptr %9, align 4
  %274 = icmp ne i32 %273, 0
  br i1 %274, label %275, label %355

275:                                              ; preds = %272
  %276 = load i32, ptr %9, align 4
  %277 = icmp ult i32 %276, 3
  br i1 %277, label %278, label %302

278:                                              ; preds = %275
  %279 = load ptr, ptr %2, align 8
  %280 = getelementptr inbounds %struct.tdefl_compressor, ptr %279, i32 0, i32 37
  %281 = getelementptr inbounds [3 x [288 x i32]], ptr %280, i64 0, i64 2
  %282 = getelementptr inbounds [288 x i32], ptr %281, i64 0, i64 0
  %283 = load i32, ptr %282, align 2
  %284 = add i32 %283, 0
  %285 = load i32, ptr %9, align 4
  %286 = add i32 %284, %285
  %287 = add i32 %286, 0
  %288 = load ptr, ptr %2, align 8
  %289 = getelementptr inbounds %struct.tdefl_compressor, ptr %288, i32 0, i32 37
  %290 = getelementptr inbounds [3 x [288 x i32]], ptr %289, i64 0, i64 2
  %291 = getelementptr inbounds [288 x i32], ptr %290, i64 0, i64 0
  store i32 %287, ptr %291, align 2
  br label %292

292:                                              ; preds = %296, %278
  %293 = load i32, ptr %9, align 4
  %294 = add i32 %293, -1
  store i32 %294, ptr %9, align 4
  %295 = icmp ne i32 %293, 0
  br i1 %295, label %296, label %301

296:                                              ; preds = %292
  %297 = load i32, ptr %8, align 4
  %298 = add i32 %297, 1
  store i32 %298, ptr %8, align 4
  %299 = zext i32 %297 to i64
  %300 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %299
  store i8 0, ptr %300, align 1
  br label %292, !llvm.loop !106

301:                                              ; preds = %292
  br label %354

302:                                              ; preds = %275
  %303 = load i32, ptr %9, align 4
  %304 = icmp ule i32 %303, 10
  br i1 %304, label %305, label %329

305:                                              ; preds = %302
  %306 = load ptr, ptr %2, align 8
  %307 = getelementptr inbounds %struct.tdefl_compressor, ptr %306, i32 0, i32 37
  %308 = getelementptr inbounds [3 x [288 x i32]], ptr %307, i64 0, i64 2
  %309 = getelementptr inbounds [288 x i32], ptr %308, i64 0, i64 17
  %310 = load i32, ptr %309, align 2
  %311 = add i32 %310, 0
  %312 = add nsw i32 %311, 1
  %313 = add i32 %312, 0
  %314 = load ptr, ptr %2, align 8
  %315 = getelementptr inbounds %struct.tdefl_compressor, ptr %314, i32 0, i32 37
  %316 = getelementptr inbounds [3 x [288 x i32]], ptr %315, i64 0, i64 2
  %317 = getelementptr inbounds [288 x i32], ptr %316, i64 0, i64 17
  store i32 %313, ptr %317, align 2
  %318 = load i32, ptr %8, align 4
  %319 = add i32 %318, 1
  store i32 %319, ptr %8, align 4
  %320 = zext i32 %318 to i64
  %321 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %320
  store i8 17, ptr %321, align 1
  %322 = load i32, ptr %9, align 4
  %323 = sub i32 %322, 3
  %324 = trunc i32 %323 to i8
  %325 = load i32, ptr %8, align 4
  %326 = add i32 %325, 1
  store i32 %326, ptr %8, align 4
  %327 = zext i32 %325 to i64
  %328 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %327
  store i8 %324, ptr %328, align 1
  br label %353

329:                                              ; preds = %302
  %330 = load ptr, ptr %2, align 8
  %331 = getelementptr inbounds %struct.tdefl_compressor, ptr %330, i32 0, i32 37
  %332 = getelementptr inbounds [3 x [288 x i32]], ptr %331, i64 0, i64 2
  %333 = getelementptr inbounds [288 x i32], ptr %332, i64 0, i64 18
  %334 = load i32, ptr %333, align 2
  %335 = add i32 %334, 0
  %336 = add nsw i32 %335, 1
  %337 = add i32 %336, 0
  %338 = load ptr, ptr %2, align 8
  %339 = getelementptr inbounds %struct.tdefl_compressor, ptr %338, i32 0, i32 37
  %340 = getelementptr inbounds [3 x [288 x i32]], ptr %339, i64 0, i64 2
  %341 = getelementptr inbounds [288 x i32], ptr %340, i64 0, i64 18
  store i32 %337, ptr %341, align 2
  %342 = load i32, ptr %8, align 4
  %343 = add i32 %342, 1
  store i32 %343, ptr %8, align 4
  %344 = zext i32 %342 to i64
  %345 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %344
  store i8 18, ptr %345, align 1
  %346 = load i32, ptr %9, align 4
  %347 = sub i32 %346, 11
  %348 = trunc i32 %347 to i8
  %349 = load i32, ptr %8, align 4
  %350 = add i32 %349, 1
  store i32 %350, ptr %8, align 4
  %351 = zext i32 %349 to i64
  %352 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %351
  store i8 %348, ptr %352, align 1
  br label %353

353:                                              ; preds = %329, %305
  br label %354

354:                                              ; preds = %353, %301
  store i32 0, ptr %9, align 4
  br label %355

355:                                              ; preds = %354, %272
  %356 = load i8, ptr %15, align 1
  %357 = zext i8 %356 to i32
  %358 = load i8, ptr %14, align 1
  %359 = zext i8 %358 to i32
  %360 = icmp ne i32 %357, %359
  br i1 %360, label %361, label %443

361:                                              ; preds = %355
  %362 = load i32, ptr %10, align 4
  %363 = icmp ne i32 %362, 0
  br i1 %363, label %364, label %421

364:                                              ; preds = %361
  %365 = load i32, ptr %10, align 4
  %366 = icmp ult i32 %365, 3
  br i1 %366, label %367, label %396

367:                                              ; preds = %364
  %368 = load ptr, ptr %2, align 8
  %369 = getelementptr inbounds %struct.tdefl_compressor, ptr %368, i32 0, i32 37
  %370 = getelementptr inbounds [3 x [288 x i32]], ptr %369, i64 0, i64 2
  %371 = load i8, ptr %14, align 1
  %372 = zext i8 %371 to i64
  %373 = getelementptr inbounds [288 x i32], ptr %370, i64 0, i64 %372
  %374 = load i32, ptr %373, align 2
  %375 = add i32 %374, 0
  %376 = load i32, ptr %10, align 4
  %377 = add i32 %375, %376
  %378 = add i32 %377, 0
  %379 = load ptr, ptr %2, align 8
  %380 = getelementptr inbounds %struct.tdefl_compressor, ptr %379, i32 0, i32 37
  %381 = getelementptr inbounds [3 x [288 x i32]], ptr %380, i64 0, i64 2
  %382 = load i8, ptr %14, align 1
  %383 = zext i8 %382 to i64
  %384 = getelementptr inbounds [288 x i32], ptr %381, i64 0, i64 %383
  store i32 %378, ptr %384, align 2
  br label %385

385:                                              ; preds = %389, %367
  %386 = load i32, ptr %10, align 4
  %387 = add i32 %386, -1
  store i32 %387, ptr %10, align 4
  %388 = icmp ne i32 %386, 0
  br i1 %388, label %389, label %395

389:                                              ; preds = %385
  %390 = load i8, ptr %14, align 1
  %391 = load i32, ptr %8, align 4
  %392 = add i32 %391, 1
  store i32 %392, ptr %8, align 4
  %393 = zext i32 %391 to i64
  %394 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %393
  store i8 %390, ptr %394, align 1
  br label %385, !llvm.loop !107

395:                                              ; preds = %385
  br label %420

396:                                              ; preds = %364
  %397 = load ptr, ptr %2, align 8
  %398 = getelementptr inbounds %struct.tdefl_compressor, ptr %397, i32 0, i32 37
  %399 = getelementptr inbounds [3 x [288 x i32]], ptr %398, i64 0, i64 2
  %400 = getelementptr inbounds [288 x i32], ptr %399, i64 0, i64 16
  %401 = load i32, ptr %400, align 2
  %402 = add i32 %401, 0
  %403 = add nsw i32 %402, 1
  %404 = add i32 %403, 0
  %405 = load ptr, ptr %2, align 8
  %406 = getelementptr inbounds %struct.tdefl_compressor, ptr %405, i32 0, i32 37
  %407 = getelementptr inbounds [3 x [288 x i32]], ptr %406, i64 0, i64 2
  %408 = getelementptr inbounds [288 x i32], ptr %407, i64 0, i64 16
  store i32 %404, ptr %408, align 2
  %409 = load i32, ptr %8, align 4
  %410 = add i32 %409, 1
  store i32 %410, ptr %8, align 4
  %411 = zext i32 %409 to i64
  %412 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %411
  store i8 16, ptr %412, align 1
  %413 = load i32, ptr %10, align 4
  %414 = sub i32 %413, 3
  %415 = trunc i32 %414 to i8
  %416 = load i32, ptr %8, align 4
  %417 = add i32 %416, 1
  store i32 %417, ptr %8, align 4
  %418 = zext i32 %416 to i64
  %419 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %418
  store i8 %415, ptr %419, align 1
  br label %420

420:                                              ; preds = %396, %395
  store i32 0, ptr %10, align 4
  br label %421

421:                                              ; preds = %420, %361
  %422 = load ptr, ptr %2, align 8
  %423 = getelementptr inbounds %struct.tdefl_compressor, ptr %422, i32 0, i32 37
  %424 = getelementptr inbounds [3 x [288 x i32]], ptr %423, i64 0, i64 2
  %425 = load i8, ptr %15, align 1
  %426 = zext i8 %425 to i64
  %427 = getelementptr inbounds [288 x i32], ptr %424, i64 0, i64 %426
  %428 = load i32, ptr %427, align 2
  %429 = add i32 %428, 0
  %430 = add nsw i32 %429, 1
  %431 = add i32 %430, 0
  %432 = load ptr, ptr %2, align 8
  %433 = getelementptr inbounds %struct.tdefl_compressor, ptr %432, i32 0, i32 37
  %434 = getelementptr inbounds [3 x [288 x i32]], ptr %433, i64 0, i64 2
  %435 = load i8, ptr %15, align 1
  %436 = zext i8 %435 to i64
  %437 = getelementptr inbounds [288 x i32], ptr %434, i64 0, i64 %436
  store i32 %431, ptr %437, align 2
  %438 = load i8, ptr %15, align 1
  %439 = load i32, ptr %8, align 4
  %440 = add i32 %439, 1
  store i32 %440, ptr %8, align 4
  %441 = zext i32 %439 to i64
  %442 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %441
  store i8 %438, ptr %442, align 1
  br label %509

443:                                              ; preds = %355
  %444 = load i32, ptr %10, align 4
  %445 = add i32 %444, 1
  store i32 %445, ptr %10, align 4
  %446 = icmp eq i32 %445, 6
  br i1 %446, label %447, label %508

447:                                              ; preds = %443
  %448 = load i32, ptr %10, align 4
  %449 = icmp ne i32 %448, 0
  br i1 %449, label %450, label %507

450:                                              ; preds = %447
  %451 = load i32, ptr %10, align 4
  %452 = icmp ult i32 %451, 3
  br i1 %452, label %453, label %482

453:                                              ; preds = %450
  %454 = load ptr, ptr %2, align 8
  %455 = getelementptr inbounds %struct.tdefl_compressor, ptr %454, i32 0, i32 37
  %456 = getelementptr inbounds [3 x [288 x i32]], ptr %455, i64 0, i64 2
  %457 = load i8, ptr %14, align 1
  %458 = zext i8 %457 to i64
  %459 = getelementptr inbounds [288 x i32], ptr %456, i64 0, i64 %458
  %460 = load i32, ptr %459, align 2
  %461 = add i32 %460, 0
  %462 = load i32, ptr %10, align 4
  %463 = add i32 %461, %462
  %464 = add i32 %463, 0
  %465 = load ptr, ptr %2, align 8
  %466 = getelementptr inbounds %struct.tdefl_compressor, ptr %465, i32 0, i32 37
  %467 = getelementptr inbounds [3 x [288 x i32]], ptr %466, i64 0, i64 2
  %468 = load i8, ptr %14, align 1
  %469 = zext i8 %468 to i64
  %470 = getelementptr inbounds [288 x i32], ptr %467, i64 0, i64 %469
  store i32 %464, ptr %470, align 2
  br label %471

471:                                              ; preds = %475, %453
  %472 = load i32, ptr %10, align 4
  %473 = add i32 %472, -1
  store i32 %473, ptr %10, align 4
  %474 = icmp ne i32 %472, 0
  br i1 %474, label %475, label %481

475:                                              ; preds = %471
  %476 = load i8, ptr %14, align 1
  %477 = load i32, ptr %8, align 4
  %478 = add i32 %477, 1
  store i32 %478, ptr %8, align 4
  %479 = zext i32 %477 to i64
  %480 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %479
  store i8 %476, ptr %480, align 1
  br label %471, !llvm.loop !108

481:                                              ; preds = %471
  br label %506

482:                                              ; preds = %450
  %483 = load ptr, ptr %2, align 8
  %484 = getelementptr inbounds %struct.tdefl_compressor, ptr %483, i32 0, i32 37
  %485 = getelementptr inbounds [3 x [288 x i32]], ptr %484, i64 0, i64 2
  %486 = getelementptr inbounds [288 x i32], ptr %485, i64 0, i64 16
  %487 = load i32, ptr %486, align 2
  %488 = add i32 %487, 0
  %489 = add nsw i32 %488, 1
  %490 = add i32 %489, 0
  %491 = load ptr, ptr %2, align 8
  %492 = getelementptr inbounds %struct.tdefl_compressor, ptr %491, i32 0, i32 37
  %493 = getelementptr inbounds [3 x [288 x i32]], ptr %492, i64 0, i64 2
  %494 = getelementptr inbounds [288 x i32], ptr %493, i64 0, i64 16
  store i32 %490, ptr %494, align 2
  %495 = load i32, ptr %8, align 4
  %496 = add i32 %495, 1
  store i32 %496, ptr %8, align 4
  %497 = zext i32 %495 to i64
  %498 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %497
  store i8 16, ptr %498, align 1
  %499 = load i32, ptr %10, align 4
  %500 = sub i32 %499, 3
  %501 = trunc i32 %500 to i8
  %502 = load i32, ptr %8, align 4
  %503 = add i32 %502, 1
  store i32 %503, ptr %8, align 4
  %504 = zext i32 %502 to i64
  %505 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %504
  store i8 %501, ptr %505, align 1
  br label %506

506:                                              ; preds = %482, %481
  store i32 0, ptr %10, align 4
  br label %507

507:                                              ; preds = %506, %447
  br label %508

508:                                              ; preds = %507, %443
  br label %509

509:                                              ; preds = %508, %421
  br label %510

510:                                              ; preds = %509, %271
  %511 = load i8, ptr %15, align 1
  store i8 %511, ptr %14, align 1
  br label %512

512:                                              ; preds = %510
  %513 = load i32, ptr %6, align 4
  %514 = add i32 %513, 1
  store i32 %514, ptr %6, align 4
  br label %112, !llvm.loop !109

515:                                              ; preds = %112
  %516 = load i32, ptr %10, align 4
  %517 = icmp ne i32 %516, 0
  br i1 %517, label %518, label %579

518:                                              ; preds = %515
  %519 = load i32, ptr %10, align 4
  %520 = icmp ne i32 %519, 0
  br i1 %520, label %521, label %578

521:                                              ; preds = %518
  %522 = load i32, ptr %10, align 4
  %523 = icmp ult i32 %522, 3
  br i1 %523, label %524, label %553

524:                                              ; preds = %521
  %525 = load ptr, ptr %2, align 8
  %526 = getelementptr inbounds %struct.tdefl_compressor, ptr %525, i32 0, i32 37
  %527 = getelementptr inbounds [3 x [288 x i32]], ptr %526, i64 0, i64 2
  %528 = load i8, ptr %14, align 1
  %529 = zext i8 %528 to i64
  %530 = getelementptr inbounds [288 x i32], ptr %527, i64 0, i64 %529
  %531 = load i32, ptr %530, align 2
  %532 = add i32 %531, 0
  %533 = load i32, ptr %10, align 4
  %534 = add i32 %532, %533
  %535 = add i32 %534, 0
  %536 = load ptr, ptr %2, align 8
  %537 = getelementptr inbounds %struct.tdefl_compressor, ptr %536, i32 0, i32 37
  %538 = getelementptr inbounds [3 x [288 x i32]], ptr %537, i64 0, i64 2
  %539 = load i8, ptr %14, align 1
  %540 = zext i8 %539 to i64
  %541 = getelementptr inbounds [288 x i32], ptr %538, i64 0, i64 %540
  store i32 %535, ptr %541, align 2
  br label %542

542:                                              ; preds = %546, %524
  %543 = load i32, ptr %10, align 4
  %544 = add i32 %543, -1
  store i32 %544, ptr %10, align 4
  %545 = icmp ne i32 %543, 0
  br i1 %545, label %546, label %552

546:                                              ; preds = %542
  %547 = load i8, ptr %14, align 1
  %548 = load i32, ptr %8, align 4
  %549 = add i32 %548, 1
  store i32 %549, ptr %8, align 4
  %550 = zext i32 %548 to i64
  %551 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %550
  store i8 %547, ptr %551, align 1
  br label %542, !llvm.loop !110

552:                                              ; preds = %542
  br label %577

553:                                              ; preds = %521
  %554 = load ptr, ptr %2, align 8
  %555 = getelementptr inbounds %struct.tdefl_compressor, ptr %554, i32 0, i32 37
  %556 = getelementptr inbounds [3 x [288 x i32]], ptr %555, i64 0, i64 2
  %557 = getelementptr inbounds [288 x i32], ptr %556, i64 0, i64 16
  %558 = load i32, ptr %557, align 2
  %559 = add i32 %558, 0
  %560 = add nsw i32 %559, 1
  %561 = add i32 %560, 0
  %562 = load ptr, ptr %2, align 8
  %563 = getelementptr inbounds %struct.tdefl_compressor, ptr %562, i32 0, i32 37
  %564 = getelementptr inbounds [3 x [288 x i32]], ptr %563, i64 0, i64 2
  %565 = getelementptr inbounds [288 x i32], ptr %564, i64 0, i64 16
  store i32 %561, ptr %565, align 2
  %566 = load i32, ptr %8, align 4
  %567 = add i32 %566, 1
  store i32 %567, ptr %8, align 4
  %568 = zext i32 %566 to i64
  %569 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %568
  store i8 16, ptr %569, align 1
  %570 = load i32, ptr %10, align 4
  %571 = sub i32 %570, 3
  %572 = trunc i32 %571 to i8
  %573 = load i32, ptr %8, align 4
  %574 = add i32 %573, 1
  store i32 %574, ptr %8, align 4
  %575 = zext i32 %573 to i64
  %576 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %575
  store i8 %572, ptr %576, align 1
  br label %577

577:                                              ; preds = %553, %552
  store i32 0, ptr %10, align 4
  br label %578

578:                                              ; preds = %577, %518
  br label %663

579:                                              ; preds = %515
  %580 = load i32, ptr %9, align 4
  %581 = icmp ne i32 %580, 0
  br i1 %581, label %582, label %662

582:                                              ; preds = %579
  %583 = load i32, ptr %9, align 4
  %584 = icmp ult i32 %583, 3
  br i1 %584, label %585, label %609

585:                                              ; preds = %582
  %586 = load ptr, ptr %2, align 8
  %587 = getelementptr inbounds %struct.tdefl_compressor, ptr %586, i32 0, i32 37
  %588 = getelementptr inbounds [3 x [288 x i32]], ptr %587, i64 0, i64 2
  %589 = getelementptr inbounds [288 x i32], ptr %588, i64 0, i64 0
  %590 = load i32, ptr %589, align 2
  %591 = add i32 %590, 0
  %592 = load i32, ptr %9, align 4
  %593 = add i32 %591, %592
  %594 = add i32 %593, 0
  %595 = load ptr, ptr %2, align 8
  %596 = getelementptr inbounds %struct.tdefl_compressor, ptr %595, i32 0, i32 37
  %597 = getelementptr inbounds [3 x [288 x i32]], ptr %596, i64 0, i64 2
  %598 = getelementptr inbounds [288 x i32], ptr %597, i64 0, i64 0
  store i32 %594, ptr %598, align 2
  br label %599

599:                                              ; preds = %603, %585
  %600 = load i32, ptr %9, align 4
  %601 = add i32 %600, -1
  store i32 %601, ptr %9, align 4
  %602 = icmp ne i32 %600, 0
  br i1 %602, label %603, label %608

603:                                              ; preds = %599
  %604 = load i32, ptr %8, align 4
  %605 = add i32 %604, 1
  store i32 %605, ptr %8, align 4
  %606 = zext i32 %604 to i64
  %607 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %606
  store i8 0, ptr %607, align 1
  br label %599, !llvm.loop !111

608:                                              ; preds = %599
  br label %661

609:                                              ; preds = %582
  %610 = load i32, ptr %9, align 4
  %611 = icmp ule i32 %610, 10
  br i1 %611, label %612, label %636

612:                                              ; preds = %609
  %613 = load ptr, ptr %2, align 8
  %614 = getelementptr inbounds %struct.tdefl_compressor, ptr %613, i32 0, i32 37
  %615 = getelementptr inbounds [3 x [288 x i32]], ptr %614, i64 0, i64 2
  %616 = getelementptr inbounds [288 x i32], ptr %615, i64 0, i64 17
  %617 = load i32, ptr %616, align 2
  %618 = add i32 %617, 0
  %619 = add nsw i32 %618, 1
  %620 = add i32 %619, 0
  %621 = load ptr, ptr %2, align 8
  %622 = getelementptr inbounds %struct.tdefl_compressor, ptr %621, i32 0, i32 37
  %623 = getelementptr inbounds [3 x [288 x i32]], ptr %622, i64 0, i64 2
  %624 = getelementptr inbounds [288 x i32], ptr %623, i64 0, i64 17
  store i32 %620, ptr %624, align 2
  %625 = load i32, ptr %8, align 4
  %626 = add i32 %625, 1
  store i32 %626, ptr %8, align 4
  %627 = zext i32 %625 to i64
  %628 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %627
  store i8 17, ptr %628, align 1
  %629 = load i32, ptr %9, align 4
  %630 = sub i32 %629, 3
  %631 = trunc i32 %630 to i8
  %632 = load i32, ptr %8, align 4
  %633 = add i32 %632, 1
  store i32 %633, ptr %8, align 4
  %634 = zext i32 %632 to i64
  %635 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %634
  store i8 %631, ptr %635, align 1
  br label %660

636:                                              ; preds = %609
  %637 = load ptr, ptr %2, align 8
  %638 = getelementptr inbounds %struct.tdefl_compressor, ptr %637, i32 0, i32 37
  %639 = getelementptr inbounds [3 x [288 x i32]], ptr %638, i64 0, i64 2
  %640 = getelementptr inbounds [288 x i32], ptr %639, i64 0, i64 18
  %641 = load i32, ptr %640, align 2
  %642 = add i32 %641, 0
  %643 = add nsw i32 %642, 1
  %644 = add i32 %643, 0
  %645 = load ptr, ptr %2, align 8
  %646 = getelementptr inbounds %struct.tdefl_compressor, ptr %645, i32 0, i32 37
  %647 = getelementptr inbounds [3 x [288 x i32]], ptr %646, i64 0, i64 2
  %648 = getelementptr inbounds [288 x i32], ptr %647, i64 0, i64 18
  store i32 %644, ptr %648, align 2
  %649 = load i32, ptr %8, align 4
  %650 = add i32 %649, 1
  store i32 %650, ptr %8, align 4
  %651 = zext i32 %649 to i64
  %652 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %651
  store i8 18, ptr %652, align 1
  %653 = load i32, ptr %9, align 4
  %654 = sub i32 %653, 11
  %655 = trunc i32 %654 to i8
  %656 = load i32, ptr %8, align 4
  %657 = add i32 %656, 1
  store i32 %657, ptr %8, align 4
  %658 = zext i32 %656 to i64
  %659 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %658
  store i8 %655, ptr %659, align 1
  br label %660

660:                                              ; preds = %636, %612
  br label %661

661:                                              ; preds = %660, %608
  store i32 0, ptr %9, align 4
  br label %662

662:                                              ; preds = %661, %579
  br label %663

663:                                              ; preds = %662, %578
  %664 = load ptr, ptr %2, align 8
  call void @tdefl_optimize_huffman_table(ptr noundef %664, i32 noundef 2, i32 noundef 19, i32 noundef 7, i32 noundef 0)
  br label %665

665:                                              ; preds = %663
  store i32 2, ptr %16, align 4
  store i32 2, ptr %17, align 4
  %666 = load i32, ptr %16, align 4
  %667 = load i32, ptr %17, align 4
  %668 = shl i32 1, %667
  %669 = sub i32 %668, 1
  %670 = icmp ule i32 %666, %669
  %671 = xor i1 %670, true
  %672 = zext i1 %671 to i32
  %673 = sext i32 %672 to i64
  %674 = icmp ne i64 %673, 0
  br i1 %674, label %675, label %677

675:                                              ; preds = %665
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1636, ptr noundef @.str.38) #14
  unreachable

676:                                              ; No predecessors!
  br label %678

677:                                              ; preds = %665
  br label %678

678:                                              ; preds = %677, %676
  %679 = load i32, ptr %16, align 4
  %680 = load ptr, ptr %2, align 8
  %681 = getelementptr inbounds %struct.tdefl_compressor, ptr %680, i32 0, i32 17
  %682 = load i32, ptr %681, align 4
  %683 = shl i32 %679, %682
  %684 = load ptr, ptr %2, align 8
  %685 = getelementptr inbounds %struct.tdefl_compressor, ptr %684, i32 0, i32 18
  %686 = load i32, ptr %685, align 8
  %687 = or i32 %686, %683
  store i32 %687, ptr %685, align 8
  %688 = load i32, ptr %17, align 4
  %689 = load ptr, ptr %2, align 8
  %690 = getelementptr inbounds %struct.tdefl_compressor, ptr %689, i32 0, i32 17
  %691 = load i32, ptr %690, align 4
  %692 = add i32 %691, %688
  store i32 %692, ptr %690, align 4
  br label %693

693:                                              ; preds = %715, %678
  %694 = load ptr, ptr %2, align 8
  %695 = getelementptr inbounds %struct.tdefl_compressor, ptr %694, i32 0, i32 17
  %696 = load i32, ptr %695, align 4
  %697 = icmp uge i32 %696, 8
  br i1 %697, label %698, label %724

698:                                              ; preds = %693
  %699 = load ptr, ptr %2, align 8
  %700 = getelementptr inbounds %struct.tdefl_compressor, ptr %699, i32 0, i32 12
  %701 = load ptr, ptr %700, align 8
  %702 = load ptr, ptr %2, align 8
  %703 = getelementptr inbounds %struct.tdefl_compressor, ptr %702, i32 0, i32 13
  %704 = load ptr, ptr %703, align 8
  %705 = icmp ult ptr %701, %704
  br i1 %705, label %706, label %715

706:                                              ; preds = %698
  %707 = load ptr, ptr %2, align 8
  %708 = getelementptr inbounds %struct.tdefl_compressor, ptr %707, i32 0, i32 18
  %709 = load i32, ptr %708, align 8
  %710 = trunc i32 %709 to i8
  %711 = load ptr, ptr %2, align 8
  %712 = getelementptr inbounds %struct.tdefl_compressor, ptr %711, i32 0, i32 12
  %713 = load ptr, ptr %712, align 8
  %714 = getelementptr inbounds i8, ptr %713, i32 1
  store ptr %714, ptr %712, align 8
  store i8 %710, ptr %713, align 1
  br label %715

715:                                              ; preds = %706, %698
  %716 = load ptr, ptr %2, align 8
  %717 = getelementptr inbounds %struct.tdefl_compressor, ptr %716, i32 0, i32 18
  %718 = load i32, ptr %717, align 8
  %719 = lshr i32 %718, 8
  store i32 %719, ptr %717, align 8
  %720 = load ptr, ptr %2, align 8
  %721 = getelementptr inbounds %struct.tdefl_compressor, ptr %720, i32 0, i32 17
  %722 = load i32, ptr %721, align 4
  %723 = sub i32 %722, 8
  store i32 %723, ptr %721, align 4
  br label %693, !llvm.loop !112

724:                                              ; preds = %693
  br label %725

725:                                              ; preds = %724
  br label %726

726:                                              ; preds = %725
  %727 = load i32, ptr %3, align 4
  %728 = sub nsw i32 %727, 257
  store i32 %728, ptr %18, align 4
  store i32 5, ptr %19, align 4
  %729 = load i32, ptr %18, align 4
  %730 = load i32, ptr %19, align 4
  %731 = shl i32 1, %730
  %732 = sub i32 %731, 1
  %733 = icmp ule i32 %729, %732
  %734 = xor i1 %733, true
  %735 = zext i1 %734 to i32
  %736 = sext i32 %735 to i64
  %737 = icmp ne i64 %736, 0
  br i1 %737, label %738, label %740

738:                                              ; preds = %726
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1638, ptr noundef @.str.38) #14
  unreachable

739:                                              ; No predecessors!
  br label %741

740:                                              ; preds = %726
  br label %741

741:                                              ; preds = %740, %739
  %742 = load i32, ptr %18, align 4
  %743 = load ptr, ptr %2, align 8
  %744 = getelementptr inbounds %struct.tdefl_compressor, ptr %743, i32 0, i32 17
  %745 = load i32, ptr %744, align 4
  %746 = shl i32 %742, %745
  %747 = load ptr, ptr %2, align 8
  %748 = getelementptr inbounds %struct.tdefl_compressor, ptr %747, i32 0, i32 18
  %749 = load i32, ptr %748, align 8
  %750 = or i32 %749, %746
  store i32 %750, ptr %748, align 8
  %751 = load i32, ptr %19, align 4
  %752 = load ptr, ptr %2, align 8
  %753 = getelementptr inbounds %struct.tdefl_compressor, ptr %752, i32 0, i32 17
  %754 = load i32, ptr %753, align 4
  %755 = add i32 %754, %751
  store i32 %755, ptr %753, align 4
  br label %756

756:                                              ; preds = %778, %741
  %757 = load ptr, ptr %2, align 8
  %758 = getelementptr inbounds %struct.tdefl_compressor, ptr %757, i32 0, i32 17
  %759 = load i32, ptr %758, align 4
  %760 = icmp uge i32 %759, 8
  br i1 %760, label %761, label %787

761:                                              ; preds = %756
  %762 = load ptr, ptr %2, align 8
  %763 = getelementptr inbounds %struct.tdefl_compressor, ptr %762, i32 0, i32 12
  %764 = load ptr, ptr %763, align 8
  %765 = load ptr, ptr %2, align 8
  %766 = getelementptr inbounds %struct.tdefl_compressor, ptr %765, i32 0, i32 13
  %767 = load ptr, ptr %766, align 8
  %768 = icmp ult ptr %764, %767
  br i1 %768, label %769, label %778

769:                                              ; preds = %761
  %770 = load ptr, ptr %2, align 8
  %771 = getelementptr inbounds %struct.tdefl_compressor, ptr %770, i32 0, i32 18
  %772 = load i32, ptr %771, align 8
  %773 = trunc i32 %772 to i8
  %774 = load ptr, ptr %2, align 8
  %775 = getelementptr inbounds %struct.tdefl_compressor, ptr %774, i32 0, i32 12
  %776 = load ptr, ptr %775, align 8
  %777 = getelementptr inbounds i8, ptr %776, i32 1
  store ptr %777, ptr %775, align 8
  store i8 %773, ptr %776, align 1
  br label %778

778:                                              ; preds = %769, %761
  %779 = load ptr, ptr %2, align 8
  %780 = getelementptr inbounds %struct.tdefl_compressor, ptr %779, i32 0, i32 18
  %781 = load i32, ptr %780, align 8
  %782 = lshr i32 %781, 8
  store i32 %782, ptr %780, align 8
  %783 = load ptr, ptr %2, align 8
  %784 = getelementptr inbounds %struct.tdefl_compressor, ptr %783, i32 0, i32 17
  %785 = load i32, ptr %784, align 4
  %786 = sub i32 %785, 8
  store i32 %786, ptr %784, align 4
  br label %756, !llvm.loop !113

787:                                              ; preds = %756
  br label %788

788:                                              ; preds = %787
  br label %789

789:                                              ; preds = %788
  %790 = load i32, ptr %4, align 4
  %791 = sub nsw i32 %790, 1
  store i32 %791, ptr %20, align 4
  store i32 5, ptr %21, align 4
  %792 = load i32, ptr %20, align 4
  %793 = load i32, ptr %21, align 4
  %794 = shl i32 1, %793
  %795 = sub i32 %794, 1
  %796 = icmp ule i32 %792, %795
  %797 = xor i1 %796, true
  %798 = zext i1 %797 to i32
  %799 = sext i32 %798 to i64
  %800 = icmp ne i64 %799, 0
  br i1 %800, label %801, label %803

801:                                              ; preds = %789
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1639, ptr noundef @.str.38) #14
  unreachable

802:                                              ; No predecessors!
  br label %804

803:                                              ; preds = %789
  br label %804

804:                                              ; preds = %803, %802
  %805 = load i32, ptr %20, align 4
  %806 = load ptr, ptr %2, align 8
  %807 = getelementptr inbounds %struct.tdefl_compressor, ptr %806, i32 0, i32 17
  %808 = load i32, ptr %807, align 4
  %809 = shl i32 %805, %808
  %810 = load ptr, ptr %2, align 8
  %811 = getelementptr inbounds %struct.tdefl_compressor, ptr %810, i32 0, i32 18
  %812 = load i32, ptr %811, align 8
  %813 = or i32 %812, %809
  store i32 %813, ptr %811, align 8
  %814 = load i32, ptr %21, align 4
  %815 = load ptr, ptr %2, align 8
  %816 = getelementptr inbounds %struct.tdefl_compressor, ptr %815, i32 0, i32 17
  %817 = load i32, ptr %816, align 4
  %818 = add i32 %817, %814
  store i32 %818, ptr %816, align 4
  br label %819

819:                                              ; preds = %841, %804
  %820 = load ptr, ptr %2, align 8
  %821 = getelementptr inbounds %struct.tdefl_compressor, ptr %820, i32 0, i32 17
  %822 = load i32, ptr %821, align 4
  %823 = icmp uge i32 %822, 8
  br i1 %823, label %824, label %850

824:                                              ; preds = %819
  %825 = load ptr, ptr %2, align 8
  %826 = getelementptr inbounds %struct.tdefl_compressor, ptr %825, i32 0, i32 12
  %827 = load ptr, ptr %826, align 8
  %828 = load ptr, ptr %2, align 8
  %829 = getelementptr inbounds %struct.tdefl_compressor, ptr %828, i32 0, i32 13
  %830 = load ptr, ptr %829, align 8
  %831 = icmp ult ptr %827, %830
  br i1 %831, label %832, label %841

832:                                              ; preds = %824
  %833 = load ptr, ptr %2, align 8
  %834 = getelementptr inbounds %struct.tdefl_compressor, ptr %833, i32 0, i32 18
  %835 = load i32, ptr %834, align 8
  %836 = trunc i32 %835 to i8
  %837 = load ptr, ptr %2, align 8
  %838 = getelementptr inbounds %struct.tdefl_compressor, ptr %837, i32 0, i32 12
  %839 = load ptr, ptr %838, align 8
  %840 = getelementptr inbounds i8, ptr %839, i32 1
  store ptr %840, ptr %838, align 8
  store i8 %836, ptr %839, align 1
  br label %841

841:                                              ; preds = %832, %824
  %842 = load ptr, ptr %2, align 8
  %843 = getelementptr inbounds %struct.tdefl_compressor, ptr %842, i32 0, i32 18
  %844 = load i32, ptr %843, align 8
  %845 = lshr i32 %844, 8
  store i32 %845, ptr %843, align 8
  %846 = load ptr, ptr %2, align 8
  %847 = getelementptr inbounds %struct.tdefl_compressor, ptr %846, i32 0, i32 17
  %848 = load i32, ptr %847, align 4
  %849 = sub i32 %848, 8
  store i32 %849, ptr %847, align 4
  br label %819, !llvm.loop !114

850:                                              ; preds = %819
  br label %851

851:                                              ; preds = %850
  store i32 18, ptr %5, align 4
  br label %852

852:                                              ; preds = %869, %851
  %853 = load i32, ptr %5, align 4
  %854 = icmp sge i32 %853, 0
  br i1 %854, label %855, label %872

855:                                              ; preds = %852
  %856 = load ptr, ptr %2, align 8
  %857 = getelementptr inbounds %struct.tdefl_compressor, ptr %856, i32 0, i32 39
  %858 = getelementptr inbounds [3 x [288 x i8]], ptr %857, i64 0, i64 2
  %859 = load i32, ptr %5, align 4
  %860 = sext i32 %859 to i64
  %861 = getelementptr inbounds [19 x i8], ptr @s_tdefl_packed_code_size_syms_swizzle, i64 0, i64 %860
  %862 = load i8, ptr %861, align 1
  %863 = zext i8 %862 to i64
  %864 = getelementptr inbounds [288 x i8], ptr %858, i64 0, i64 %863
  %865 = load i8, ptr %864, align 1
  %866 = icmp ne i8 %865, 0
  br i1 %866, label %867, label %868

867:                                              ; preds = %855
  br label %872

868:                                              ; preds = %855
  br label %869

869:                                              ; preds = %868
  %870 = load i32, ptr %5, align 4
  %871 = add nsw i32 %870, -1
  store i32 %871, ptr %5, align 4
  br label %852, !llvm.loop !115

872:                                              ; preds = %867, %852
  %873 = load i32, ptr %5, align 4
  %874 = add nsw i32 %873, 1
  %875 = icmp sgt i32 4, %874
  br i1 %875, label %876, label %877

876:                                              ; preds = %872
  br label %880

877:                                              ; preds = %872
  %878 = load i32, ptr %5, align 4
  %879 = add nsw i32 %878, 1
  br label %880

880:                                              ; preds = %877, %876
  %881 = phi i32 [ 4, %876 ], [ %879, %877 ]
  store i32 %881, ptr %5, align 4
  br label %882

882:                                              ; preds = %880
  %883 = load i32, ptr %5, align 4
  %884 = sub nsw i32 %883, 4
  store i32 %884, ptr %22, align 4
  store i32 4, ptr %23, align 4
  %885 = load i32, ptr %22, align 4
  %886 = load i32, ptr %23, align 4
  %887 = shl i32 1, %886
  %888 = sub i32 %887, 1
  %889 = icmp ule i32 %885, %888
  %890 = xor i1 %889, true
  %891 = zext i1 %890 to i32
  %892 = sext i32 %891 to i64
  %893 = icmp ne i64 %892, 0
  br i1 %893, label %894, label %896

894:                                              ; preds = %882
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1642, ptr noundef @.str.38) #14
  unreachable

895:                                              ; No predecessors!
  br label %897

896:                                              ; preds = %882
  br label %897

897:                                              ; preds = %896, %895
  %898 = load i32, ptr %22, align 4
  %899 = load ptr, ptr %2, align 8
  %900 = getelementptr inbounds %struct.tdefl_compressor, ptr %899, i32 0, i32 17
  %901 = load i32, ptr %900, align 4
  %902 = shl i32 %898, %901
  %903 = load ptr, ptr %2, align 8
  %904 = getelementptr inbounds %struct.tdefl_compressor, ptr %903, i32 0, i32 18
  %905 = load i32, ptr %904, align 8
  %906 = or i32 %905, %902
  store i32 %906, ptr %904, align 8
  %907 = load i32, ptr %23, align 4
  %908 = load ptr, ptr %2, align 8
  %909 = getelementptr inbounds %struct.tdefl_compressor, ptr %908, i32 0, i32 17
  %910 = load i32, ptr %909, align 4
  %911 = add i32 %910, %907
  store i32 %911, ptr %909, align 4
  br label %912

912:                                              ; preds = %934, %897
  %913 = load ptr, ptr %2, align 8
  %914 = getelementptr inbounds %struct.tdefl_compressor, ptr %913, i32 0, i32 17
  %915 = load i32, ptr %914, align 4
  %916 = icmp uge i32 %915, 8
  br i1 %916, label %917, label %943

917:                                              ; preds = %912
  %918 = load ptr, ptr %2, align 8
  %919 = getelementptr inbounds %struct.tdefl_compressor, ptr %918, i32 0, i32 12
  %920 = load ptr, ptr %919, align 8
  %921 = load ptr, ptr %2, align 8
  %922 = getelementptr inbounds %struct.tdefl_compressor, ptr %921, i32 0, i32 13
  %923 = load ptr, ptr %922, align 8
  %924 = icmp ult ptr %920, %923
  br i1 %924, label %925, label %934

925:                                              ; preds = %917
  %926 = load ptr, ptr %2, align 8
  %927 = getelementptr inbounds %struct.tdefl_compressor, ptr %926, i32 0, i32 18
  %928 = load i32, ptr %927, align 8
  %929 = trunc i32 %928 to i8
  %930 = load ptr, ptr %2, align 8
  %931 = getelementptr inbounds %struct.tdefl_compressor, ptr %930, i32 0, i32 12
  %932 = load ptr, ptr %931, align 8
  %933 = getelementptr inbounds i8, ptr %932, i32 1
  store ptr %933, ptr %931, align 8
  store i8 %929, ptr %932, align 1
  br label %934

934:                                              ; preds = %925, %917
  %935 = load ptr, ptr %2, align 8
  %936 = getelementptr inbounds %struct.tdefl_compressor, ptr %935, i32 0, i32 18
  %937 = load i32, ptr %936, align 8
  %938 = lshr i32 %937, 8
  store i32 %938, ptr %936, align 8
  %939 = load ptr, ptr %2, align 8
  %940 = getelementptr inbounds %struct.tdefl_compressor, ptr %939, i32 0, i32 17
  %941 = load i32, ptr %940, align 4
  %942 = sub i32 %941, 8
  store i32 %942, ptr %940, align 4
  br label %912, !llvm.loop !116

943:                                              ; preds = %912
  br label %944

944:                                              ; preds = %943
  store i32 0, ptr %6, align 4
  br label %945

945:                                              ; preds = %1022, %944
  %946 = load i32, ptr %6, align 4
  %947 = load i32, ptr %5, align 4
  %948 = icmp slt i32 %946, %947
  br i1 %948, label %949, label %1025

949:                                              ; preds = %945
  br label %950

950:                                              ; preds = %949
  %951 = load ptr, ptr %2, align 8
  %952 = getelementptr inbounds %struct.tdefl_compressor, ptr %951, i32 0, i32 39
  %953 = getelementptr inbounds [3 x [288 x i8]], ptr %952, i64 0, i64 2
  %954 = load i32, ptr %6, align 4
  %955 = zext i32 %954 to i64
  %956 = getelementptr inbounds [19 x i8], ptr @s_tdefl_packed_code_size_syms_swizzle, i64 0, i64 %955
  %957 = load i8, ptr %956, align 1
  %958 = zext i8 %957 to i64
  %959 = getelementptr inbounds [288 x i8], ptr %953, i64 0, i64 %958
  %960 = load i8, ptr %959, align 1
  %961 = zext i8 %960 to i32
  store i32 %961, ptr %24, align 4
  store i32 3, ptr %25, align 4
  %962 = load i32, ptr %24, align 4
  %963 = load i32, ptr %25, align 4
  %964 = shl i32 1, %963
  %965 = sub i32 %964, 1
  %966 = icmp ule i32 %962, %965
  %967 = xor i1 %966, true
  %968 = zext i1 %967 to i32
  %969 = sext i32 %968 to i64
  %970 = icmp ne i64 %969, 0
  br i1 %970, label %971, label %973

971:                                              ; preds = %950
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1643, ptr noundef @.str.38) #14
  unreachable

972:                                              ; No predecessors!
  br label %974

973:                                              ; preds = %950
  br label %974

974:                                              ; preds = %973, %972
  %975 = load i32, ptr %24, align 4
  %976 = load ptr, ptr %2, align 8
  %977 = getelementptr inbounds %struct.tdefl_compressor, ptr %976, i32 0, i32 17
  %978 = load i32, ptr %977, align 4
  %979 = shl i32 %975, %978
  %980 = load ptr, ptr %2, align 8
  %981 = getelementptr inbounds %struct.tdefl_compressor, ptr %980, i32 0, i32 18
  %982 = load i32, ptr %981, align 8
  %983 = or i32 %982, %979
  store i32 %983, ptr %981, align 8
  %984 = load i32, ptr %25, align 4
  %985 = load ptr, ptr %2, align 8
  %986 = getelementptr inbounds %struct.tdefl_compressor, ptr %985, i32 0, i32 17
  %987 = load i32, ptr %986, align 4
  %988 = add i32 %987, %984
  store i32 %988, ptr %986, align 4
  br label %989

989:                                              ; preds = %1011, %974
  %990 = load ptr, ptr %2, align 8
  %991 = getelementptr inbounds %struct.tdefl_compressor, ptr %990, i32 0, i32 17
  %992 = load i32, ptr %991, align 4
  %993 = icmp uge i32 %992, 8
  br i1 %993, label %994, label %1020

994:                                              ; preds = %989
  %995 = load ptr, ptr %2, align 8
  %996 = getelementptr inbounds %struct.tdefl_compressor, ptr %995, i32 0, i32 12
  %997 = load ptr, ptr %996, align 8
  %998 = load ptr, ptr %2, align 8
  %999 = getelementptr inbounds %struct.tdefl_compressor, ptr %998, i32 0, i32 13
  %1000 = load ptr, ptr %999, align 8
  %1001 = icmp ult ptr %997, %1000
  br i1 %1001, label %1002, label %1011

1002:                                             ; preds = %994
  %1003 = load ptr, ptr %2, align 8
  %1004 = getelementptr inbounds %struct.tdefl_compressor, ptr %1003, i32 0, i32 18
  %1005 = load i32, ptr %1004, align 8
  %1006 = trunc i32 %1005 to i8
  %1007 = load ptr, ptr %2, align 8
  %1008 = getelementptr inbounds %struct.tdefl_compressor, ptr %1007, i32 0, i32 12
  %1009 = load ptr, ptr %1008, align 8
  %1010 = getelementptr inbounds i8, ptr %1009, i32 1
  store ptr %1010, ptr %1008, align 8
  store i8 %1006, ptr %1009, align 1
  br label %1011

1011:                                             ; preds = %1002, %994
  %1012 = load ptr, ptr %2, align 8
  %1013 = getelementptr inbounds %struct.tdefl_compressor, ptr %1012, i32 0, i32 18
  %1014 = load i32, ptr %1013, align 8
  %1015 = lshr i32 %1014, 8
  store i32 %1015, ptr %1013, align 8
  %1016 = load ptr, ptr %2, align 8
  %1017 = getelementptr inbounds %struct.tdefl_compressor, ptr %1016, i32 0, i32 17
  %1018 = load i32, ptr %1017, align 4
  %1019 = sub i32 %1018, 8
  store i32 %1019, ptr %1017, align 4
  br label %989, !llvm.loop !117

1020:                                             ; preds = %989
  br label %1021

1021:                                             ; preds = %1020
  br label %1022

1022:                                             ; preds = %1021
  %1023 = load i32, ptr %6, align 4
  %1024 = add i32 %1023, 1
  store i32 %1024, ptr %6, align 4
  br label %945, !llvm.loop !118

1025:                                             ; preds = %945
  store i32 0, ptr %11, align 4
  br label %1026

1026:                                             ; preds = %1200, %1025
  %1027 = load i32, ptr %11, align 4
  %1028 = load i32, ptr %8, align 4
  %1029 = icmp ult i32 %1027, %1028
  br i1 %1029, label %1030, label %1201

1030:                                             ; preds = %1026
  %1031 = load i32, ptr %11, align 4
  %1032 = add i32 %1031, 1
  store i32 %1032, ptr %11, align 4
  %1033 = zext i32 %1031 to i64
  %1034 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %1033
  %1035 = load i8, ptr %1034, align 1
  %1036 = zext i8 %1035 to i32
  store i32 %1036, ptr %26, align 4
  %1037 = load i32, ptr %26, align 4
  %1038 = icmp ult i32 %1037, 19
  %1039 = xor i1 %1038, true
  %1040 = zext i1 %1039 to i32
  %1041 = sext i32 %1040 to i64
  %1042 = icmp ne i64 %1041, 0
  br i1 %1042, label %1043, label %1045

1043:                                             ; preds = %1030
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1647, ptr noundef @.str.40) #14
  unreachable

1044:                                             ; No predecessors!
  br label %1046

1045:                                             ; preds = %1030
  br label %1046

1046:                                             ; preds = %1045, %1044
  br label %1047

1047:                                             ; preds = %1046
  %1048 = load ptr, ptr %2, align 8
  %1049 = getelementptr inbounds %struct.tdefl_compressor, ptr %1048, i32 0, i32 38
  %1050 = getelementptr inbounds [3 x [288 x i32]], ptr %1049, i64 0, i64 2
  %1051 = load i32, ptr %26, align 4
  %1052 = zext i32 %1051 to i64
  %1053 = getelementptr inbounds [288 x i32], ptr %1050, i64 0, i64 %1052
  %1054 = load i32, ptr %1053, align 2
  %1055 = add i32 %1054, 0
  store i32 %1055, ptr %27, align 4
  %1056 = load ptr, ptr %2, align 8
  %1057 = getelementptr inbounds %struct.tdefl_compressor, ptr %1056, i32 0, i32 39
  %1058 = getelementptr inbounds [3 x [288 x i8]], ptr %1057, i64 0, i64 2
  %1059 = load i32, ptr %26, align 4
  %1060 = zext i32 %1059 to i64
  %1061 = getelementptr inbounds [288 x i8], ptr %1058, i64 0, i64 %1060
  %1062 = load i8, ptr %1061, align 1
  %1063 = zext i8 %1062 to i32
  store i32 %1063, ptr %28, align 4
  %1064 = load i32, ptr %27, align 4
  %1065 = load i32, ptr %28, align 4
  %1066 = shl i32 1, %1065
  %1067 = sub i32 %1066, 1
  %1068 = icmp ule i32 %1064, %1067
  %1069 = xor i1 %1068, true
  %1070 = zext i1 %1069 to i32
  %1071 = sext i32 %1070 to i64
  %1072 = icmp ne i64 %1071, 0
  br i1 %1072, label %1073, label %1075

1073:                                             ; preds = %1047
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1648, ptr noundef @.str.38) #14
  unreachable

1074:                                             ; No predecessors!
  br label %1076

1075:                                             ; preds = %1047
  br label %1076

1076:                                             ; preds = %1075, %1074
  %1077 = load i32, ptr %27, align 4
  %1078 = load ptr, ptr %2, align 8
  %1079 = getelementptr inbounds %struct.tdefl_compressor, ptr %1078, i32 0, i32 17
  %1080 = load i32, ptr %1079, align 4
  %1081 = shl i32 %1077, %1080
  %1082 = load ptr, ptr %2, align 8
  %1083 = getelementptr inbounds %struct.tdefl_compressor, ptr %1082, i32 0, i32 18
  %1084 = load i32, ptr %1083, align 8
  %1085 = or i32 %1084, %1081
  store i32 %1085, ptr %1083, align 8
  %1086 = load i32, ptr %28, align 4
  %1087 = load ptr, ptr %2, align 8
  %1088 = getelementptr inbounds %struct.tdefl_compressor, ptr %1087, i32 0, i32 17
  %1089 = load i32, ptr %1088, align 4
  %1090 = add i32 %1089, %1086
  store i32 %1090, ptr %1088, align 4
  br label %1091

1091:                                             ; preds = %1113, %1076
  %1092 = load ptr, ptr %2, align 8
  %1093 = getelementptr inbounds %struct.tdefl_compressor, ptr %1092, i32 0, i32 17
  %1094 = load i32, ptr %1093, align 4
  %1095 = icmp uge i32 %1094, 8
  br i1 %1095, label %1096, label %1122

1096:                                             ; preds = %1091
  %1097 = load ptr, ptr %2, align 8
  %1098 = getelementptr inbounds %struct.tdefl_compressor, ptr %1097, i32 0, i32 12
  %1099 = load ptr, ptr %1098, align 8
  %1100 = load ptr, ptr %2, align 8
  %1101 = getelementptr inbounds %struct.tdefl_compressor, ptr %1100, i32 0, i32 13
  %1102 = load ptr, ptr %1101, align 8
  %1103 = icmp ult ptr %1099, %1102
  br i1 %1103, label %1104, label %1113

1104:                                             ; preds = %1096
  %1105 = load ptr, ptr %2, align 8
  %1106 = getelementptr inbounds %struct.tdefl_compressor, ptr %1105, i32 0, i32 18
  %1107 = load i32, ptr %1106, align 8
  %1108 = trunc i32 %1107 to i8
  %1109 = load ptr, ptr %2, align 8
  %1110 = getelementptr inbounds %struct.tdefl_compressor, ptr %1109, i32 0, i32 12
  %1111 = load ptr, ptr %1110, align 8
  %1112 = getelementptr inbounds i8, ptr %1111, i32 1
  store ptr %1112, ptr %1110, align 8
  store i8 %1108, ptr %1111, align 1
  br label %1113

1113:                                             ; preds = %1104, %1096
  %1114 = load ptr, ptr %2, align 8
  %1115 = getelementptr inbounds %struct.tdefl_compressor, ptr %1114, i32 0, i32 18
  %1116 = load i32, ptr %1115, align 8
  %1117 = lshr i32 %1116, 8
  store i32 %1117, ptr %1115, align 8
  %1118 = load ptr, ptr %2, align 8
  %1119 = getelementptr inbounds %struct.tdefl_compressor, ptr %1118, i32 0, i32 17
  %1120 = load i32, ptr %1119, align 4
  %1121 = sub i32 %1120, 8
  store i32 %1121, ptr %1119, align 4
  br label %1091, !llvm.loop !119

1122:                                             ; preds = %1091
  br label %1123

1123:                                             ; preds = %1122
  %1124 = load i32, ptr %26, align 4
  %1125 = icmp uge i32 %1124, 16
  br i1 %1125, label %1126, label %1200

1126:                                             ; preds = %1123
  br label %1127

1127:                                             ; preds = %1126
  %1128 = load i32, ptr %11, align 4
  %1129 = add i32 %1128, 1
  store i32 %1129, ptr %11, align 4
  %1130 = zext i32 %1128 to i64
  %1131 = getelementptr inbounds [320 x i8], ptr %13, i64 0, i64 %1130
  %1132 = load i8, ptr %1131, align 1
  %1133 = zext i8 %1132 to i32
  store i32 %1133, ptr %29, align 4
  %1134 = load i32, ptr %26, align 4
  %1135 = sub i32 %1134, 16
  %1136 = zext i32 %1135 to i64
  %1137 = getelementptr inbounds [4 x i8], ptr @.str.12, i64 0, i64 %1136
  %1138 = load i8, ptr %1137, align 1
  %1139 = sext i8 %1138 to i32
  store i32 %1139, ptr %30, align 4
  %1140 = load i32, ptr %29, align 4
  %1141 = load i32, ptr %30, align 4
  %1142 = shl i32 1, %1141
  %1143 = sub i32 %1142, 1
  %1144 = icmp ule i32 %1140, %1143
  %1145 = xor i1 %1144, true
  %1146 = zext i1 %1145 to i32
  %1147 = sext i32 %1146 to i64
  %1148 = icmp ne i64 %1147, 0
  br i1 %1148, label %1149, label %1151

1149:                                             ; preds = %1127
  call void @__assert_rtn(ptr noundef @__func__.tdefl_start_dynamic_block, ptr noundef @.str.14, i32 noundef 1649, ptr noundef @.str.38) #14
  unreachable

1150:                                             ; No predecessors!
  br label %1152

1151:                                             ; preds = %1127
  br label %1152

1152:                                             ; preds = %1151, %1150
  %1153 = load i32, ptr %29, align 4
  %1154 = load ptr, ptr %2, align 8
  %1155 = getelementptr inbounds %struct.tdefl_compressor, ptr %1154, i32 0, i32 17
  %1156 = load i32, ptr %1155, align 4
  %1157 = shl i32 %1153, %1156
  %1158 = load ptr, ptr %2, align 8
  %1159 = getelementptr inbounds %struct.tdefl_compressor, ptr %1158, i32 0, i32 18
  %1160 = load i32, ptr %1159, align 8
  %1161 = or i32 %1160, %1157
  store i32 %1161, ptr %1159, align 8
  %1162 = load i32, ptr %30, align 4
  %1163 = load ptr, ptr %2, align 8
  %1164 = getelementptr inbounds %struct.tdefl_compressor, ptr %1163, i32 0, i32 17
  %1165 = load i32, ptr %1164, align 4
  %1166 = add i32 %1165, %1162
  store i32 %1166, ptr %1164, align 4
  br label %1167

1167:                                             ; preds = %1189, %1152
  %1168 = load ptr, ptr %2, align 8
  %1169 = getelementptr inbounds %struct.tdefl_compressor, ptr %1168, i32 0, i32 17
  %1170 = load i32, ptr %1169, align 4
  %1171 = icmp uge i32 %1170, 8
  br i1 %1171, label %1172, label %1198

1172:                                             ; preds = %1167
  %1173 = load ptr, ptr %2, align 8
  %1174 = getelementptr inbounds %struct.tdefl_compressor, ptr %1173, i32 0, i32 12
  %1175 = load ptr, ptr %1174, align 8
  %1176 = load ptr, ptr %2, align 8
  %1177 = getelementptr inbounds %struct.tdefl_compressor, ptr %1176, i32 0, i32 13
  %1178 = load ptr, ptr %1177, align 8
  %1179 = icmp ult ptr %1175, %1178
  br i1 %1179, label %1180, label %1189

1180:                                             ; preds = %1172
  %1181 = load ptr, ptr %2, align 8
  %1182 = getelementptr inbounds %struct.tdefl_compressor, ptr %1181, i32 0, i32 18
  %1183 = load i32, ptr %1182, align 8
  %1184 = trunc i32 %1183 to i8
  %1185 = load ptr, ptr %2, align 8
  %1186 = getelementptr inbounds %struct.tdefl_compressor, ptr %1185, i32 0, i32 12
  %1187 = load ptr, ptr %1186, align 8
  %1188 = getelementptr inbounds i8, ptr %1187, i32 1
  store ptr %1188, ptr %1186, align 8
  store i8 %1184, ptr %1187, align 1
  br label %1189

1189:                                             ; preds = %1180, %1172
  %1190 = load ptr, ptr %2, align 8
  %1191 = getelementptr inbounds %struct.tdefl_compressor, ptr %1190, i32 0, i32 18
  %1192 = load i32, ptr %1191, align 8
  %1193 = lshr i32 %1192, 8
  store i32 %1193, ptr %1191, align 8
  %1194 = load ptr, ptr %2, align 8
  %1195 = getelementptr inbounds %struct.tdefl_compressor, ptr %1194, i32 0, i32 17
  %1196 = load i32, ptr %1195, align 4
  %1197 = sub i32 %1196, 8
  store i32 %1197, ptr %1195, align 4
  br label %1167, !llvm.loop !120

1198:                                             ; preds = %1167
  br label %1199

1199:                                             ; preds = %1198
  br label %1200

1200:                                             ; preds = %1199, %1123
  br label %1026, !llvm.loop !121

1201:                                             ; preds = %1026
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal i32 @tdefl_compress_lz_codes(ptr noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  %24 = load ptr, ptr %3, align 8
  %25 = getelementptr inbounds %struct.tdefl_compressor, ptr %24, i32 0, i32 12
  %26 = load ptr, ptr %25, align 8
  store ptr %26, ptr %6, align 8
  %27 = load ptr, ptr %3, align 8
  %28 = getelementptr inbounds %struct.tdefl_compressor, ptr %27, i32 0, i32 10
  %29 = load ptr, ptr %28, align 8
  store ptr %29, ptr %7, align 8
  %30 = load ptr, ptr %3, align 8
  %31 = getelementptr inbounds %struct.tdefl_compressor, ptr %30, i32 0, i32 18
  %32 = load i32, ptr %31, align 8
  %33 = zext i32 %32 to i64
  store i64 %33, ptr %8, align 8
  %34 = load ptr, ptr %3, align 8
  %35 = getelementptr inbounds %struct.tdefl_compressor, ptr %34, i32 0, i32 17
  %36 = load i32, ptr %35, align 4
  store i32 %36, ptr %9, align 4
  store i32 1, ptr %4, align 4
  %37 = load ptr, ptr %3, align 8
  %38 = getelementptr inbounds %struct.tdefl_compressor, ptr %37, i32 0, i32 40
  %39 = getelementptr inbounds [65536 x i8], ptr %38, i64 0, i64 0
  store ptr %39, ptr %5, align 8
  br label %40

40:                                               ; preds = %406, %1
  %41 = load ptr, ptr %5, align 8
  %42 = load ptr, ptr %7, align 8
  %43 = icmp ult ptr %41, %42
  br i1 %43, label %44, label %409

44:                                               ; preds = %40
  %45 = load i32, ptr %4, align 4
  %46 = icmp eq i32 %45, 1
  br i1 %46, label %47, label %53

47:                                               ; preds = %44
  %48 = load ptr, ptr %5, align 8
  %49 = getelementptr inbounds i8, ptr %48, i32 1
  store ptr %49, ptr %5, align 8
  %50 = load i8, ptr %48, align 1
  %51 = zext i8 %50 to i32
  %52 = or i32 %51, 256
  store i32 %52, ptr %4, align 4
  br label %53

53:                                               ; preds = %47, %44
  %54 = load i32, ptr %4, align 4
  %55 = and i32 %54, 1
  %56 = icmp ne i32 %55, 0
  br i1 %56, label %57, label %232

57:                                               ; preds = %53
  %58 = load ptr, ptr %5, align 8
  %59 = getelementptr inbounds i8, ptr %58, i64 0
  %60 = load i8, ptr %59, align 1
  %61 = zext i8 %60 to i32
  store i32 %61, ptr %16, align 4
  %62 = load ptr, ptr %5, align 8
  %63 = getelementptr inbounds i8, ptr %62, i64 1
  %64 = load i32, ptr %63, align 2
  %65 = add i32 %64, 0
  store i32 %65, ptr %17, align 4
  %66 = load ptr, ptr %5, align 8
  %67 = getelementptr inbounds i8, ptr %66, i64 3
  store ptr %67, ptr %5, align 8
  %68 = load ptr, ptr %3, align 8
  %69 = getelementptr inbounds %struct.tdefl_compressor, ptr %68, i32 0, i32 39
  %70 = getelementptr inbounds [3 x [288 x i8]], ptr %69, i64 0, i64 0
  %71 = load i32, ptr %16, align 4
  %72 = zext i32 %71 to i64
  %73 = getelementptr inbounds [256 x i32], ptr @s_tdefl_len_sym, i64 0, i64 %72
  %74 = load i32, ptr %73, align 2
  %75 = zext i32 %74 to i64
  %76 = getelementptr inbounds [288 x i8], ptr %70, i64 0, i64 %75
  %77 = load i8, ptr %76, align 1
  %78 = icmp ne i8 %77, 0
  %79 = xor i1 %78, true
  %80 = zext i1 %79 to i32
  %81 = sext i32 %80 to i64
  %82 = icmp ne i64 %81, 0
  br i1 %82, label %83, label %85

83:                                               ; preds = %57
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1696, ptr noundef @.str.41) #14
  unreachable

84:                                               ; No predecessors!
  br label %86

85:                                               ; preds = %57
  br label %86

86:                                               ; preds = %85, %84
  %87 = load ptr, ptr %3, align 8
  %88 = getelementptr inbounds %struct.tdefl_compressor, ptr %87, i32 0, i32 38
  %89 = getelementptr inbounds [3 x [288 x i32]], ptr %88, i64 0, i64 0
  %90 = load i32, ptr %16, align 4
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds [256 x i32], ptr @s_tdefl_len_sym, i64 0, i64 %91
  %93 = load i32, ptr %92, align 2
  %94 = zext i32 %93 to i64
  %95 = getelementptr inbounds [288 x i32], ptr %89, i64 0, i64 %94
  %96 = load i32, ptr %95, align 2
  %97 = zext i32 %96 to i64
  %98 = load i32, ptr %9, align 4
  %99 = zext i32 %98 to i64
  %100 = shl i64 %97, %99
  %101 = load i64, ptr %8, align 8
  %102 = or i64 %101, %100
  store i64 %102, ptr %8, align 8
  %103 = load ptr, ptr %3, align 8
  %104 = getelementptr inbounds %struct.tdefl_compressor, ptr %103, i32 0, i32 39
  %105 = getelementptr inbounds [3 x [288 x i8]], ptr %104, i64 0, i64 0
  %106 = load i32, ptr %16, align 4
  %107 = zext i32 %106 to i64
  %108 = getelementptr inbounds [256 x i32], ptr @s_tdefl_len_sym, i64 0, i64 %107
  %109 = load i32, ptr %108, align 2
  %110 = zext i32 %109 to i64
  %111 = getelementptr inbounds [288 x i8], ptr %105, i64 0, i64 %110
  %112 = load i8, ptr %111, align 1
  %113 = zext i8 %112 to i32
  %114 = load i32, ptr %9, align 4
  %115 = add i32 %114, %113
  store i32 %115, ptr %9, align 4
  %116 = load i32, ptr %16, align 4
  %117 = load i32, ptr %16, align 4
  %118 = zext i32 %117 to i64
  %119 = getelementptr inbounds [256 x i8], ptr @s_tdefl_len_extra, i64 0, i64 %118
  %120 = load i8, ptr %119, align 1
  %121 = zext i8 %120 to i64
  %122 = getelementptr inbounds [17 x i32], ptr @mz_bitmasks, i64 0, i64 %121
  %123 = load i32, ptr %122, align 4
  %124 = and i32 %116, %123
  %125 = zext i32 %124 to i64
  %126 = load i32, ptr %9, align 4
  %127 = zext i32 %126 to i64
  %128 = shl i64 %125, %127
  %129 = load i64, ptr %8, align 8
  %130 = or i64 %129, %128
  store i64 %130, ptr %8, align 8
  %131 = load i32, ptr %16, align 4
  %132 = zext i32 %131 to i64
  %133 = getelementptr inbounds [256 x i8], ptr @s_tdefl_len_extra, i64 0, i64 %132
  %134 = load i8, ptr %133, align 1
  %135 = zext i8 %134 to i32
  %136 = load i32, ptr %9, align 4
  %137 = add i32 %136, %135
  store i32 %137, ptr %9, align 4
  %138 = load i32, ptr %17, align 4
  %139 = and i32 %138, 511
  %140 = zext i32 %139 to i64
  %141 = getelementptr inbounds [512 x i8], ptr @s_tdefl_small_dist_sym, i64 0, i64 %140
  %142 = load i8, ptr %141, align 1
  %143 = zext i8 %142 to i32
  store i32 %143, ptr %10, align 4
  %144 = load i32, ptr %17, align 4
  %145 = and i32 %144, 511
  %146 = zext i32 %145 to i64
  %147 = getelementptr inbounds [512 x i8], ptr @s_tdefl_small_dist_extra, i64 0, i64 %146
  %148 = load i8, ptr %147, align 1
  %149 = zext i8 %148 to i32
  store i32 %149, ptr %12, align 4
  %150 = load i32, ptr %17, align 4
  %151 = lshr i32 %150, 8
  %152 = zext i32 %151 to i64
  %153 = getelementptr inbounds [128 x i8], ptr @s_tdefl_large_dist_sym, i64 0, i64 %152
  %154 = load i8, ptr %153, align 1
  %155 = zext i8 %154 to i32
  store i32 %155, ptr %11, align 4
  %156 = load i32, ptr %17, align 4
  %157 = lshr i32 %156, 8
  %158 = zext i32 %157 to i64
  %159 = getelementptr inbounds [128 x i8], ptr @s_tdefl_large_dist_extra, i64 0, i64 %158
  %160 = load i8, ptr %159, align 1
  %161 = zext i8 %160 to i32
  store i32 %161, ptr %13, align 4
  %162 = load i32, ptr %17, align 4
  %163 = icmp ult i32 %162, 512
  br i1 %163, label %164, label %166

164:                                              ; preds = %86
  %165 = load i32, ptr %10, align 4
  br label %168

166:                                              ; preds = %86
  %167 = load i32, ptr %11, align 4
  br label %168

168:                                              ; preds = %166, %164
  %169 = phi i32 [ %165, %164 ], [ %167, %166 ]
  store i32 %169, ptr %14, align 4
  %170 = load i32, ptr %17, align 4
  %171 = icmp ult i32 %170, 512
  br i1 %171, label %172, label %174

172:                                              ; preds = %168
  %173 = load i32, ptr %12, align 4
  br label %176

174:                                              ; preds = %168
  %175 = load i32, ptr %13, align 4
  br label %176

176:                                              ; preds = %174, %172
  %177 = phi i32 [ %173, %172 ], [ %175, %174 ]
  store i32 %177, ptr %15, align 4
  %178 = load ptr, ptr %3, align 8
  %179 = getelementptr inbounds %struct.tdefl_compressor, ptr %178, i32 0, i32 39
  %180 = getelementptr inbounds [3 x [288 x i8]], ptr %179, i64 0, i64 1
  %181 = load i32, ptr %14, align 4
  %182 = zext i32 %181 to i64
  %183 = getelementptr inbounds [288 x i8], ptr %180, i64 0, i64 %182
  %184 = load i8, ptr %183, align 1
  %185 = icmp ne i8 %184, 0
  %186 = xor i1 %185, true
  %187 = zext i1 %186 to i32
  %188 = sext i32 %187 to i64
  %189 = icmp ne i64 %188, 0
  br i1 %189, label %190, label %192

190:                                              ; preds = %176
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1708, ptr noundef @.str.42) #14
  unreachable

191:                                              ; No predecessors!
  br label %193

192:                                              ; preds = %176
  br label %193

193:                                              ; preds = %192, %191
  %194 = load ptr, ptr %3, align 8
  %195 = getelementptr inbounds %struct.tdefl_compressor, ptr %194, i32 0, i32 38
  %196 = getelementptr inbounds [3 x [288 x i32]], ptr %195, i64 0, i64 1
  %197 = load i32, ptr %14, align 4
  %198 = zext i32 %197 to i64
  %199 = getelementptr inbounds [288 x i32], ptr %196, i64 0, i64 %198
  %200 = load i32, ptr %199, align 2
  %201 = zext i32 %200 to i64
  %202 = load i32, ptr %9, align 4
  %203 = zext i32 %202 to i64
  %204 = shl i64 %201, %203
  %205 = load i64, ptr %8, align 8
  %206 = or i64 %205, %204
  store i64 %206, ptr %8, align 8
  %207 = load ptr, ptr %3, align 8
  %208 = getelementptr inbounds %struct.tdefl_compressor, ptr %207, i32 0, i32 39
  %209 = getelementptr inbounds [3 x [288 x i8]], ptr %208, i64 0, i64 1
  %210 = load i32, ptr %14, align 4
  %211 = zext i32 %210 to i64
  %212 = getelementptr inbounds [288 x i8], ptr %209, i64 0, i64 %211
  %213 = load i8, ptr %212, align 1
  %214 = zext i8 %213 to i32
  %215 = load i32, ptr %9, align 4
  %216 = add i32 %215, %214
  store i32 %216, ptr %9, align 4
  %217 = load i32, ptr %17, align 4
  %218 = load i32, ptr %15, align 4
  %219 = zext i32 %218 to i64
  %220 = getelementptr inbounds [17 x i32], ptr @mz_bitmasks, i64 0, i64 %219
  %221 = load i32, ptr %220, align 4
  %222 = and i32 %217, %221
  %223 = zext i32 %222 to i64
  %224 = load i32, ptr %9, align 4
  %225 = zext i32 %224 to i64
  %226 = shl i64 %223, %225
  %227 = load i64, ptr %8, align 8
  %228 = or i64 %227, %226
  store i64 %228, ptr %8, align 8
  %229 = load i32, ptr %15, align 4
  %230 = load i32, ptr %9, align 4
  %231 = add i32 %230, %229
  store i32 %231, ptr %9, align 4
  br label %384

232:                                              ; preds = %53
  %233 = load ptr, ptr %5, align 8
  %234 = getelementptr inbounds i8, ptr %233, i32 1
  store ptr %234, ptr %5, align 8
  %235 = load i8, ptr %233, align 1
  %236 = zext i8 %235 to i32
  store i32 %236, ptr %18, align 4
  %237 = load ptr, ptr %3, align 8
  %238 = getelementptr inbounds %struct.tdefl_compressor, ptr %237, i32 0, i32 39
  %239 = getelementptr inbounds [3 x [288 x i8]], ptr %238, i64 0, i64 0
  %240 = load i32, ptr %18, align 4
  %241 = zext i32 %240 to i64
  %242 = getelementptr inbounds [288 x i8], ptr %239, i64 0, i64 %241
  %243 = load i8, ptr %242, align 1
  %244 = icmp ne i8 %243, 0
  %245 = xor i1 %244, true
  %246 = zext i1 %245 to i32
  %247 = sext i32 %246 to i64
  %248 = icmp ne i64 %247, 0
  br i1 %248, label %249, label %251

249:                                              ; preds = %232
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1715, ptr noundef @.str.43) #14
  unreachable

250:                                              ; No predecessors!
  br label %252

251:                                              ; preds = %232
  br label %252

252:                                              ; preds = %251, %250
  %253 = load ptr, ptr %3, align 8
  %254 = getelementptr inbounds %struct.tdefl_compressor, ptr %253, i32 0, i32 38
  %255 = getelementptr inbounds [3 x [288 x i32]], ptr %254, i64 0, i64 0
  %256 = load i32, ptr %18, align 4
  %257 = zext i32 %256 to i64
  %258 = getelementptr inbounds [288 x i32], ptr %255, i64 0, i64 %257
  %259 = load i32, ptr %258, align 2
  %260 = zext i32 %259 to i64
  %261 = load i32, ptr %9, align 4
  %262 = zext i32 %261 to i64
  %263 = shl i64 %260, %262
  %264 = load i64, ptr %8, align 8
  %265 = or i64 %264, %263
  store i64 %265, ptr %8, align 8
  %266 = load ptr, ptr %3, align 8
  %267 = getelementptr inbounds %struct.tdefl_compressor, ptr %266, i32 0, i32 39
  %268 = getelementptr inbounds [3 x [288 x i8]], ptr %267, i64 0, i64 0
  %269 = load i32, ptr %18, align 4
  %270 = zext i32 %269 to i64
  %271 = getelementptr inbounds [288 x i8], ptr %268, i64 0, i64 %270
  %272 = load i8, ptr %271, align 1
  %273 = zext i8 %272 to i32
  %274 = load i32, ptr %9, align 4
  %275 = add i32 %274, %273
  store i32 %275, ptr %9, align 4
  %276 = load i32, ptr %4, align 4
  %277 = and i32 %276, 2
  %278 = icmp eq i32 %277, 0
  br i1 %278, label %279, label %383

279:                                              ; preds = %252
  %280 = load ptr, ptr %5, align 8
  %281 = load ptr, ptr %7, align 8
  %282 = icmp ult ptr %280, %281
  br i1 %282, label %283, label %383

283:                                              ; preds = %279
  %284 = load i32, ptr %4, align 4
  %285 = lshr i32 %284, 1
  store i32 %285, ptr %4, align 4
  %286 = load ptr, ptr %5, align 8
  %287 = getelementptr inbounds i8, ptr %286, i32 1
  store ptr %287, ptr %5, align 8
  %288 = load i8, ptr %286, align 1
  %289 = zext i8 %288 to i32
  store i32 %289, ptr %18, align 4
  %290 = load ptr, ptr %3, align 8
  %291 = getelementptr inbounds %struct.tdefl_compressor, ptr %290, i32 0, i32 39
  %292 = getelementptr inbounds [3 x [288 x i8]], ptr %291, i64 0, i64 0
  %293 = load i32, ptr %18, align 4
  %294 = zext i32 %293 to i64
  %295 = getelementptr inbounds [288 x i8], ptr %292, i64 0, i64 %294
  %296 = load i8, ptr %295, align 1
  %297 = icmp ne i8 %296, 0
  %298 = xor i1 %297, true
  %299 = zext i1 %298 to i32
  %300 = sext i32 %299 to i64
  %301 = icmp ne i64 %300, 0
  br i1 %301, label %302, label %304

302:                                              ; preds = %283
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1722, ptr noundef @.str.43) #14
  unreachable

303:                                              ; No predecessors!
  br label %305

304:                                              ; preds = %283
  br label %305

305:                                              ; preds = %304, %303
  %306 = load ptr, ptr %3, align 8
  %307 = getelementptr inbounds %struct.tdefl_compressor, ptr %306, i32 0, i32 38
  %308 = getelementptr inbounds [3 x [288 x i32]], ptr %307, i64 0, i64 0
  %309 = load i32, ptr %18, align 4
  %310 = zext i32 %309 to i64
  %311 = getelementptr inbounds [288 x i32], ptr %308, i64 0, i64 %310
  %312 = load i32, ptr %311, align 2
  %313 = zext i32 %312 to i64
  %314 = load i32, ptr %9, align 4
  %315 = zext i32 %314 to i64
  %316 = shl i64 %313, %315
  %317 = load i64, ptr %8, align 8
  %318 = or i64 %317, %316
  store i64 %318, ptr %8, align 8
  %319 = load ptr, ptr %3, align 8
  %320 = getelementptr inbounds %struct.tdefl_compressor, ptr %319, i32 0, i32 39
  %321 = getelementptr inbounds [3 x [288 x i8]], ptr %320, i64 0, i64 0
  %322 = load i32, ptr %18, align 4
  %323 = zext i32 %322 to i64
  %324 = getelementptr inbounds [288 x i8], ptr %321, i64 0, i64 %323
  %325 = load i8, ptr %324, align 1
  %326 = zext i8 %325 to i32
  %327 = load i32, ptr %9, align 4
  %328 = add i32 %327, %326
  store i32 %328, ptr %9, align 4
  %329 = load i32, ptr %4, align 4
  %330 = and i32 %329, 2
  %331 = icmp eq i32 %330, 0
  br i1 %331, label %332, label %382

332:                                              ; preds = %305
  %333 = load ptr, ptr %5, align 8
  %334 = load ptr, ptr %7, align 8
  %335 = icmp ult ptr %333, %334
  br i1 %335, label %336, label %382

336:                                              ; preds = %332
  %337 = load i32, ptr %4, align 4
  %338 = lshr i32 %337, 1
  store i32 %338, ptr %4, align 4
  %339 = load ptr, ptr %5, align 8
  %340 = getelementptr inbounds i8, ptr %339, i32 1
  store ptr %340, ptr %5, align 8
  %341 = load i8, ptr %339, align 1
  %342 = zext i8 %341 to i32
  store i32 %342, ptr %18, align 4
  %343 = load ptr, ptr %3, align 8
  %344 = getelementptr inbounds %struct.tdefl_compressor, ptr %343, i32 0, i32 39
  %345 = getelementptr inbounds [3 x [288 x i8]], ptr %344, i64 0, i64 0
  %346 = load i32, ptr %18, align 4
  %347 = zext i32 %346 to i64
  %348 = getelementptr inbounds [288 x i8], ptr %345, i64 0, i64 %347
  %349 = load i8, ptr %348, align 1
  %350 = icmp ne i8 %349, 0
  %351 = xor i1 %350, true
  %352 = zext i1 %351 to i32
  %353 = sext i32 %352 to i64
  %354 = icmp ne i64 %353, 0
  br i1 %354, label %355, label %357

355:                                              ; preds = %336
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1729, ptr noundef @.str.43) #14
  unreachable

356:                                              ; No predecessors!
  br label %358

357:                                              ; preds = %336
  br label %358

358:                                              ; preds = %357, %356
  %359 = load ptr, ptr %3, align 8
  %360 = getelementptr inbounds %struct.tdefl_compressor, ptr %359, i32 0, i32 38
  %361 = getelementptr inbounds [3 x [288 x i32]], ptr %360, i64 0, i64 0
  %362 = load i32, ptr %18, align 4
  %363 = zext i32 %362 to i64
  %364 = getelementptr inbounds [288 x i32], ptr %361, i64 0, i64 %363
  %365 = load i32, ptr %364, align 2
  %366 = zext i32 %365 to i64
  %367 = load i32, ptr %9, align 4
  %368 = zext i32 %367 to i64
  %369 = shl i64 %366, %368
  %370 = load i64, ptr %8, align 8
  %371 = or i64 %370, %369
  store i64 %371, ptr %8, align 8
  %372 = load ptr, ptr %3, align 8
  %373 = getelementptr inbounds %struct.tdefl_compressor, ptr %372, i32 0, i32 39
  %374 = getelementptr inbounds [3 x [288 x i8]], ptr %373, i64 0, i64 0
  %375 = load i32, ptr %18, align 4
  %376 = zext i32 %375 to i64
  %377 = getelementptr inbounds [288 x i8], ptr %374, i64 0, i64 %376
  %378 = load i8, ptr %377, align 1
  %379 = zext i8 %378 to i32
  %380 = load i32, ptr %9, align 4
  %381 = add i32 %380, %379
  store i32 %381, ptr %9, align 4
  br label %382

382:                                              ; preds = %358, %332, %305
  br label %383

383:                                              ; preds = %382, %279, %252
  br label %384

384:                                              ; preds = %383, %193
  %385 = load ptr, ptr %6, align 8
  %386 = load ptr, ptr %3, align 8
  %387 = getelementptr inbounds %struct.tdefl_compressor, ptr %386, i32 0, i32 13
  %388 = load ptr, ptr %387, align 8
  %389 = icmp uge ptr %385, %388
  br i1 %389, label %390, label %391

390:                                              ; preds = %384
  store i32 0, ptr %2, align 4
  br label %586

391:                                              ; preds = %384
  %392 = load i64, ptr %8, align 8
  %393 = load ptr, ptr %6, align 8
  store i64 %392, ptr %393, align 8
  %394 = load i32, ptr %9, align 4
  %395 = lshr i32 %394, 3
  %396 = load ptr, ptr %6, align 8
  %397 = zext i32 %395 to i64
  %398 = getelementptr inbounds i8, ptr %396, i64 %397
  store ptr %398, ptr %6, align 8
  %399 = load i32, ptr %9, align 4
  %400 = and i32 %399, -8
  %401 = load i64, ptr %8, align 8
  %402 = zext i32 %400 to i64
  %403 = lshr i64 %401, %402
  store i64 %403, ptr %8, align 8
  %404 = load i32, ptr %9, align 4
  %405 = and i32 %404, 7
  store i32 %405, ptr %9, align 4
  br label %406

406:                                              ; preds = %391
  %407 = load i32, ptr %4, align 4
  %408 = lshr i32 %407, 1
  store i32 %408, ptr %4, align 4
  br label %40, !llvm.loop !122

409:                                              ; preds = %40
  %410 = load ptr, ptr %6, align 8
  %411 = load ptr, ptr %3, align 8
  %412 = getelementptr inbounds %struct.tdefl_compressor, ptr %411, i32 0, i32 12
  store ptr %410, ptr %412, align 8
  %413 = load ptr, ptr %3, align 8
  %414 = getelementptr inbounds %struct.tdefl_compressor, ptr %413, i32 0, i32 17
  store i32 0, ptr %414, align 4
  %415 = load ptr, ptr %3, align 8
  %416 = getelementptr inbounds %struct.tdefl_compressor, ptr %415, i32 0, i32 18
  store i32 0, ptr %416, align 8
  br label %417

417:                                              ; preds = %496, %409
  %418 = load i32, ptr %9, align 4
  %419 = icmp ne i32 %418, 0
  br i1 %419, label %420, label %504

420:                                              ; preds = %417
  %421 = load i32, ptr %9, align 4
  %422 = icmp ult i32 %421, 16
  br i1 %422, label %423, label %425

423:                                              ; preds = %420
  %424 = load i32, ptr %9, align 4
  br label %426

425:                                              ; preds = %420
  br label %426

426:                                              ; preds = %425, %423
  %427 = phi i32 [ %424, %423 ], [ 16, %425 ]
  store i32 %427, ptr %19, align 4
  br label %428

428:                                              ; preds = %426
  %429 = load i64, ptr %8, align 8
  %430 = trunc i64 %429 to i32
  %431 = load i32, ptr %19, align 4
  %432 = zext i32 %431 to i64
  %433 = getelementptr inbounds [17 x i32], ptr @mz_bitmasks, i64 0, i64 %432
  %434 = load i32, ptr %433, align 4
  %435 = and i32 %430, %434
  store i32 %435, ptr %20, align 4
  %436 = load i32, ptr %19, align 4
  store i32 %436, ptr %21, align 4
  %437 = load i32, ptr %20, align 4
  %438 = load i32, ptr %21, align 4
  %439 = shl i32 1, %438
  %440 = sub i32 %439, 1
  %441 = icmp ule i32 %437, %440
  %442 = xor i1 %441, true
  %443 = zext i1 %442 to i32
  %444 = sext i32 %443 to i64
  %445 = icmp ne i64 %444, 0
  br i1 %445, label %446, label %448

446:                                              ; preds = %428
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1753, ptr noundef @.str.38) #14
  unreachable

447:                                              ; No predecessors!
  br label %449

448:                                              ; preds = %428
  br label %449

449:                                              ; preds = %448, %447
  %450 = load i32, ptr %20, align 4
  %451 = load ptr, ptr %3, align 8
  %452 = getelementptr inbounds %struct.tdefl_compressor, ptr %451, i32 0, i32 17
  %453 = load i32, ptr %452, align 4
  %454 = shl i32 %450, %453
  %455 = load ptr, ptr %3, align 8
  %456 = getelementptr inbounds %struct.tdefl_compressor, ptr %455, i32 0, i32 18
  %457 = load i32, ptr %456, align 8
  %458 = or i32 %457, %454
  store i32 %458, ptr %456, align 8
  %459 = load i32, ptr %21, align 4
  %460 = load ptr, ptr %3, align 8
  %461 = getelementptr inbounds %struct.tdefl_compressor, ptr %460, i32 0, i32 17
  %462 = load i32, ptr %461, align 4
  %463 = add i32 %462, %459
  store i32 %463, ptr %461, align 4
  br label %464

464:                                              ; preds = %486, %449
  %465 = load ptr, ptr %3, align 8
  %466 = getelementptr inbounds %struct.tdefl_compressor, ptr %465, i32 0, i32 17
  %467 = load i32, ptr %466, align 4
  %468 = icmp uge i32 %467, 8
  br i1 %468, label %469, label %495

469:                                              ; preds = %464
  %470 = load ptr, ptr %3, align 8
  %471 = getelementptr inbounds %struct.tdefl_compressor, ptr %470, i32 0, i32 12
  %472 = load ptr, ptr %471, align 8
  %473 = load ptr, ptr %3, align 8
  %474 = getelementptr inbounds %struct.tdefl_compressor, ptr %473, i32 0, i32 13
  %475 = load ptr, ptr %474, align 8
  %476 = icmp ult ptr %472, %475
  br i1 %476, label %477, label %486

477:                                              ; preds = %469
  %478 = load ptr, ptr %3, align 8
  %479 = getelementptr inbounds %struct.tdefl_compressor, ptr %478, i32 0, i32 18
  %480 = load i32, ptr %479, align 8
  %481 = trunc i32 %480 to i8
  %482 = load ptr, ptr %3, align 8
  %483 = getelementptr inbounds %struct.tdefl_compressor, ptr %482, i32 0, i32 12
  %484 = load ptr, ptr %483, align 8
  %485 = getelementptr inbounds i8, ptr %484, i32 1
  store ptr %485, ptr %483, align 8
  store i8 %481, ptr %484, align 1
  br label %486

486:                                              ; preds = %477, %469
  %487 = load ptr, ptr %3, align 8
  %488 = getelementptr inbounds %struct.tdefl_compressor, ptr %487, i32 0, i32 18
  %489 = load i32, ptr %488, align 8
  %490 = lshr i32 %489, 8
  store i32 %490, ptr %488, align 8
  %491 = load ptr, ptr %3, align 8
  %492 = getelementptr inbounds %struct.tdefl_compressor, ptr %491, i32 0, i32 17
  %493 = load i32, ptr %492, align 4
  %494 = sub i32 %493, 8
  store i32 %494, ptr %492, align 4
  br label %464, !llvm.loop !123

495:                                              ; preds = %464
  br label %496

496:                                              ; preds = %495
  %497 = load i32, ptr %19, align 4
  %498 = load i64, ptr %8, align 8
  %499 = zext i32 %497 to i64
  %500 = lshr i64 %498, %499
  store i64 %500, ptr %8, align 8
  %501 = load i32, ptr %19, align 4
  %502 = load i32, ptr %9, align 4
  %503 = sub i32 %502, %501
  store i32 %503, ptr %9, align 4
  br label %417, !llvm.loop !124

504:                                              ; preds = %417
  br label %505

505:                                              ; preds = %504
  %506 = load ptr, ptr %3, align 8
  %507 = getelementptr inbounds %struct.tdefl_compressor, ptr %506, i32 0, i32 38
  %508 = getelementptr inbounds [3 x [288 x i32]], ptr %507, i64 0, i64 0
  %509 = getelementptr inbounds [288 x i32], ptr %508, i64 0, i64 256
  %510 = load i32, ptr %509, align 2
  %511 = add i32 %510, 0
  store i32 %511, ptr %22, align 4
  %512 = load ptr, ptr %3, align 8
  %513 = getelementptr inbounds %struct.tdefl_compressor, ptr %512, i32 0, i32 39
  %514 = getelementptr inbounds [3 x [288 x i8]], ptr %513, i64 0, i64 0
  %515 = getelementptr inbounds [288 x i8], ptr %514, i64 0, i64 256
  %516 = load i8, ptr %515, align 2
  %517 = zext i8 %516 to i32
  store i32 %517, ptr %23, align 4
  %518 = load i32, ptr %22, align 4
  %519 = load i32, ptr %23, align 4
  %520 = shl i32 1, %519
  %521 = sub i32 %520, 1
  %522 = icmp ule i32 %518, %521
  %523 = xor i1 %522, true
  %524 = zext i1 %523 to i32
  %525 = sext i32 %524 to i64
  %526 = icmp ne i64 %525, 0
  br i1 %526, label %527, label %529

527:                                              ; preds = %505
  call void @__assert_rtn(ptr noundef @__func__.tdefl_compress_lz_codes, ptr noundef @.str.14, i32 noundef 1758, ptr noundef @.str.38) #14
  unreachable

528:                                              ; No predecessors!
  br label %530

529:                                              ; preds = %505
  br label %530

530:                                              ; preds = %529, %528
  %531 = load i32, ptr %22, align 4
  %532 = load ptr, ptr %3, align 8
  %533 = getelementptr inbounds %struct.tdefl_compressor, ptr %532, i32 0, i32 17
  %534 = load i32, ptr %533, align 4
  %535 = shl i32 %531, %534
  %536 = load ptr, ptr %3, align 8
  %537 = getelementptr inbounds %struct.tdefl_compressor, ptr %536, i32 0, i32 18
  %538 = load i32, ptr %537, align 8
  %539 = or i32 %538, %535
  store i32 %539, ptr %537, align 8
  %540 = load i32, ptr %23, align 4
  %541 = load ptr, ptr %3, align 8
  %542 = getelementptr inbounds %struct.tdefl_compressor, ptr %541, i32 0, i32 17
  %543 = load i32, ptr %542, align 4
  %544 = add i32 %543, %540
  store i32 %544, ptr %542, align 4
  br label %545

545:                                              ; preds = %567, %530
  %546 = load ptr, ptr %3, align 8
  %547 = getelementptr inbounds %struct.tdefl_compressor, ptr %546, i32 0, i32 17
  %548 = load i32, ptr %547, align 4
  %549 = icmp uge i32 %548, 8
  br i1 %549, label %550, label %576

550:                                              ; preds = %545
  %551 = load ptr, ptr %3, align 8
  %552 = getelementptr inbounds %struct.tdefl_compressor, ptr %551, i32 0, i32 12
  %553 = load ptr, ptr %552, align 8
  %554 = load ptr, ptr %3, align 8
  %555 = getelementptr inbounds %struct.tdefl_compressor, ptr %554, i32 0, i32 13
  %556 = load ptr, ptr %555, align 8
  %557 = icmp ult ptr %553, %556
  br i1 %557, label %558, label %567

558:                                              ; preds = %550
  %559 = load ptr, ptr %3, align 8
  %560 = getelementptr inbounds %struct.tdefl_compressor, ptr %559, i32 0, i32 18
  %561 = load i32, ptr %560, align 8
  %562 = trunc i32 %561 to i8
  %563 = load ptr, ptr %3, align 8
  %564 = getelementptr inbounds %struct.tdefl_compressor, ptr %563, i32 0, i32 12
  %565 = load ptr, ptr %564, align 8
  %566 = getelementptr inbounds i8, ptr %565, i32 1
  store ptr %566, ptr %564, align 8
  store i8 %562, ptr %565, align 1
  br label %567

567:                                              ; preds = %558, %550
  %568 = load ptr, ptr %3, align 8
  %569 = getelementptr inbounds %struct.tdefl_compressor, ptr %568, i32 0, i32 18
  %570 = load i32, ptr %569, align 8
  %571 = lshr i32 %570, 8
  store i32 %571, ptr %569, align 8
  %572 = load ptr, ptr %3, align 8
  %573 = getelementptr inbounds %struct.tdefl_compressor, ptr %572, i32 0, i32 17
  %574 = load i32, ptr %573, align 4
  %575 = sub i32 %574, 8
  store i32 %575, ptr %573, align 4
  br label %545, !llvm.loop !125

576:                                              ; preds = %545
  br label %577

577:                                              ; preds = %576
  %578 = load ptr, ptr %3, align 8
  %579 = getelementptr inbounds %struct.tdefl_compressor, ptr %578, i32 0, i32 12
  %580 = load ptr, ptr %579, align 8
  %581 = load ptr, ptr %3, align 8
  %582 = getelementptr inbounds %struct.tdefl_compressor, ptr %581, i32 0, i32 13
  %583 = load ptr, ptr %582, align 8
  %584 = icmp ult ptr %580, %583
  %585 = zext i1 %584 to i32
  store i32 %585, ptr %2, align 4
  br label %586

586:                                              ; preds = %577, %390
  %587 = load i32, ptr %2, align 4
  ret i32 %587
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_optimize_huffman_table(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4) #0 {
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca [33 x i32], align 16
  %15 = alloca [33 x i32], align 16
  %16 = alloca [288 x %struct.tdefl_sym_freq], align 16
  %17 = alloca [288 x %struct.tdefl_sym_freq], align 16
  %18 = alloca ptr, align 8
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  store i32 %4, ptr %10, align 4
  call void @llvm.memset.p0.i64(ptr align 16 %14, i8 0, i64 132, i1 false)
  %24 = load i32, ptr %10, align 4
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %49

26:                                               ; preds = %5
  store i32 0, ptr %11, align 4
  br label %27

27:                                               ; preds = %45, %26
  %28 = load i32, ptr %11, align 4
  %29 = load i32, ptr %8, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %48

31:                                               ; preds = %27
  %32 = load ptr, ptr %6, align 8
  %33 = getelementptr inbounds %struct.tdefl_compressor, ptr %32, i32 0, i32 39
  %34 = load i32, ptr %7, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [3 x [288 x i8]], ptr %33, i64 0, i64 %35
  %37 = load i32, ptr %11, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [288 x i8], ptr %36, i64 0, i64 %38
  %40 = load i8, ptr %39, align 1
  %41 = zext i8 %40 to i64
  %42 = getelementptr inbounds [33 x i32], ptr %14, i64 0, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %42, align 4
  br label %45

45:                                               ; preds = %31
  %46 = load i32, ptr %11, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, ptr %11, align 4
  br label %27, !llvm.loop !126

48:                                               ; preds = %27
  br label %179

49:                                               ; preds = %5
  store i32 0, ptr %19, align 4
  %50 = load ptr, ptr %6, align 8
  %51 = getelementptr inbounds %struct.tdefl_compressor, ptr %50, i32 0, i32 37
  %52 = load i32, ptr %7, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [3 x [288 x i32]], ptr %51, i64 0, i64 %53
  %55 = getelementptr inbounds [288 x i32], ptr %54, i64 0, i64 0
  store ptr %55, ptr %20, align 8
  store i32 0, ptr %11, align 4
  br label %56

56:                                               ; preds = %85, %49
  %57 = load i32, ptr %11, align 4
  %58 = load i32, ptr %8, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %88

60:                                               ; preds = %56
  %61 = load ptr, ptr %20, align 8
  %62 = load i32, ptr %11, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds i32, ptr %61, i64 %63
  %65 = load i32, ptr %64, align 2
  %66 = icmp ne i32 %65, 0
  br i1 %66, label %67, label %84

67:                                               ; preds = %60
  %68 = load ptr, ptr %20, align 8
  %69 = load i32, ptr %11, align 4
  %70 = sext i32 %69 to i64
  %71 = getelementptr inbounds i32, ptr %68, i64 %70
  %72 = load i32, ptr %71, align 2
  %73 = load i32, ptr %19, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [288 x %struct.tdefl_sym_freq], ptr %16, i64 0, i64 %74
  %76 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %75, i32 0, i32 0
  store i32 %72, ptr %76, align 4
  %77 = load i32, ptr %11, align 4
  %78 = add i32 %77, 0
  %79 = load i32, ptr %19, align 4
  %80 = add nsw i32 %79, 1
  store i32 %80, ptr %19, align 4
  %81 = sext i32 %79 to i64
  %82 = getelementptr inbounds [288 x %struct.tdefl_sym_freq], ptr %16, i64 0, i64 %81
  %83 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %82, i32 0, i32 1
  store i32 %78, ptr %83, align 2
  br label %84

84:                                               ; preds = %67, %60
  br label %85

85:                                               ; preds = %84
  %86 = load i32, ptr %11, align 4
  %87 = add nsw i32 %86, 1
  store i32 %87, ptr %11, align 4
  br label %56, !llvm.loop !127

88:                                               ; preds = %56
  %89 = load i32, ptr %19, align 4
  %90 = getelementptr inbounds [288 x %struct.tdefl_sym_freq], ptr %16, i64 0, i64 0
  %91 = getelementptr inbounds [288 x %struct.tdefl_sym_freq], ptr %17, i64 0, i64 0
  %92 = call ptr @tdefl_radix_sort_syms(i32 noundef %89, ptr noundef %90, ptr noundef %91)
  store ptr %92, ptr %18, align 8
  %93 = load ptr, ptr %18, align 8
  %94 = load i32, ptr %19, align 4
  call void @tdefl_calculate_minimum_redundancy(ptr noundef %93, i32 noundef %94)
  store i32 0, ptr %11, align 4
  br label %95

95:                                               ; preds = %110, %88
  %96 = load i32, ptr %11, align 4
  %97 = load i32, ptr %19, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %113

99:                                               ; preds = %95
  %100 = load ptr, ptr %18, align 8
  %101 = load i32, ptr %11, align 4
  %102 = sext i32 %101 to i64
  %103 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %100, i64 %102
  %104 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %103, i32 0, i32 0
  %105 = load i32, ptr %104, align 2
  %106 = zext i32 %105 to i64
  %107 = getelementptr inbounds [33 x i32], ptr %14, i64 0, i64 %106
  %108 = load i32, ptr %107, align 4
  %109 = add nsw i32 %108, 1
  store i32 %109, ptr %107, align 4
  br label %110

110:                                              ; preds = %99
  %111 = load i32, ptr %11, align 4
  %112 = add nsw i32 %111, 1
  store i32 %112, ptr %11, align 4
  br label %95, !llvm.loop !128

113:                                              ; preds = %95
  %114 = getelementptr inbounds [33 x i32], ptr %14, i64 0, i64 0
  %115 = load i32, ptr %19, align 4
  %116 = load i32, ptr %9, align 4
  call void @tdefl_huffman_enforce_max_code_size(ptr noundef %114, i32 noundef %115, i32 noundef %116)
  %117 = load ptr, ptr %6, align 8
  %118 = getelementptr inbounds %struct.tdefl_compressor, ptr %117, i32 0, i32 39
  %119 = load i32, ptr %7, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [3 x [288 x i8]], ptr %118, i64 0, i64 %120
  %122 = load ptr, ptr %6, align 8
  %123 = getelementptr inbounds %struct.tdefl_compressor, ptr %122, i32 0, i32 39
  %124 = load i32, ptr %7, align 4
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds [3 x [288 x i8]], ptr %123, i64 0, i64 %125
  %127 = call i64 @llvm.objectsize.i64.p0(ptr %126, i1 false, i1 true, i1 false)
  %128 = call ptr @__memset_chk(ptr noundef %121, i32 noundef 0, i64 noundef 288, i64 noundef %127) #12
  %129 = load ptr, ptr %6, align 8
  %130 = getelementptr inbounds %struct.tdefl_compressor, ptr %129, i32 0, i32 38
  %131 = load i32, ptr %7, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [3 x [288 x i32]], ptr %130, i64 0, i64 %132
  %134 = load ptr, ptr %6, align 8
  %135 = getelementptr inbounds %struct.tdefl_compressor, ptr %134, i32 0, i32 38
  %136 = load i32, ptr %7, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds [3 x [288 x i32]], ptr %135, i64 0, i64 %137
  %139 = call i64 @llvm.objectsize.i64.p0(ptr %138, i1 false, i1 true, i1 false)
  %140 = call ptr @__memset_chk(ptr noundef %133, i32 noundef 0, i64 noundef 576, i64 noundef %139) #12
  store i32 1, ptr %11, align 4
  %141 = load i32, ptr %19, align 4
  store i32 %141, ptr %12, align 4
  br label %142

142:                                              ; preds = %175, %113
  %143 = load i32, ptr %11, align 4
  %144 = load i32, ptr %9, align 4
  %145 = icmp sle i32 %143, %144
  br i1 %145, label %146, label %178

146:                                              ; preds = %142
  %147 = load i32, ptr %11, align 4
  %148 = sext i32 %147 to i64
  %149 = getelementptr inbounds [33 x i32], ptr %14, i64 0, i64 %148
  %150 = load i32, ptr %149, align 4
  store i32 %150, ptr %13, align 4
  br label %151

151:                                              ; preds = %171, %146
  %152 = load i32, ptr %13, align 4
  %153 = icmp sgt i32 %152, 0
  br i1 %153, label %154, label %174

154:                                              ; preds = %151
  %155 = load i32, ptr %11, align 4
  %156 = trunc i32 %155 to i8
  %157 = load ptr, ptr %6, align 8
  %158 = getelementptr inbounds %struct.tdefl_compressor, ptr %157, i32 0, i32 39
  %159 = load i32, ptr %7, align 4
  %160 = sext i32 %159 to i64
  %161 = getelementptr inbounds [3 x [288 x i8]], ptr %158, i64 0, i64 %160
  %162 = load ptr, ptr %18, align 8
  %163 = load i32, ptr %12, align 4
  %164 = add nsw i32 %163, -1
  store i32 %164, ptr %12, align 4
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %162, i64 %165
  %167 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %166, i32 0, i32 1
  %168 = load i32, ptr %167, align 2
  %169 = zext i32 %168 to i64
  %170 = getelementptr inbounds [288 x i8], ptr %161, i64 0, i64 %169
  store i8 %156, ptr %170, align 1
  br label %171

171:                                              ; preds = %154
  %172 = load i32, ptr %13, align 4
  %173 = add nsw i32 %172, -1
  store i32 %173, ptr %13, align 4
  br label %151, !llvm.loop !129

174:                                              ; preds = %151
  br label %175

175:                                              ; preds = %174
  %176 = load i32, ptr %11, align 4
  %177 = add nsw i32 %176, 1
  store i32 %177, ptr %11, align 4
  br label %142, !llvm.loop !130

178:                                              ; preds = %142
  br label %179

179:                                              ; preds = %178, %48
  %180 = getelementptr inbounds [33 x i32], ptr %15, i64 0, i64 1
  store i32 0, ptr %180, align 4
  store i32 0, ptr %12, align 4
  store i32 2, ptr %11, align 4
  br label %181

181:                                              ; preds = %197, %179
  %182 = load i32, ptr %11, align 4
  %183 = load i32, ptr %9, align 4
  %184 = icmp sle i32 %182, %183
  br i1 %184, label %185, label %200

185:                                              ; preds = %181
  %186 = load i32, ptr %12, align 4
  %187 = load i32, ptr %11, align 4
  %188 = sub nsw i32 %187, 1
  %189 = sext i32 %188 to i64
  %190 = getelementptr inbounds [33 x i32], ptr %14, i64 0, i64 %189
  %191 = load i32, ptr %190, align 4
  %192 = add nsw i32 %186, %191
  %193 = shl i32 %192, 1
  store i32 %193, ptr %12, align 4
  %194 = load i32, ptr %11, align 4
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds [33 x i32], ptr %15, i64 0, i64 %195
  store i32 %193, ptr %196, align 4
  br label %197

197:                                              ; preds = %185
  %198 = load i32, ptr %11, align 4
  %199 = add nsw i32 %198, 1
  store i32 %199, ptr %11, align 4
  br label %181, !llvm.loop !131

200:                                              ; preds = %181
  store i32 0, ptr %11, align 4
  br label %201

201:                                              ; preds = %250, %200
  %202 = load i32, ptr %11, align 4
  %203 = load i32, ptr %8, align 4
  %204 = icmp slt i32 %202, %203
  br i1 %204, label %205, label %253

205:                                              ; preds = %201
  store i32 0, ptr %21, align 4
  %206 = load ptr, ptr %6, align 8
  %207 = getelementptr inbounds %struct.tdefl_compressor, ptr %206, i32 0, i32 39
  %208 = load i32, ptr %7, align 4
  %209 = sext i32 %208 to i64
  %210 = getelementptr inbounds [3 x [288 x i8]], ptr %207, i64 0, i64 %209
  %211 = load i32, ptr %11, align 4
  %212 = sext i32 %211 to i64
  %213 = getelementptr inbounds [288 x i8], ptr %210, i64 0, i64 %212
  %214 = load i8, ptr %213, align 1
  %215 = zext i8 %214 to i32
  store i32 %215, ptr %23, align 4
  %216 = icmp eq i32 %215, 0
  br i1 %216, label %217, label %218

217:                                              ; preds = %205
  br label %250

218:                                              ; preds = %205
  %219 = load i32, ptr %23, align 4
  %220 = zext i32 %219 to i64
  %221 = getelementptr inbounds [33 x i32], ptr %15, i64 0, i64 %220
  %222 = load i32, ptr %221, align 4
  %223 = add i32 %222, 1
  store i32 %223, ptr %221, align 4
  store i32 %222, ptr %22, align 4
  %224 = load i32, ptr %23, align 4
  store i32 %224, ptr %13, align 4
  br label %225

225:                                              ; preds = %234, %218
  %226 = load i32, ptr %13, align 4
  %227 = icmp sgt i32 %226, 0
  br i1 %227, label %228, label %239

228:                                              ; preds = %225
  %229 = load i32, ptr %21, align 4
  %230 = shl i32 %229, 1
  %231 = load i32, ptr %22, align 4
  %232 = and i32 %231, 1
  %233 = or i32 %230, %232
  store i32 %233, ptr %21, align 4
  br label %234

234:                                              ; preds = %228
  %235 = load i32, ptr %13, align 4
  %236 = add nsw i32 %235, -1
  store i32 %236, ptr %13, align 4
  %237 = load i32, ptr %22, align 4
  %238 = lshr i32 %237, 1
  store i32 %238, ptr %22, align 4
  br label %225, !llvm.loop !132

239:                                              ; preds = %225
  %240 = load i32, ptr %21, align 4
  %241 = add i32 %240, 0
  %242 = load ptr, ptr %6, align 8
  %243 = getelementptr inbounds %struct.tdefl_compressor, ptr %242, i32 0, i32 38
  %244 = load i32, ptr %7, align 4
  %245 = sext i32 %244 to i64
  %246 = getelementptr inbounds [3 x [288 x i32]], ptr %243, i64 0, i64 %245
  %247 = load i32, ptr %11, align 4
  %248 = sext i32 %247 to i64
  %249 = getelementptr inbounds [288 x i32], ptr %246, i64 0, i64 %248
  store i32 %241, ptr %249, align 2
  br label %250

250:                                              ; preds = %239, %217
  %251 = load i32, ptr %11, align 4
  %252 = add nsw i32 %251, 1
  store i32 %252, ptr %11, align 4
  br label %201, !llvm.loop !133

253:                                              ; preds = %201
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal ptr @tdefl_radix_sort_syms(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca [512 x i32], align 16
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca i32, align 4
  %15 = alloca ptr, align 8
  %16 = alloca [256 x i32], align 16
  %17 = alloca i32, align 4
  %18 = alloca ptr, align 8
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 2, ptr %7, align 4
  %19 = load ptr, ptr %5, align 8
  store ptr %19, ptr %12, align 8
  %20 = load ptr, ptr %6, align 8
  store ptr %20, ptr %13, align 8
  call void @llvm.memset.p0.i64(ptr align 16 %11, i8 0, i64 2048, i1 false)
  store i32 0, ptr %10, align 4
  br label %21

21:                                               ; preds = %47, %3
  %22 = load i32, ptr %10, align 4
  %23 = load i32, ptr %4, align 4
  %24 = icmp ult i32 %22, %23
  br i1 %24, label %25, label %50

25:                                               ; preds = %21
  %26 = load ptr, ptr %5, align 8
  %27 = load i32, ptr %10, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %26, i64 %28
  %30 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %29, i32 0, i32 0
  %31 = load i32, ptr %30, align 2
  %32 = add i32 %31, 0
  store i32 %32, ptr %14, align 4
  %33 = load i32, ptr %14, align 4
  %34 = and i32 %33, 255
  %35 = zext i32 %34 to i64
  %36 = getelementptr inbounds [512 x i32], ptr %11, i64 0, i64 %35
  %37 = load i32, ptr %36, align 4
  %38 = add i32 %37, 1
  store i32 %38, ptr %36, align 4
  %39 = load i32, ptr %14, align 4
  %40 = lshr i32 %39, 8
  %41 = and i32 %40, 255
  %42 = add i32 256, %41
  %43 = zext i32 %42 to i64
  %44 = getelementptr inbounds [512 x i32], ptr %11, i64 0, i64 %43
  %45 = load i32, ptr %44, align 4
  %46 = add i32 %45, 1
  store i32 %46, ptr %44, align 4
  br label %47

47:                                               ; preds = %25
  %48 = load i32, ptr %10, align 4
  %49 = add i32 %48, 1
  store i32 %49, ptr %10, align 4
  br label %21, !llvm.loop !134

50:                                               ; preds = %21
  br label %51

51:                                               ; preds = %65, %50
  %52 = load i32, ptr %7, align 4
  %53 = icmp ugt i32 %52, 1
  br i1 %53, label %54, label %63

54:                                               ; preds = %51
  %55 = load i32, ptr %4, align 4
  %56 = load i32, ptr %7, align 4
  %57 = sub i32 %56, 1
  %58 = mul i32 %57, 256
  %59 = zext i32 %58 to i64
  %60 = getelementptr inbounds [512 x i32], ptr %11, i64 0, i64 %59
  %61 = load i32, ptr %60, align 4
  %62 = icmp eq i32 %55, %61
  br label %63

63:                                               ; preds = %54, %51
  %64 = phi i1 [ false, %51 ], [ %62, %54 ]
  br i1 %64, label %65, label %68

65:                                               ; preds = %63
  %66 = load i32, ptr %7, align 4
  %67 = add i32 %66, -1
  store i32 %67, ptr %7, align 4
  br label %51, !llvm.loop !135

68:                                               ; preds = %63
  store i32 0, ptr %8, align 4
  store i32 0, ptr %9, align 4
  br label %69

69:                                               ; preds = %130, %68
  %70 = load i32, ptr %9, align 4
  %71 = load i32, ptr %7, align 4
  %72 = icmp ult i32 %70, %71
  br i1 %72, label %73, label %135

73:                                               ; preds = %69
  %74 = load i32, ptr %9, align 4
  %75 = shl i32 %74, 8
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds [512 x i32], ptr %11, i64 0, i64 %76
  store ptr %77, ptr %15, align 8
  store i32 0, ptr %17, align 4
  store i32 0, ptr %10, align 4
  br label %78

78:                                               ; preds = %93, %73
  %79 = load i32, ptr %10, align 4
  %80 = icmp ult i32 %79, 256
  br i1 %80, label %81, label %96

81:                                               ; preds = %78
  %82 = load i32, ptr %17, align 4
  %83 = load i32, ptr %10, align 4
  %84 = zext i32 %83 to i64
  %85 = getelementptr inbounds [256 x i32], ptr %16, i64 0, i64 %84
  store i32 %82, ptr %85, align 4
  %86 = load ptr, ptr %15, align 8
  %87 = load i32, ptr %10, align 4
  %88 = zext i32 %87 to i64
  %89 = getelementptr inbounds i32, ptr %86, i64 %88
  %90 = load i32, ptr %89, align 4
  %91 = load i32, ptr %17, align 4
  %92 = add i32 %91, %90
  store i32 %92, ptr %17, align 4
  br label %93

93:                                               ; preds = %81
  %94 = load i32, ptr %10, align 4
  %95 = add i32 %94, 1
  store i32 %95, ptr %10, align 4
  br label %78, !llvm.loop !136

96:                                               ; preds = %78
  store i32 0, ptr %10, align 4
  br label %97

97:                                               ; preds = %123, %96
  %98 = load i32, ptr %10, align 4
  %99 = load i32, ptr %4, align 4
  %100 = icmp ult i32 %98, %99
  br i1 %100, label %101, label %126

101:                                              ; preds = %97
  %102 = load ptr, ptr %13, align 8
  %103 = load ptr, ptr %12, align 8
  %104 = load i32, ptr %10, align 4
  %105 = zext i32 %104 to i64
  %106 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %103, i64 %105
  %107 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %106, i32 0, i32 0
  %108 = load i32, ptr %107, align 2
  %109 = add i32 %108, 0
  %110 = load i32, ptr %8, align 4
  %111 = ashr i32 %109, %110
  %112 = and i32 %111, 255
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [256 x i32], ptr %16, i64 0, i64 %113
  %115 = load i32, ptr %114, align 4
  %116 = add i32 %115, 1
  store i32 %116, ptr %114, align 4
  %117 = zext i32 %115 to i64
  %118 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %102, i64 %117
  %119 = load ptr, ptr %12, align 8
  %120 = load i32, ptr %10, align 4
  %121 = zext i32 %120 to i64
  %122 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %119, i64 %121
  call void @llvm.memcpy.p0.p0.i64(ptr align 2 %118, ptr align 2 %122, i64 4, i1 false)
  br label %123

123:                                              ; preds = %101
  %124 = load i32, ptr %10, align 4
  %125 = add i32 %124, 1
  store i32 %125, ptr %10, align 4
  br label %97, !llvm.loop !137

126:                                              ; preds = %97
  %127 = load ptr, ptr %12, align 8
  store ptr %127, ptr %18, align 8
  %128 = load ptr, ptr %13, align 8
  store ptr %128, ptr %12, align 8
  %129 = load ptr, ptr %18, align 8
  store ptr %129, ptr %13, align 8
  br label %130

130:                                              ; preds = %126
  %131 = load i32, ptr %9, align 4
  %132 = add i32 %131, 1
  store i32 %132, ptr %9, align 4
  %133 = load i32, ptr %8, align 4
  %134 = add i32 %133, 8
  store i32 %134, ptr %8, align 4
  br label %69, !llvm.loop !138

135:                                              ; preds = %69
  %136 = load ptr, ptr %12, align 8
  ret ptr %136
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_calculate_minimum_redundancy(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %2
  br label %259

14:                                               ; preds = %2
  %15 = load i32, ptr %4, align 4
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %21

17:                                               ; preds = %14
  %18 = load ptr, ptr %3, align 8
  %19 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %18, i64 0
  %20 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %19, i32 0, i32 0
  store i32 1, ptr %20, align 2
  br label %259

21:                                               ; preds = %14
  br label %22

22:                                               ; preds = %21
  %23 = load ptr, ptr %3, align 8
  %24 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %23, i64 1
  %25 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %24, i32 0, i32 0
  %26 = load i32, ptr %25, align 2
  %27 = add i32 %26, 0
  %28 = load ptr, ptr %3, align 8
  %29 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %28, i64 0
  %30 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %29, i32 0, i32 0
  %31 = load i32, ptr %30, align 2
  %32 = add i32 %31, 0
  %33 = add nsw i32 %32, %27
  %34 = add i32 %33, 0
  store i32 %34, ptr %30, align 2
  store i32 0, ptr %5, align 4
  store i32 2, ptr %6, align 4
  store i32 1, ptr %7, align 4
  br label %35

35:                                               ; preds = %171, %22
  %36 = load i32, ptr %7, align 4
  %37 = load i32, ptr %4, align 4
  %38 = sub nsw i32 %37, 1
  %39 = icmp slt i32 %36, %38
  br i1 %39, label %40, label %174

40:                                               ; preds = %35
  %41 = load i32, ptr %6, align 4
  %42 = load i32, ptr %4, align 4
  %43 = icmp sge i32 %41, %42
  br i1 %43, label %60, label %44

44:                                               ; preds = %40
  %45 = load ptr, ptr %3, align 8
  %46 = load i32, ptr %5, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %45, i64 %47
  %49 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %48, i32 0, i32 0
  %50 = load i32, ptr %49, align 2
  %51 = add i32 %50, 0
  %52 = load ptr, ptr %3, align 8
  %53 = load i32, ptr %6, align 4
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %52, i64 %54
  %56 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %55, i32 0, i32 0
  %57 = load i32, ptr %56, align 2
  %58 = add i32 %57, 0
  %59 = icmp slt i32 %51, %58
  br i1 %59, label %60, label %80

60:                                               ; preds = %44, %40
  %61 = load ptr, ptr %3, align 8
  %62 = load i32, ptr %5, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %61, i64 %63
  %65 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %64, i32 0, i32 0
  %66 = load i32, ptr %65, align 2
  %67 = load ptr, ptr %3, align 8
  %68 = load i32, ptr %7, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %67, i64 %69
  %71 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %70, i32 0, i32 0
  store i32 %66, ptr %71, align 2
  %72 = load i32, ptr %7, align 4
  %73 = add i32 %72, 0
  %74 = load ptr, ptr %3, align 8
  %75 = load i32, ptr %5, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, ptr %5, align 4
  %77 = sext i32 %75 to i64
  %78 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %74, i64 %77
  %79 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %78, i32 0, i32 0
  store i32 %73, ptr %79, align 2
  br label %93

80:                                               ; preds = %44
  %81 = load ptr, ptr %3, align 8
  %82 = load i32, ptr %6, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, ptr %6, align 4
  %84 = sext i32 %82 to i64
  %85 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %81, i64 %84
  %86 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %85, i32 0, i32 0
  %87 = load i32, ptr %86, align 2
  %88 = load ptr, ptr %3, align 8
  %89 = load i32, ptr %7, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %88, i64 %90
  %92 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %91, i32 0, i32 0
  store i32 %87, ptr %92, align 2
  br label %93

93:                                               ; preds = %80, %60
  %94 = load i32, ptr %6, align 4
  %95 = load i32, ptr %4, align 4
  %96 = icmp sge i32 %94, %95
  br i1 %96, label %117, label %97

97:                                               ; preds = %93
  %98 = load i32, ptr %5, align 4
  %99 = load i32, ptr %7, align 4
  %100 = icmp slt i32 %98, %99
  br i1 %100, label %101, label %147

101:                                              ; preds = %97
  %102 = load ptr, ptr %3, align 8
  %103 = load i32, ptr %5, align 4
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %102, i64 %104
  %106 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %105, i32 0, i32 0
  %107 = load i32, ptr %106, align 2
  %108 = add i32 %107, 0
  %109 = load ptr, ptr %3, align 8
  %110 = load i32, ptr %6, align 4
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %109, i64 %111
  %113 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %112, i32 0, i32 0
  %114 = load i32, ptr %113, align 2
  %115 = add i32 %114, 0
  %116 = icmp slt i32 %108, %115
  br i1 %116, label %117, label %147

117:                                              ; preds = %101, %93
  %118 = load ptr, ptr %3, align 8
  %119 = load i32, ptr %7, align 4
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %118, i64 %120
  %122 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %121, i32 0, i32 0
  %123 = load i32, ptr %122, align 2
  %124 = add i32 %123, 0
  %125 = load ptr, ptr %3, align 8
  %126 = load i32, ptr %5, align 4
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %125, i64 %127
  %129 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %128, i32 0, i32 0
  %130 = load i32, ptr %129, align 2
  %131 = add i32 %130, 0
  %132 = add nsw i32 %124, %131
  %133 = add i32 %132, 0
  %134 = load ptr, ptr %3, align 8
  %135 = load i32, ptr %7, align 4
  %136 = sext i32 %135 to i64
  %137 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %134, i64 %136
  %138 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %137, i32 0, i32 0
  store i32 %133, ptr %138, align 2
  %139 = load i32, ptr %7, align 4
  %140 = add i32 %139, 0
  %141 = load ptr, ptr %3, align 8
  %142 = load i32, ptr %5, align 4
  %143 = add nsw i32 %142, 1
  store i32 %143, ptr %5, align 4
  %144 = sext i32 %142 to i64
  %145 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %141, i64 %144
  %146 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %145, i32 0, i32 0
  store i32 %140, ptr %146, align 2
  br label %170

147:                                              ; preds = %101, %97
  %148 = load ptr, ptr %3, align 8
  %149 = load i32, ptr %7, align 4
  %150 = sext i32 %149 to i64
  %151 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %148, i64 %150
  %152 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %151, i32 0, i32 0
  %153 = load i32, ptr %152, align 2
  %154 = add i32 %153, 0
  %155 = load ptr, ptr %3, align 8
  %156 = load i32, ptr %6, align 4
  %157 = add nsw i32 %156, 1
  store i32 %157, ptr %6, align 4
  %158 = sext i32 %156 to i64
  %159 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %155, i64 %158
  %160 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %159, i32 0, i32 0
  %161 = load i32, ptr %160, align 2
  %162 = add i32 %161, 0
  %163 = add nsw i32 %154, %162
  %164 = add i32 %163, 0
  %165 = load ptr, ptr %3, align 8
  %166 = load i32, ptr %7, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %165, i64 %167
  %169 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %168, i32 0, i32 0
  store i32 %164, ptr %169, align 2
  br label %170

170:                                              ; preds = %147, %117
  br label %171

171:                                              ; preds = %170
  %172 = load i32, ptr %7, align 4
  %173 = add nsw i32 %172, 1
  store i32 %173, ptr %7, align 4
  br label %35, !llvm.loop !139

174:                                              ; preds = %35
  %175 = load ptr, ptr %3, align 8
  %176 = load i32, ptr %4, align 4
  %177 = sub nsw i32 %176, 2
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %175, i64 %178
  %180 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %179, i32 0, i32 0
  store i32 0, ptr %180, align 2
  %181 = load i32, ptr %4, align 4
  %182 = sub nsw i32 %181, 3
  store i32 %182, ptr %7, align 4
  br label %183

183:                                              ; preds = %206, %174
  %184 = load i32, ptr %7, align 4
  %185 = icmp sge i32 %184, 0
  br i1 %185, label %186, label %209

186:                                              ; preds = %183
  %187 = load ptr, ptr %3, align 8
  %188 = load ptr, ptr %3, align 8
  %189 = load i32, ptr %7, align 4
  %190 = sext i32 %189 to i64
  %191 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %188, i64 %190
  %192 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %191, i32 0, i32 0
  %193 = load i32, ptr %192, align 2
  %194 = zext i32 %193 to i64
  %195 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %187, i64 %194
  %196 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %195, i32 0, i32 0
  %197 = load i32, ptr %196, align 2
  %198 = add i32 %197, 0
  %199 = add nsw i32 %198, 1
  %200 = add i32 %199, 0
  %201 = load ptr, ptr %3, align 8
  %202 = load i32, ptr %7, align 4
  %203 = sext i32 %202 to i64
  %204 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %201, i64 %203
  %205 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %204, i32 0, i32 0
  store i32 %200, ptr %205, align 2
  br label %206

206:                                              ; preds = %186
  %207 = load i32, ptr %7, align 4
  %208 = add nsw i32 %207, -1
  store i32 %208, ptr %7, align 4
  br label %183, !llvm.loop !140

209:                                              ; preds = %183
  store i32 1, ptr %8, align 4
  store i32 0, ptr %10, align 4
  store i32 0, ptr %9, align 4
  %210 = load i32, ptr %4, align 4
  %211 = sub nsw i32 %210, 2
  store i32 %211, ptr %5, align 4
  %212 = load i32, ptr %4, align 4
  %213 = sub nsw i32 %212, 1
  store i32 %213, ptr %7, align 4
  br label %214

214:                                              ; preds = %254, %209
  %215 = load i32, ptr %8, align 4
  %216 = icmp sgt i32 %215, 0
  br i1 %216, label %217, label %259

217:                                              ; preds = %214
  br label %218

218:                                              ; preds = %233, %217
  %219 = load i32, ptr %5, align 4
  %220 = icmp sge i32 %219, 0
  br i1 %220, label %221, label %231

221:                                              ; preds = %218
  %222 = load ptr, ptr %3, align 8
  %223 = load i32, ptr %5, align 4
  %224 = sext i32 %223 to i64
  %225 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %222, i64 %224
  %226 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %225, i32 0, i32 0
  %227 = load i32, ptr %226, align 2
  %228 = add i32 %227, 0
  %229 = load i32, ptr %10, align 4
  %230 = icmp eq i32 %228, %229
  br label %231

231:                                              ; preds = %221, %218
  %232 = phi i1 [ false, %218 ], [ %230, %221 ]
  br i1 %232, label %233, label %238

233:                                              ; preds = %231
  %234 = load i32, ptr %9, align 4
  %235 = add nsw i32 %234, 1
  store i32 %235, ptr %9, align 4
  %236 = load i32, ptr %5, align 4
  %237 = add nsw i32 %236, -1
  store i32 %237, ptr %5, align 4
  br label %218, !llvm.loop !141

238:                                              ; preds = %231
  br label %239

239:                                              ; preds = %243, %238
  %240 = load i32, ptr %8, align 4
  %241 = load i32, ptr %9, align 4
  %242 = icmp sgt i32 %240, %241
  br i1 %242, label %243, label %254

243:                                              ; preds = %239
  %244 = load i32, ptr %10, align 4
  %245 = add i32 %244, 0
  %246 = load ptr, ptr %3, align 8
  %247 = load i32, ptr %7, align 4
  %248 = add nsw i32 %247, -1
  store i32 %248, ptr %7, align 4
  %249 = sext i32 %247 to i64
  %250 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %246, i64 %249
  %251 = getelementptr inbounds %struct.tdefl_sym_freq, ptr %250, i32 0, i32 0
  store i32 %245, ptr %251, align 2
  %252 = load i32, ptr %8, align 4
  %253 = add nsw i32 %252, -1
  store i32 %253, ptr %8, align 4
  br label %239, !llvm.loop !142

254:                                              ; preds = %239
  %255 = load i32, ptr %9, align 4
  %256 = mul nsw i32 2, %255
  store i32 %256, ptr %8, align 4
  %257 = load i32, ptr %10, align 4
  %258 = add nsw i32 %257, 1
  store i32 %258, ptr %10, align 4
  store i32 0, ptr %9, align 4
  br label %214, !llvm.loop !143

259:                                              ; preds = %13, %17, %214
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define internal void @tdefl_huffman_enforce_max_code_size(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %8, align 4
  %9 = load i32, ptr %5, align 4
  %10 = icmp sle i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %3
  br label %101

12:                                               ; preds = %3
  %13 = load i32, ptr %6, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, ptr %7, align 4
  br label %15

15:                                               ; preds = %30, %12
  %16 = load i32, ptr %7, align 4
  %17 = icmp sle i32 %16, 32
  br i1 %17, label %18, label %33

18:                                               ; preds = %15
  %19 = load ptr, ptr %4, align 8
  %20 = load i32, ptr %7, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i32, ptr %19, i64 %21
  %23 = load i32, ptr %22, align 4
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %6, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, ptr %24, i64 %26
  %28 = load i32, ptr %27, align 4
  %29 = add nsw i32 %28, %23
  store i32 %29, ptr %27, align 4
  br label %30

30:                                               ; preds = %18
  %31 = load i32, ptr %7, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %7, align 4
  br label %15, !llvm.loop !144

33:                                               ; preds = %15
  %34 = load i32, ptr %6, align 4
  store i32 %34, ptr %7, align 4
  br label %35

35:                                               ; preds = %50, %33
  %36 = load i32, ptr %7, align 4
  %37 = icmp sgt i32 %36, 0
  br i1 %37, label %38, label %53

38:                                               ; preds = %35
  %39 = load ptr, ptr %4, align 8
  %40 = load i32, ptr %7, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds i32, ptr %39, i64 %41
  %43 = load i32, ptr %42, align 4
  %44 = load i32, ptr %6, align 4
  %45 = load i32, ptr %7, align 4
  %46 = sub nsw i32 %44, %45
  %47 = shl i32 %43, %46
  %48 = load i32, ptr %8, align 4
  %49 = add i32 %48, %47
  store i32 %49, ptr %8, align 4
  br label %50

50:                                               ; preds = %38
  %51 = load i32, ptr %7, align 4
  %52 = add nsw i32 %51, -1
  store i32 %52, ptr %7, align 4
  br label %35, !llvm.loop !145

53:                                               ; preds = %35
  br label %54

54:                                               ; preds = %98, %53
  %55 = load i32, ptr %8, align 4
  %56 = zext i32 %55 to i64
  %57 = load i32, ptr %6, align 4
  %58 = zext i32 %57 to i64
  %59 = shl i64 1, %58
  %60 = icmp ne i64 %56, %59
  br i1 %60, label %61, label %101

61:                                               ; preds = %54
  %62 = load ptr, ptr %4, align 8
  %63 = load i32, ptr %6, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i32, ptr %62, i64 %64
  %66 = load i32, ptr %65, align 4
  %67 = add nsw i32 %66, -1
  store i32 %67, ptr %65, align 4
  %68 = load i32, ptr %6, align 4
  %69 = sub nsw i32 %68, 1
  store i32 %69, ptr %7, align 4
  br label %70

70:                                               ; preds = %95, %61
  %71 = load i32, ptr %7, align 4
  %72 = icmp sgt i32 %71, 0
  br i1 %72, label %73, label %98

73:                                               ; preds = %70
  %74 = load ptr, ptr %4, align 8
  %75 = load i32, ptr %7, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds i32, ptr %74, i64 %76
  %78 = load i32, ptr %77, align 4
  %79 = icmp ne i32 %78, 0
  br i1 %79, label %80, label %94

80:                                               ; preds = %73
  %81 = load ptr, ptr %4, align 8
  %82 = load i32, ptr %7, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i32, ptr %81, i64 %83
  %85 = load i32, ptr %84, align 4
  %86 = add nsw i32 %85, -1
  store i32 %86, ptr %84, align 4
  %87 = load ptr, ptr %4, align 8
  %88 = load i32, ptr %7, align 4
  %89 = add nsw i32 %88, 1
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds i32, ptr %87, i64 %90
  %92 = load i32, ptr %91, align 4
  %93 = add nsw i32 %92, 2
  store i32 %93, ptr %91, align 4
  br label %98

94:                                               ; preds = %73
  br label %95

95:                                               ; preds = %94
  %96 = load i32, ptr %7, align 4
  %97 = add nsw i32 %96, -1
  store i32 %97, ptr %7, align 4
  br label %70, !llvm.loop !146

98:                                               ; preds = %80, %70
  %99 = load i32, ptr %8, align 4
  %100 = add i32 %99, -1
  store i32 %100, ptr %8, align 4
  br label %54, !llvm.loop !147

101:                                              ; preds = %11, %54
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #5 = { allocsize(1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #6 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #7 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #8 = { cold noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #9 = { allocsize(0,1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { allocsize(0) }
attributes #12 = { nounwind }
attributes #13 = { allocsize(1) }
attributes #14 = { cold noreturn }
attributes #15 = { allocsize(0,1) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Homebrew clang version 17.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = distinct !{!16, !6}
!17 = distinct !{!17, !6}
!18 = distinct !{!18, !6}
!19 = distinct !{!19, !6}
!20 = distinct !{!20, !6}
!21 = distinct !{!21, !6}
!22 = distinct !{!22, !6}
!23 = distinct !{!23, !6}
!24 = distinct !{!24, !6}
!25 = distinct !{!25, !6}
!26 = distinct !{!26, !6}
!27 = distinct !{!27, !6}
!28 = distinct !{!28, !6}
!29 = distinct !{!29, !6}
!30 = distinct !{!30, !6}
!31 = distinct !{!31, !6}
!32 = distinct !{!32, !6}
!33 = distinct !{!33, !6}
!34 = distinct !{!34, !6}
!35 = distinct !{!35, !6}
!36 = distinct !{!36, !6}
!37 = distinct !{!37, !6}
!38 = distinct !{!38, !6}
!39 = distinct !{!39, !6}
!40 = distinct !{!40, !6}
!41 = distinct !{!41, !6}
!42 = distinct !{!42, !6}
!43 = distinct !{!43, !6}
!44 = distinct !{!44, !6}
!45 = distinct !{!45, !6}
!46 = distinct !{!46, !6}
!47 = distinct !{!47, !6}
!48 = distinct !{!48, !6}
!49 = distinct !{!49, !6}
!50 = distinct !{!50, !6}
!51 = distinct !{!51, !6}
!52 = distinct !{!52, !6}
!53 = distinct !{!53, !6}
!54 = distinct !{!54, !6}
!55 = distinct !{!55, !6}
!56 = distinct !{!56, !6}
!57 = distinct !{!57, !6}
!58 = distinct !{!58, !6}
!59 = distinct !{!59, !6}
!60 = distinct !{!60, !6}
!61 = distinct !{!61, !6}
!62 = distinct !{!62, !6}
!63 = distinct !{!63, !6}
!64 = distinct !{!64, !6}
!65 = distinct !{!65, !6}
!66 = distinct !{!66, !6}
!67 = distinct !{!67, !6}
!68 = distinct !{!68, !6}
!69 = distinct !{!69, !6}
!70 = distinct !{!70, !6}
!71 = distinct !{!71, !6}
!72 = distinct !{!72, !6}
!73 = distinct !{!73, !6}
!74 = distinct !{!74, !6}
!75 = distinct !{!75, !6}
!76 = distinct !{!76, !6}
!77 = distinct !{!77, !6}
!78 = distinct !{!78, !6}
!79 = distinct !{!79, !6}
!80 = distinct !{!80, !6}
!81 = distinct !{!81, !6}
!82 = distinct !{!82, !6}
!83 = distinct !{!83, !6}
!84 = distinct !{!84, !6}
!85 = distinct !{!85, !6}
!86 = distinct !{!86, !6}
!87 = distinct !{!87, !6}
!88 = distinct !{!88, !6}
!89 = distinct !{!89, !6}
!90 = distinct !{!90, !6}
!91 = distinct !{!91, !6}
!92 = distinct !{!92, !6}
!93 = distinct !{!93, !6}
!94 = distinct !{!94, !6}
!95 = distinct !{!95, !6}
!96 = distinct !{!96, !6}
!97 = distinct !{!97, !6}
!98 = distinct !{!98, !6}
!99 = distinct !{!99, !6}
!100 = distinct !{!100, !6}
!101 = distinct !{!101, !6}
!102 = distinct !{!102, !6}
!103 = distinct !{!103, !6}
!104 = distinct !{!104, !6}
!105 = distinct !{!105, !6}
!106 = distinct !{!106, !6}
!107 = distinct !{!107, !6}
!108 = distinct !{!108, !6}
!109 = distinct !{!109, !6}
!110 = distinct !{!110, !6}
!111 = distinct !{!111, !6}
!112 = distinct !{!112, !6}
!113 = distinct !{!113, !6}
!114 = distinct !{!114, !6}
!115 = distinct !{!115, !6}
!116 = distinct !{!116, !6}
!117 = distinct !{!117, !6}
!118 = distinct !{!118, !6}
!119 = distinct !{!119, !6}
!120 = distinct !{!120, !6}
!121 = distinct !{!121, !6}
!122 = distinct !{!122, !6}
!123 = distinct !{!123, !6}
!124 = distinct !{!124, !6}
!125 = distinct !{!125, !6}
!126 = distinct !{!126, !6}
!127 = distinct !{!127, !6}
!128 = distinct !{!128, !6}
!129 = distinct !{!129, !6}
!130 = distinct !{!130, !6}
!131 = distinct !{!131, !6}
!132 = distinct !{!132, !6}
!133 = distinct !{!133, !6}
!134 = distinct !{!134, !6}
!135 = distinct !{!135, !6}
!136 = distinct !{!136, !6}
!137 = distinct !{!137, !6}
!138 = distinct !{!138, !6}
!139 = distinct !{!139, !6}
!140 = distinct !{!140, !6}
!141 = distinct !{!141, !6}
!142 = distinct !{!142, !6}
!143 = distinct !{!143, !6}
!144 = distinct !{!144, !6}
!145 = distinct !{!145, !6}
!146 = distinct !{!146, !6}
!147 = distinct !{!147, !6}
