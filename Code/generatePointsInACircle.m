function coordinates = generatePointsInACircle(n)
     t = 2*pi*rand(n,1);
     r = sqrt(rand(n,1));
     x = r.*cos(t);
     y = r.*sin(t);
     coordinates = [x,y];
end