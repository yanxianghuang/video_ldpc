function [ array ] = pic2bit( input_args, y, x, c, b )
% convert a video frame (a picture) into bit-wise stream 
% y = number of rows
% x = number of coloumns
% c = number of channels (usually 3)
% b = number of bit per sample (for uint8, it is 8)

array = reshape( int32(de2bi(input_args, b)), [y*x*c*b, 1]);
    
 
end

