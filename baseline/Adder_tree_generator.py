import numpy as np
import random

def do_col_addition(_col):
	global nbit_tot, fa_tot, ha_tot, ndata, stage, f

	next_col = np.zeros([nbit_tot], dtype=int)
	_counter = np.zeros([nbit_tot], dtype=int)
	
	_len = _col.size
	fa, ha = 0, 0

	# instantiate # of FAs and HAs
	for i in range(0, _len-1):
		_col_cnt = _col[i]
		_col_used = 0
		if _col[i] >= 2:
			while _col_cnt > 2: # FA
				f.write ('FA FA_'+str(stage)+'_'+str(fa)+' ( '+
					'.a(stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used)+']), '+
					'.b(stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used+1)+']), '+
					'.cin(stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used+2)+']), '+
					'.cout(stage_'+str(stage)+'['+str(i+1)+']['+str(next_col[i+1])+']), '+
					'.s(stage_'+str(stage)+'['+str(i)+']['+str(next_col[i])+']) );\n')
				_col_used += 3
				_col_cnt -= 3
				next_col[i+1] += 1
				next_col[i] += 1
				fa += 1
			if _col_cnt == 2: # HA
				f.write ('HA HA_'+str(stage)+'_'+str(ha)+' ( '+
					'.a(stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used)+']), '+
					'.b(stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used+1)+']), '+
					'.cout(stage_'+str(stage)+'['+str(i+1)+']['+str(next_col[i+1])+']), '+
					'.s(stage_'+str(stage)+'['+str(i)+']['+str(next_col[i])+']) );\n')
				_col_used += 2
				_col_cnt -= 2
				next_col[i+1] += 1
				next_col[i] += 1
				ha += 1

		while _col_cnt > 0:
			f.write ('assign stage_'+str(stage)+'['+str(i)+']['+str(next_col[i])+'] = '+
				     'stage_'+str(stage-1)+'['+str(i)+']['+str(_col_used)+'];\n')
			_col_used += 1
			_col_cnt -= 1
			next_col[i] += 1

	print(next_col)
	print('#FA / #HA = ' + str(fa) + ' / ' + str(ha) + '\n')
	fa_tot += fa
	ha_tot += ha
	return next_col

def wallace(_col):
    global stage, fa_tot, ha_tot, nbit_tot, f
    
    while(True):
        stage += 1
        print('Stage = ' + str(stage))
        print(str(_col))
    
        _max = np.max(_col)
        if _max > 2:
            # declaration of wires each of stages
            f.write('\nwire stage_'+str(stage)+' [`NBIT+'+str(stage)+':0]'+'[`NDATA*2:0];\n')
            _col = do_col_addition(_col)

        # final stage, part of RCA
        else:
            _len = nbit_tot
            _rca_cnt = 0
            _fa_cnt = nbit_tot
            _pos_col = np.zeros([nbit_tot], dtype=int)
            
            # _pos_col is 1 means, that position is 1 dot which will be assigned
            #for i in range(_len):
            #    if _col[i] == 1:
            #        _pos_col[i] = 1
            #        _rca_cnt += 1


            f.write('\nwire ['+str(_len-2)+':0] rca_co;\n')

            for i in range(_len):
                if i == _len-1: # MSB
                    if _col[i] == 1:
                        f.write('FA FA_final_'+str(i)+'( '+
                                '.a(stage_'+str(stage-1)+'['+str(i)+'][0]), '+
                                ".b(1'b0), "+
                                '.cin(rca_co['+str(i-1)+']), '
                                '.cout(o_result['+str(_len)+']), '+
                                '.s(o_result['+str(i)+']) );\n\n')
                                #'assign o_result['+str(_len)+'] = rca_co['+str(_len-1)+'];\n\n')
                        f.write('endmodule')
                        break;
                    else:
                        f.write('FA FA_final_'+str(i)+'( '+
                                '.a(stage_'+str(stage-1)+'['+str(i)+'][0]), '+
                                '.b(stage_'+str(stage-1)+'['+str(i)+'][1]), '+
                                '.cin(rca_co['+str(i-1)+']), '
                                '.cout(o_result['+str(_len)+']), '+
                                '.s(o_result['+str(i)+']) );\n\n')
                                #'assign o_result['+str(_len)+'] = rca_co['+str(_len-1)+']\n\n')
                        f.write('endmodule')
                if i == 0: # LSB
                    if _col[0] == 1: # just assign
                        f.write('assign o_result[0] = stage_'+str(stage-1)+'[0][0];\n')
                        f.write("assign rca_co[0] = 1'b0;\n")
                    else: # HA
                        f.write('HA HA_final_'+str(i)+'( '+
                                '.a(stage_'+str(stage-1)+'[0][0]), '+
                                '.b(stage_'+str(stage-1)+'[0][1]), '+
                                '.cout(rca_co[0]), '+
                                '.s(o_result[0]) );\n')
                if i > 0: # middle position between MSB and LSB
                    if _col[i] == 1:
                        f.write('FA FA_final_'+str(i)+'( '+
                                '.a(stage_'+str(stage-1)+'['+str(i)+'][0]), '+
                                ".b(1'b0), "+
                                '.cin(rca_co['+str(i-1)+']), '+
                                '.cout(rca_co['+str(i)+']), '+
                                '.s(o_result['+str(i)+']) );\n')
                    else:
                        f.write('FA FA_final_'+str(i)+'( '+
                                '.a(stage_'+str(stage-1)+'['+str(i)+'][0]), '+
                                '.b(stage_'+str(stage-1)+'['+str(i)+'][1]), '+
                                '.cin(rca_co['+str(i-1)+']), '+
                                '.cout(rca_co['+str(i)+']), '+
                                '.s(o_result['+str(i)+']) );\n')

            fa_tot  += _len - 1
            print('Do carray propagation')
            print('#FA_tot / #FA_tot = ' + str(fa_tot) + ' / ' + str(ha_tot) + '\n')
            break;
    
