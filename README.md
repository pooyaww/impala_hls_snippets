# impala_hls_snippets

To test new HLS features:

source project.sh from anydsl and run desired test scripts providing a test name, without `.impala`

Environment variables:
`ANYDSL_FPGA` can be set to `SOC`, `HPC`, `HPC_STREAM`, `GMEM_OPT` to generate SoC streaming IPs, HPC kernel interface, HPC streaming IP and enabling memory optimizations respectively. GMEM_OPT can be combined with any other values.

modules should be dumped in thorin code, at the end of hls_channels.cpp

uncomment (world.dump()) and recompile Thorin

``` mkdir build ```

then execute scripts

``` ./test_hls.sh channel```


