/// Copyright by Syntacore LLC © 2016-2021. See LICENSE for details
/// @file       <scr1_top_tb_runtests.sv>
/// @brief      SCR1 testbench run tests
///

//-------------------------------------------------------------------------------
// Run tests
//-------------------------------------------------------------------------------

initial begin
    $value$plusargs("imem_pattern=%h", imem_req_ack_stall);
    $value$plusargs("dmem_pattern=%h", dmem_req_ack_stall);

`ifdef SIGNATURE_OUT
    $value$plusargs("test_name=%s", s_testname);
    b_single_run_flag = 1;
`else // SIGNATURE_OUT

    $value$plusargs("test_info=%s", s_info);
    $value$plusargs("test_results=%s", s_results);

    f_info      = $fopen(s_info, "r");
    f_results   = $fopen(s_results, "a");
`endif // SIGNATURE_OUT

    fuse_mhartid = 0;

end

always_ff @(posedge clk) begin
    bit           test_pass;
    bit           test_error;
    int unsigned  f_test;
    watchdogs_cnt <= watchdogs_cnt + 'b1;
    if (test_running) begin
        test_pass = 1;
        rst_init <= 1'b0;
        if ((i_top.i_core_top.i_pipe_top.curr_pc == SCR1_SIM_EXIT_ADDR) & ~rst_init & &rst_cnt) begin
            `ifdef VERILATOR
                logic [255:0] full_filename;
                full_filename = test_file;
            `else // VERILATOR
                string full_filename;
                full_filename = test_file;
            `endif // VERILATOR

            if (identify_test(test_file)) begin

                logic [31:0] tmpv, start, stop, ref_data, test_data, start_addr, trap_addr;
                integer fd;
                logic [31:0] code;
                `ifdef VERILATOR
                logic [2047:0] tmpstr;
                `else // VERILATOR
                string tmpstr;
                `endif // VERILATOR

                test_running <= 1'b0;
                test_pass    = 1;
                test_error   = 0;

                $sformat(tmpstr, "riscv64-unknown-elf-readelf -s %s | grep 'begin_signature\\|end_signature\\| _start\\|trap_vector' | awk '{print $2}' > elfinfo", get_filename(test_file));
                fd = $fopen("script.sh", "w");
                if (fd == 0) begin
                    $write("Can't open script.sh\n");
                    test_error = 1;
                end
                $fwrite(fd, "%s", tmpstr);
                $fclose(fd);

                $system("sh script.sh");

                fd = $fopen("elfinfo", "r");
                if (fd == 0) begin
                    $write("Can't open elfinfo\n");
                    test_error = 1;
                end
                if ($fscanf(fd,"%h\n%h\n%h\n%h", trap_addr, start, stop, start_addr) != 4) begin
                    $write("Wrong elfinfo data\n");
                    test_error = 1;
                end
                if ((trap_addr != ADDR_TRAP_VECTOR & trap_addr != ADDR_TRAP_DEFAULT) | start_addr != ADDR_START) begin
                    $write("\nError trap_vector %h or/and _start %h are incorrectly aligned and are not at their address\n", trap_addr, start_addr);
                    test_error = 1;
                end
                if (start > stop) begin
                    tmpv = start;
                    start = stop;
                    stop = tmpv;
                end
                $fclose(fd);

                `ifdef SIGNATURE_OUT

                    $sformat(tmpstr, "%s.signature.output", s_testname);
`ifdef VERILATOR
                    tmpstr = remove_trailing_whitespaces(tmpstr);
`endif
                    fd = $fopen(tmpstr, "w");
                    while ((start != stop)) begin
                        test_data = {i_memory_tb.memory[start+3], i_memory_tb.memory[start+2], i_memory_tb.memory[start+1], i_memory_tb.memory[start]};
                        $fwrite(fd, "%x", test_data);
                        $fwrite(fd, "%s", "\n");
                        start += 4;
                    end
                    $fclose(fd);
                `else //SIGNATURE_OUT
                    if (identify_test(test_file) == COMPLIANCE) begin
                        $sformat(tmpstr, "riscv_compliance/ref_data/%s", get_ref_filename(test_file));
                    end else if (identify_test(test_file) == ARCH) begin
                        $sformat(tmpstr, "riscv_arch/ref_data/%s", get_ref_filename(test_file));
                    end
`ifdef VERILATOR
                    tmpstr = remove_trailing_whitespaces(tmpstr);
