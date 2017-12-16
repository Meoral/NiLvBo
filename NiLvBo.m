% ��ȡͼƬ����ʾ
im = imread('satellite_degraded.tiff');
figure;
imshow(im);
%ͼ����500*500�ģ������ߴ���Ҫ�ı����µ�����500
%�����˻���������˹�������Ƹ�˹��exp�еĵ�һ���ǲ���
H = zeros(500,500);
for i= 1:500
    for j = 1:500
%         H(i,j) = exp(-1/(2*sigma^2)*((i-250)^2+(j-250)^2));
%           H(i,j) = exp(-0.005*((i-250)^2+(j-250)^2)^(5/6));
          H(i,j) = exp(-0.0025*((i-250)^2+(j-250)^2));
    end
end
%��ԭʼ�źŹ�һ������Ҷ�任��ͨ��fftshift�ع�������Ƶ�������ģ���Ƶ�����ĸ���
signal_1 = im;
signal_1 = im2double(signal_1);
F_signal_1 = fft2(signal_1);
F_last_signal = fftshift(F_signal_1);
%ѡ�����˲��ķ�Χ������threshold��ֵ��������������Թ�����˻�����
threshold = 50;
for i= 1:500
    for j = 1:500
        if (sqrt((i-250).^2+(j-250).^2)<threshold)
            F_last_signal(i,j) = F_last_signal(i,j)./(H(i,j)+eps);
        end
    end
end
%���任
F_last_signal = ifftshift(F_last_signal);
last_signal = ifft2(F_last_signal);
last_signal = abs(last_signal);
m = max(max(last_signal));
%��һ���Ժ��ٻ�ԭ��ɫ��ֵ
last_signal = last_signal/m;
last_figure = uint16(last_signal*65535);
figure;
imshow(last_figure);