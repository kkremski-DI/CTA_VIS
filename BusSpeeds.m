t = csv2struct('loctime2.csv');

stops = shaperead('CTA_BusStops\CTA_BusStops.shp');
stopx = [];
stopy = [];
for i = 1:length(stops)
    if ~isempty(strmatch('66',stops(i,1).ROUTESSTPG))
        stopx(end+1) = stops(i,1).X;
        stopy(end+1) = stops(i,1).Y;
    end
end

[stopx,stopy] = sp_proj('illinois east', 'forward', stopx, stopy,'sf');

        

lat = t.A;
lon = t.B;
times = cellfun(@(x) datenum(x, 'yyyymmdd HH:MM'), t.C);

timedup = ~diff(times);

lat(find(timedup)+1) = [];
lon(find(timedup)+1) = [];
times(find(timedup)+1) = [];

latdup = ~diff(lat);
londup = ~diff(lon);

b = latdup & londup;

lat(find(b)+1) = [];
lon(find(b)+1) = [];
times(find(b)+1) = [];

[x,y] = sp_proj('illinois east', 'forward', lon, lat,'sf');

s = sqrt(diff(x).^2 + diff(y).^2)./diff(times);
scatter(stopx, stopy, 'k', '+');

hold on;

for i = 1:length(x)-1
    c = (s(i)-min(s))/(max(s)-min(s));
    plot(x(i:i+1),y(i:i+1), 'Color', [1-c, c, 0], 'LineWidth', 2);
end
axis([min(x)-1000, max(x)+1000, min(y)-1000, max(y)+1000])

set(gca, 'box', 'on');
set(gca, 'xtick', [], 'ytick', []);
saveas(gcf, 'BusSpeeds.png', 'png');
