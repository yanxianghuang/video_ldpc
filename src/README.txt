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