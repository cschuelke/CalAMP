# Cal-AMP
This is a MATLAB implementation of the Cal-AMP solver.

## Use
demo.m is the main file 
### General parameters
* N is the signal size
* rho is the signal sparsity
* signal_type selects either real or complex signals
* signal_mean and signal_var are the mean and variance of the gaussian part of the signal
* alpha is the measurement rate
* matrix_type selects either real or complex measurement matrices
* Delta is the variance of the AWGN

### Calibration parameters
 P is the number of independent signals used to perform the blind calibration
cal_type chooses between the options :
#### 'none'
Cal-AMP will do normal compressed sensing
#### 'gain'
Cal-AMP will do blind gain calibration. The distribution of the gain coefficients can be selected from preimplemented distributions: 
* 'uniform' : parameters are the center of the distribution d_unif_mean and the window size wd.
* 'complexGauss' : parameters are d_complex_mean and d_complex_var.

For reconstruction, 3 sets of update functions are implemented:
* 'uniform' are the Bayes-optimal update functions when the calibration coefficients are sampled from the uniform distribution. They work for real calibration coefficients only.
* 'mis' are update functions that are not Bayes-optimal but much more robust, and can also be used for other distributions. They work for real calibration coefficients only.
* 'complex' are update functions that give good results for complex calibration coefficients.

#### 'faultySensors' 
Cal-AMP will do signal reconstruction with faulty sensors.
Parameters are
* epsilon, the fraction of faulty sensors
* faulty_mean and faulty_var, the mean and variance of the gaussian noise recorded by the faulty sensors

### Algorithm parameters
* iter_max is the maximal number of iterations
* display of the current state of the reconstruction can be turned on and off by setting the parameters txt_display and plot_display to 1 or 0.
* damping should be smaller or equal to 1 (no damping). Empirically, 0.8 is a good value.

## Performance
At each iteration, the file 'calculate_indicators' calculates the MSE and normalized cross-correlation between the input signal and the reconstruction.

Please send any comments to christophe.schulke@espci.fr
