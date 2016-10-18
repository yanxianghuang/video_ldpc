function [ video ] = bit2pic( input_args, y, x, c, b )
% convert bit-wise stream into a video frame (a picture)
% y = number of rows
% x = number of coloumns
% c = number of channels (usually 3)
% b = number of bit per sample (for uint8, it is 8)

    reshape_video = reshape(input_args, [y*x*c, b]);
    unit8_video = uint8(bi2de(reshape_video));
    video = reshape(unit8_video, [y,x,c]);


end