def wallace_init(_nbit, _ndata, mode='base'):
    global nbit, nbit_msb, nbit_tot, f

    nbit = _nbit
    ndata = _ndata
    _ndata_prop = ndata * 2
    nbit_msb = int(np.floor(np.log2(ndata)))
    
    nbit_tot = nbit_msb + nbit
    
    _col = np.zeros([nbit_tot], dtype=int)

    # base mode
    for i in range(1, nbit):
        _col[i] = ndata
    if mode == 'base':
        _col[0] = ndata
        print("baseline Adder_tree")
    elif mode == 'prop':
        print("proposed Adder_tree")
        _col[0] = ndata * 2
    else:
        print('Invalid mode');
        exit(1)

    global ha_tot, fa_tot
    ha_tot, fa_tot = 0, 0
    
    global stage
    stage = 0

    f = open('core/Adder_tree.v', 'w')
    
    f.write('`include "Parameter.v"\n')
    
    f.write('module Adder_tree \n')
    f.write('(\n')
    f.write('   input   [`NBIT*`NDATA-1:0]    i_data,\n')

    if (mode == 'prop'):
        f.write('   input   [`NDATA-1:0]        i_sign,\n')

    f.write('   output  [`NRESULT:0]          o_result\n')
    f.write(');\n\n')

    # declaration wire stage_0 and
    # assign i_data to stage_0 
    # pass # of sign to stage_0
    f.write('wire stage_0 [`NBIT-1:0][`NDATA*2:0];\n')
    f.write('genvar i, j;\n')
    f.write('\n')
    f.write('generate\n')
    f.write('for (i=0; i<`NDATA; i=i+1) begin: i_loop_i_data\n')
    f.write('    for (j=0; j<`NBIT; j=j+1) begin: j_loop_i_data\n')
    f.write('       assign stage_0[j][i] = i_data[j+i*`NBIT];\n')
    f.write('    end;\n')
    f.write('end\n')
    f.write('endgenerate\n\n')

    if (mode == 'prop'):
        f.write('generate\n')
        f.write('for (i=`NDATA; i<`NDATA*2; i=i+1) begin: i_loop_i_sign\n')
        f.write('    assign stage_0[0][i] = i_sign[i-`NDATA];\n')
        f.write('end\n')
        f.write('endgenerate\n')

    f.write('\n')

    wallace(_col)
    
    return ha_tot, fa_tot


ha_base, fa_base = wallace_init(_nbit=16, _ndata=64, mode='base')
