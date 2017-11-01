
%% threshold is 130
idx = y > 130;

x = 1:1000;
x_filted = x(idx);

y_filted = y(idx);

scatter(x_filted, y_filted);


%% ma filter
window_size = 10;
y_filted = tsmovavg(y, 's', window_size, 1);

plot(y);
hold on
plot(y_filted);