`endif
                    fd = $fopen(tmpstr,"r");
                    if (fd == 0) begin
                        $write("Can't open reference_data file: %s\n", tmpstr);
                        test_error = 1;
                    end
                    while (!$feof(fd) && (start != stop)) begin
                        if (($fscanf(fd, "%h", ref_data)=='h1)) begin
                            test_data = {i_memory_tb.memory[start+3], i_memory_tb.memory[start+2], i_memory_tb.memory[start+1], i_memory_tb.memory[start]};
                            test_pass &= (ref_data == test_data);
                            start += 4;
                        end else begin
                            $write("Wrong $fscanf\n");
                            test_pass = 0;
                        end
                    end
                    $fclose(fd);
                    tests_total += 1;
                    tests_passed += (test_pass & !test_error);
                    watchdogs_cnt <= '0;
                    if ((test_pass & !test_error)) begin
                        $write("\033[0;32mTest passed\033[0m\n");
                    end else begin
                        $write("\033[0;31mTest failed\033[0m\n");
                    end
                `endif  // SIGNATURE_OUT
            end else begin
                test_running <= 1'b0;
                test_pass = (i_top.i_core_top.i_pipe_top.i_pipe_mprf.mprf_int[10] == 0);
                tests_total     += 1;
                tests_passed    += (test_pass & !test_error);
                watchdogs_cnt    <= '0;
                `ifndef SIGNATURE_OUT
                    if ((test_pass & !test_error)) begin
                        $write("\033[0;32mTest passed\033[0m\n");
                    end else begin
                        $write("\033[0;31mTest failed\033[0m\n");
                    end
                `endif //SIGNATURE_OUT
            end
            $fwrite(f_results, "%s\t\t%s\t%s\n", test_file, "OK" , ((test_pass & !test_error) ? "PASS" : "__FAIL"));
        end
    end else begin
`ifdef SIGNATURE_OUT
        if ((s_testname.len() != 0) && (b_single_run_flag)) begin
            $sformat(test_file, "%s.bin", s_testname);
`else // SIGNATURE_OUT
        if (f_info) begin
`ifdef VERILATOR
        if ($fgets(test_file,f_info)) begin
            test_file = test_file >> 8; // < Removing trailing LF symbol ('\n')
`else // VERILATOR
        if (!$feof(f_info)) begin
            void'($fscanf(f_info, "%s\n", test_file));
`endif // VERILATOR
`endif // SIGNATURE_OUT
            f_test = $fopen(test_file,"r");
            if (f_test != 0) begin
            // Launch new test
                `ifdef SCR1_TRACE_LOG_EN
                    i_top.i_core_top.i_pipe_top.i_tracelog.test_name = test_file;
                `endif // SCR1_TRACE_LOG_EN
                i_memory_tb.test_file = test_file;
                i_memory_tb.test_file_init = 1'b1;
                `ifndef SIGNATURE_OUT
                    $write("\033[0;34m---Test: %s\033[0m\n", test_file);
                `endif //SIGNATURE_OUT
                test_running <= 1'b1;
                rst_init <= 1'b1;
                `ifdef SIGNATURE_OUT
                    b_single_run_flag = 0;
                `endif
            end else begin
                $fwrite(f_results, "%s\t\t%s\t%s\n", test_file, "__FAIL", "--------");
            end
        end else begin
            // Exit
            `ifndef SIGNATURE_OUT
                $display("\n#--------------------------------------");
                $display("# Summary: %0d/%0d tests passed", tests_passed, tests_total);
                $display("#--------------------------------------\n");
                $fclose(f_info);
                $fclose(f_results);
            `endif
            $finish();
        end
`ifndef SIGNATURE_OUT
        end else begin
            $write("\033[0;31mError: could not open file %s\033[0m\n", s_info);
            $finish();
        end
`endif // SIGNATURE_OUT
    end
    if (watchdogs_cnt == TIMEOUT) begin
        if (test_file == "watchdog.hex") begin
            tests_total  += 'b1;
            tests_passed += 'b1;
            $fwrite(f_results, "%s\t\t%s\t%s\n", test_file, "OK" , "PASS");
            test_running  <= '0;
            watchdogs_cnt <= '0;
        end else begin
            tests_total  += 'b1;
            tests_passed += 'b0;
            $write("\033[0;31mError: TIMEOUT  %s\033[0m\n", test_file);
            $fwrite(f_results, "%s\t\t%s\t%s\n", test_file, "OK" , "__FAIL");
            test_running  <= '0;
            watchdogs_cnt <= '0;
        end
    end
end
