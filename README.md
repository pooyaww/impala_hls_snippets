# impala_hls_snippets

To test new HLS features



source project.sh from anydsl and run desired test scripts providing a test name, without `.impala`

`artic` directory in `hls` contains tests for supporting the new frontend.

Environment variables:
`ANYDSL_FPGA` can be set to `SOC`, `HPC`, `HPC_STREAM`, `GMEM_OPT` to generate SoC streaming IPs, HPC kernel interface, HPC streaming IP and enabling memory optimizations respectively. GMEM_OPT can be combined with any other values.

modules should be dumped in thorin code, at the end of hls_channels.cpp

uncomment (world.dump()) and recompile Thorin

``` mkdir build ```

then execute scripts with desired flag: `d` device code, `h` host code,`d h` device and host codes,` d h c`device, host and impala codes

``` ./test_hls.sh channel d h c```


```./test_ocl.sh channel d h ```


