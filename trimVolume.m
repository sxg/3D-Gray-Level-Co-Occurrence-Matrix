function [ trimmedVol ] = trimVolume( Vol )
%trimVolume Removes all zero planes in the volume.

flatZeroPlane = zeros(size(Vol, 1), size(Vol, 2), 1);
uprightZeroPlane = zeros(1, size(Vol, 2), size(Vol, 3));
sideZeroPlane = zeros(size(Vol, 1), 1, size(Vol, 3));

firstNonZeroX = 1;
lastNonZeroX = size(Vol, 2);
firstNonZeroY = 1;
lastNonZeroY = size(Vol, 1);
firstNonZeroZ = 1;
lastNonZeroZ = size(Vol, 3);
for x = 1:size(Vol, 2)
    if ~isequal(Vol(:, x, :), sideZeroPlane)
        firstNonZeroX = x;
        break;
    end
end

for x = size(Vol, 2):-1:1
    if ~isequal(Vol(:, x, :), sideZeroPlane)
        lastNonZeroX = x;
        break;
    end
end

for y = 1:size(Vol, 1)
    if ~isequal(Vol(y, :, :), uprightZeroPlane)
        firstNonZeroY = y;
        break;
    end
end

for y = size(Vol, 1):-1:1
    if ~isequal(Vol(y, :, :), uprightZeroPlane)
        lastNonZeroY = y;
        break;
    end
end

for z = 1:size(Vol, 3)
    if ~isequal(Vol(:, :, z), flatZeroPlane)
        firstNonZeroZ = z;
        break;
    end
end

for z = size(Vol, 3):-1:1
    if ~isequal(Vol(:, :, z), flatZeroPlane)
        lastNonZeroZ = z;
        break;
    end
end

trimmedVol = Vol(firstNonZeroY:lastNonZeroY, firstNonZeroX:lastNonZeroX, firstNonZeroZ:lastNonZeroZ);

end

