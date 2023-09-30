
% Código baseado no artigo C. Londero et al(2017).
% Calcula a densidade de empacotamento.
% Não confundir com densidade de massa.

clc
close all
clear all

beta = 0.441;  % densidade de empacotamento de cada classe de grãos
y = 1 - beta;  % volume complementar de cada classe de grãos

k = [4.1:.1:9];  % índice de compactação

dens_real = 1./(y/beta./k + 1/y)

figure(1)
plot(k,dens_real)