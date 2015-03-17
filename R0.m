function result = R0(phi)

num = besseli(1,phi,1);
denom = besseli(0,phi,1);
result = num./denom;

if phi==0
    result = 1;
end

end