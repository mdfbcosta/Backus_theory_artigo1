camadas = [1:73];
y_cam = [1:4:73];

time_const(1) = 15;

for i = 2:numel(camadas) 
    time_const(i) = time_const(i-1) + 15;
end

time_const = time_const/60;

plot(camadas,time_const,'*')
title('Sample construction time')
xlabel('Samples')
ylabel('Time [horas]')
%set(gca,'YDir','Reverse')
%set(gca,'YTick',y_cam)
set(gca,'XTick',y_cam)
set(gca,'FontSize',18)
%legend('V_{SZ}')
grid on; box on