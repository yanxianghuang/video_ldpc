%%
snr = 12;
filename = 'sample.avi';
skip_time = 5;


%% setting the channel information
hEnc = comm.LDPCEncoder;
hMod = comm.PSKModulator(4, 'BitInput',true);
hChan = comm.AWGNChannel(...
            'NoiseMethod','Signal to noise ratio (SNR)','SNR',snr);
hDemod = comm.PSKDemodulator(4, 'BitOutput',true,...
            'DecisionMethod','Approximate log-likelihood ratio', ...
            'Variance', 1/10^(hChan.SNR/10));
hDec = comm.LDPCDecoder;


%% setting the reading of the picture

avi_obj=VideoReader(filename);
y = avi_obj.Height; 
x = avi_obj.Width;
c = avi_obj.BitsPerPixel/8; % channels of picture
b = 8; % bit per channel

receivedPic = uint8(zeros(y*x*c*b,1));
restoredPic = uint8(zeros(y*x*c*b,1));


i = 0; %frame count
avi_obj.CurrentTime = skip_time; % start processing from the middle
k = 336; l = 672; % half rate 11ad LDPC
pic_size = floor(y*x*c*b/k); %nb LDPC_frames
while hasFrame(avi_obj)
    i = i+1;
    pic = readFrame(avi_obj);
    
    bit_pic = pic2bit(pic, y, x, c, b); %% in bitwise picture
    
    for block = 1:pic_size,
          %fprintf('%d ',block);
          encodedData    = encoder(1, bit_pic(block*k-k+1:block*k));
          modSignal      = step(hMod, encodedData);
          receivedSignal = step(hChan, modSignal);
          demodSignal    = step(hDemod, receivedSignal);
          receivedBits   = decoder(1, demodSignal);
          
          temp    =  (demodSignal<0); % hard-decison decoding
          receivedPic(block*k-k+1:block*k) = temp(1:k);
          
          restoredPic(block*k-k+1:block*k)    =  receivedBits(1:k); % LDPC decoding
    end;
    
    % convert to Matlab format and plot 
    re_pic = bit2pic(receivedPic, y, x, c, b); % received video    
    de_pic = bit2pic(restoredPic, y, x, c, b); % decoded Pic
    
    figure(1);
    subplot(2,1,1);
    imshow(re_pic),
    title(sprintf('Corrupted recived Frame %d; SNR = %.2f dB',i, hChan.SNR));
    drawnow;
    subplot(2,1,2);
    imshow(de_pic),
    title(sprintf('Decoded Restored Frame %d',i));
    drawnow;
end
