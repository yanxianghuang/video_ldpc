# Intro
For many days, I was wandering the physical meaning of BER (bit-error rate) and SNR (signal to noise ratio), which are heavily used by designers in communication domain. Besides, the effectness of ECC (error correction code) was far from illustrative.

Therefore I built this task (in Matlab and C) to monitor the physical meaning of SNR, BER, ECC (LDPC), illustrated in the context of (Image) video transmission.


# System discription
The Matlab GUI simulates video transmission via a gaussian noise (AWG) channel. The modulation sheme is QPSK. For error correction, a LDPC decoder is utilized.

To speedup the simulation, the model uses a custumized LDPC encoder/decoder, rather than the built in one form communication_toolbox. This brings ~100 speedup. The LDPC encoder/decoder is compatible to IEEE 802.11ad starndrd, by default it is in 1/2 coding rate, you can hack it to use 5/8, 3/4, or 13/16 coding rate. The block size of the code is fixed to be 672 bits. It takes logrithmetic input from the mapper. The LDPC decoder is implemented in fixed-point to represent industrial chip behavior. The bitwidth is between 4-10. Currently we only provide mex code to be used in Matlab. The original c code, as well as the exact bitwidth, are still confidential. We hope to open-source to the public soon.

User can choose input video_file, as well as the SNR to simulate. A sample result might be found in /result/ldpcsnr3.jpg.
![Example simulation result](/result/ldpcsnr3.jpg)






# User's guide

## system requirements
* 64-bit operating system of ethier Windows, Unix, or MAC OSX
* 64-bit Matlab, with licnese of:
  * basic Matlab license
  * communication_toolbox
  * signal_toolbox

## Usage guide
### Download this git page
Otherwise, you can simply fork this page by:
```bash
git clone https://github.com/yanxianghuang/video_ldpc
```
### Run the script from Matlab:
Open Matlab, entering the src folder, start the program by typing
```Matlab
show_pic_ber
```
in your Matlab commandline. A figure template should appear.

Adjust the parameters in the right-top corner __Panel__:
* select file for testcase, you can choose the one in '../testcase/sample.avi';
* choose the SNR value in dB for simulation, preferably chose 3;
* for 'start from' item item, you may choose 0, meaning we start from the first frame (the 0 second).
* tick the Updating new frames, if you want the simulation process to update new frames automatically (streaming).
* click Simulate, you are ready to see the effect, of the original frame(s), corrupted by the signal frame(s), and the decoded form error correction code frame(s).
*  To stop, untick the 'updating new frame', it will stop when finishs current frame. To start a new simulation, click Simulate button.

Be patient as the simulation may take long. This is mainly due to the time-consuming demapper function from communication_toolbox. I hope one day I'll find the time to convert it to Python, or reuse my own demapping, for speed-up.
Enjoy, and if you have and suggestions, please shot.








# hacker's guide

You can modify the program as you like. For instance, you can change the modulation scheme, channel noise model, LDPC schemes (or even substitute it with one you have).

## File structure

* src
  * show_pic_ber.m (the main function)
  * show_pic_ber.fig (the GUI interface, it will be open once show_pic_ber.m is used)
  * load_video.m (loading video function/script)
  * pic2bit.m (function: convert picture/frame into an array of bits)
  * bit2pic.m (function: reverse of pic2bit)
  * encoder.(mexw64/mexa64/mexmaci64) (LDPC encoder binary files in Windows, Unix, MAC OSX)
  * decoder.(mexw64/mexa64/mexmaci64) (LDPC decoder binary files)
* testcase
  * test.avi (testing video)
* result
  * ldpcsnr3.jpg (example screenshot)

## show_pic_ber.m
The main file contains the _gui_load_video_ function, which is the main processing block, It is executed everytime the __start-Butten__ was hit.

It first get the data from a frame, pack it into a encoder blocks. On each blok, encode, modulation, mapping (demodulation), and decoding. Once all blocks of a frame is done, paint the result on GUI. And if __updating_new_frames__ option is selected, it will continue to the next frame. Otherwise, the program will stop.
