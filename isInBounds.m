function [ inBounds ] = isInBounds( i, low, high )
%isInBounds Checks to see if i >= low and i <= high.

if i >= low && i <= high
    inBounds = true;
else
    inBounds = false; 
end

end

