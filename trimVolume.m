function [ trimmedVol ] = trimVolume( Vol )
%trimVolume Removes all zero planes in the volume.

flatZeroPlane = zeros(size(Vol, 1), size(Vol, 2));
uprightZeroPlane = zeros(size(Vol, 3), size(Vol, 2));
sideZeroPlane = zeros(size(Vol, 3), size(Vol, 1));

firstNonZeroX = 1;
lastNonZeroX = size(Vol, 2);
firstNonZeroY = 1;
lastNonZeroY = size(Vol, 1);
firstNonZeroZ = 1;
lastNonZeroZ = size(Vol, 3);
for x = 1:size(Vol, 2)
    if Vol(:, x, :) ~= sideZeroPlane
        firstNonZeroX = x;
    end
end

for x = size(Vol, 2):-1:1
    if Vol(:, x, :) ~= sideZeroPlane
        lastNonZeroX = x;
    end
end

for y = 1:size(Vol, 1)
    if Vol(y, :, :) ~= uprightZeroPlane
        firstNonZeroY = y;
    end
end

for y = size(Vol, 1):-1:1
    if Vol(y, :, :) ~= uprightZeroPlane
        firstNonZeroY = y;
    end
end

for z = 1:size(Vol, 3)
    if Vol(:, :, z) ~= flatZeroPlane
        firstNonZeroZ = z;
    end
end

for z = size(Vol, 3):-1:1
    if Vol(:, :, z) ~= flatZeroPlane
        firstNonZeroZ = z;
    end
end

trimmedVol = Vol(firstNonZeroY:lastNonZeroY, firstNonZeroX:lastNonZeroX, firstNonZeroZ, lastNonZeroZ);

end

