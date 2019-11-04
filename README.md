# impala_hls_snippets

To test new HLS features:

source project.sh from anydsl and run tesl_hls .sh or test_ocl scripts providing a test name.

modules should be dumped in thorin code, at the end of hls_channels.cpp

uncomment (world.dump()) and recompile Thorin

``` mkdir build ```

then execute scripts

``` ./test_hls.sh channel```


