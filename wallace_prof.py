# Professor version of Python script

import numpy as np

def do_column_addition(_col, debug=True):
  global nbit_tot, fa_tot, ha_tot
  next_col = np.zeros([nbit_tot], dtype=int)

  # print(_col)
  # len(_col)
  # _len = len(_col)
  _len = _col.size # column length is 7
  fa, ha = 0, 0
  # for i in range(_len):
  for i in range(_len-1):
    if _col[i] > 2:
      _fa = int(np.floor(_col[i] / 3))
      _rm = np.remainder(_col[i], 3)
      _ha = int(np.floor(_rm / 2))
      _rm = np.remainder(_rm, 2)
      fa += _fa
      ha += _ha
      next_col[i+1] += _fa + _ha
      next_col[i] += _fa + _ha + _rm
    else:
      next_col[i] += _col[i]
  
  if debug:
    print(next_col)
    print('#fa / #ha = ' + str(fa) + ' / ' + str(ha) + '\n')
  fa_tot += fa
  ha_tot += ha
  # _col = next_col
  # print(_col)
  return next_col

def wallace(_col, debug=True):
  global stage, fa_tot, ha_tot, nbit_tot
  while(True):
    stage += 1
    if debug:
      print('Stage = ' + str(stage))
      print(str(_col))
    _max = np.max(_col)
    if _max > 2:
      _col = do_column_addition(_col, debug)
    else: # FA for RCA that need FA as mount of nbit_tot
      fa_tot += nbit_tot
      if debug:
        print('Do carry propagation')
        print('#fa_tot / #ha_tot = ' + str(fa_tot) + ' / ' + str(ha_tot) + '\n')
      break

def wallace_init(_nbit, _ndata, mode='base', debug=True):
  global nbit, nbit_msb, nbit_tot
  nbit = _nbit # 4
  ndata = _ndata # 6
  nbit_msb = int(np.ceil(np.log2(ndata))) # 3

  nbit_tot = nbit + nbit_msb
  if debug:
    print('nbit_tot = '+ str(nbit_tot))

  global ha_tot, fa_tot
  ha_tot, fa_tot = 0, 0

  _col = np.zeros([nbit_tot], dtype=int)
  for i in range(1,nbit):
    _col[i] = ndata
  if mode == 'base':
    _col[0] = ndata 
  elif mode == 'prop':
    _col[0] = ndata * 2
  else:
    print('invalid mode')
    exit(1)

  global stage
  stage = 0

  wallace(_col, debug)

  return ha_tot, fa_tot
  # ----------------------------------------------
ha_base, fa_base = wallace_init(_nbit=4, _ndata=4, mode='base')
