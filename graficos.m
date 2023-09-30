%
% Plot das novas medidas feitas nas amostras do Artigo 1 após as sugestões
% dos revisores.

close all
clear all
clc

%%

figure(1)
ncam = [5 9 13 17 21 25 29 33 39 45 49 53 61 73]; % Amostras que ainda estavam íntegras

%%        VPZ --> medidas nov/22
%%
vpz_100k  = [1619.62 1689.14 2110.49 2281.44 2556.10 2724.29 2504.85 2382.44 2585.96];
vpz_500k  = [2336.79 2736.61 2774.27 2867.87 3040.89 2594.51 2810.19];
vpz_1000k = [2464.48 3020.77 2846.82 2772.49 2809.15 2540.54 2139.92 2217.36 2494.36 2623.33 2694.57];

ncam_100k = [5 9 13 17 25 29 39 49 61];
ncam_500k = [9 13 17 25 29 49 61];
ncam_1000k = [9 13 17 25 29 39 41 45 49 53 61];


subplot(1,4,1)
title('V_{PZ}')
hold on
plot(vpz_100k,ncam_100k,'o-b','LineWidth',2);
plot(vpz_500k,ncam_500k,'o-g','LineWidth',2);
plot(vpz_1000k,ncam_1000k,'o-r','LineWidth',2);
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
xlim([2000 4000])
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('100 kHz','500 kHz','1 MHz')
box on
grid on

%%        VPX  --> medidas nov/22
%%
ncam_100k = [9 13 17 21 25 29 39 53 61 73];
vpx_100k  = [2934.48 2945.24 3052.13 3055.35 3076.18 3226.30 3567.85 3429.42 3358.65 3434.82];
vpx_500k  = [3115.71 3178.74 3293.58 3370.87 3379.48 3529.41 3835.50 3749.19 3665.74 3712.41];
vpx_1000k = [3325.79 3352.72 3384.88 3451.02 3477.30 3635.40 3995.33 3910.25 3866.47 3980.16];

subplot(1,4,2)
title('V_{PX}')
hold on
plot(vpx_100k,ncam_100k,'o-b','LineWidth',2);
plot(vpx_500k,ncam_100k,'o-g','LineWidth',2);
plot(vpx_1000k,ncam_100k,'o-r','LineWidth',2);
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
xlim([2000 4000])
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('100 kHz','500 kHz','1 MHz')
box on
grid on

%%        VSH  --> Medidas nov/22
%%
ncam_100k = [9 13 17 21 25 29 33 39 53 61 73];
ncam_500k = [9 13 17 21 25 39 53 61 73];
vsh_500k  = [1944.07 1820.26 1985.71 1891.56 2186.72 2167.80 2252.37 2592.18 2202.87 2197.36 2122.62];
vsh_1000k = [1927.97 1963.28 2027.40 2036.48 2124.47 2308.96 2307.27 2291.49 2288.21];

subplot(1,4,3)
title('V_{SH}')
hold on
plot(vsh_500k,ncam_100k,'o-g','LineWidth',2);
plot(vsh_1000k,ncam_500k,'o-r','LineWidth',2);
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('500 kHz','1 MHz')
box on
grid on

%%        VSV = VSZ  ---> Medidas nov/22
%%
ncam_100k = [9 13 17 21 25 29 33 39 53 61 73];
ncam_500k = [9 13 17 21 25 39 53 61 73];
vsv_500k  = [1436.15 1679.23 1708.48 1766.61 1789.65 1814.12 1872.24 2024.50 1942.21 1854.48 1877.42];
vsv_1000k = [1597.83 1686.29 1638.84 1636.81 1691.71 1928.47 1952.64 1952.85 1906.04];
%
ncam_1000k = [9 13 17 25 29 49 61];
ncam4 = [9 13 17 25 29 33 41 45 49 61];
vsz_500k  = [1389.12 1747.69 1757.11 1801.57 2088.18 1621.94 1825.24];
vsz_1000k = [1801.60 1734.86 1878.39 1708.43 1881.49 1693.41 1580.98 1275.96 1727.56 1748.75];

subplot(1,4,4)
title('V_{SV}=V_{SZ}')
hold on
plot(vsv_500k,ncam_100k,'o-g','LineWidth',2);
plot(vsz_500k,ncam_1000k,'--g','LineWidth',2);
plot(vsv_1000k,ncam_500k,'o-r','LineWidth',2);
plot(vsz_1000k,ncam4,'--r','LineWidth',2);
ylabel('Number of Layers')
xlabel('Velocity [m/s]')
xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam)
set(gca,'FontSize',15)
legend('500 kHz','1 MHz')
box on
grid on


%% Densidade
mug = 9.80665*1200;
pressure = (mug*[5:5:100]/100)/1000;
pontos = [1:2:20];
pontos_pressure = [pressure(pontos)];
dens = [ 3451.37 3360.84 3343.86 3422.88 3475.40 3414.98 3430.89 3405.66 3424.55 3440.43...
         3417.87 3444.44 3495.65 3398.59 3520.45 3508.70 3543.03 3706.15 3969.75 4056.16 ];
interp_dens = interp(dens,4);
[bet,betp] = fit(pressure',dens','poly6')

figure(2)
title('Densidade vs pressão')
hold on
% plot(dens,plugs,'+-k','LineWidth',2);
% plot(interp_dens,'+-b','LineWidth',2);
plot(bet,pressure,dens);
ylabel('Velocity [m/s]')
xlabel('Aumento de pressão [kPa]')
%xlim([1250 2750])
%set(gca,'YDir','Reverse')
set(gca,'XTick',pontos_pressure)
set(gca,'FontSize',15)
%legend('500 kHz','1 MHz')
box on
grid on


%% Medidas amostra 73 a medida que faz-se o desplacamento


ncam_100k = [5 9 11 15 19 23 27 31 35 39 43 47 51 55 59 63 71];
vp73_100k  = [2075.00 2165.34 2510.26 2636.00 2692.95 2583.16 2377.65 2330.09 2234.21 2210.81 2160.56 2117.03 1986.77 1958.81 1482.93 1221.55 1308.60];
vp73_500k  = [3788.38 3510.31 3330.74 3079.44 2996.31 2848.05 2702.22 2686.76 2566.25 2524.99 2384.21 2306.46 2277.83 2030.28 2119.59 1553.02 1952.96];
vp73_1000k = [4780.10 3982.46 4258.71 3686.71 3441.15 3440.33 3246.38 3185.70 3125.15 3145.64 2950.44 2910.26 2867.51 2400.94 2406.86 1977.32 3088.14];


figure(3)
title('V_{pz} - Sample 73')
hold on
plot(vp73_100k,ncam_100k,'o-b','LineWidth',2);
plot(vp73_500k,ncam_100k,'o-g','LineWidth',2);
plot(vp73_1000k,ncam_100k,'o-r','LineWidth',2);
xlabel('Velocity [m/s]')
ylabel('Number of Layers')
%xlim([1250 2750])
set(gca,'YDir','Reverse')
set(gca,'YTick',ncam_100k)
set(gca,'FontSize',15)
legend('100 kHz','500 kHz','1 MHz')
box on
grid on
