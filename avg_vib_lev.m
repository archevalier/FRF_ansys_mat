clear;clc;close all
ansy = load('nodedis.txt');
[M,N] = size(ansy);
freq_num = M;
node_num = N-1;
node_dis = ansy(:,2:node_num);
%M为频率点数，N为基座连接点数
%%
l_ref = 1e-12; %速度参考值
%%
%l为基座上各测点的位移振级
%L为基座上各测点的对数平均振级
%%
dis_vib_lev = 20*log10(abs(node_dis/l_ref));

tmp = 10.^(dis_vib_lev(1:freq_num,:)/20);
tol_lev(1:freq_num,1) = 20*log10(sum(tmp,2));
avg_lev(1:freq_num,1) = tol_lev - 20*log10(node_num);

plot(1:freq_num,tol_lev(1:freq_num,1));

save origin.mat tol_lev