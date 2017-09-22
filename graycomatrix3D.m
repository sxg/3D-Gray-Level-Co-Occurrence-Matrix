function [ glcmArray, SV ] = graycomatrix3D( V, varargin )
%graycomatrix3D Create gray-level co-occurrence matrix for 3D images.
%   Detailed explanation goes here

% Add inputs
p = inputParser;
% A volume matrix is required
addRequired(p, 'V');
% NumLevels is the number of gray levels in the image
addParameter(p, 'NumLevels', 1);
% offset is the set of offsets to evaluate
addParameter(p, 'offset', [0, 1, 0]);
% Symmetric considers the ordering of values
addParameter(p, 'Symmetric', false);

% Get inputs
parse(p, V, varargin{:});
numLevels = p.Results.NumLevels;
offsetArray = p.Results.offset;
symmetric = p.Results.symmetric;

% Get the scaled volume from the graycomatrix function by converting the 3D
% matrix to 2D temporarily.
V2D = reshape(V, size(V, 1), size(V, 2) * size(V, 3));
[~, SV2D] = graycomatrix(V2D, 'NumLevels', numLevels);
SV = reshape(SV2D, size(V, 1), size(V, 2), size(V, 3));

% GLCM matrices are all NumLevels-by-NumLevels. There is one GLCM for every
% offset.
glcmArray = zeros(numLevels, numLevels, length(offsetArray));

% Count co-occurrences
iMin = 1;
iMax = size(SV, 1);
jMin = 1;
jMax = size(SV, 2);
kMin = 1;
kMax = size(SV, 3);
for o = 1:size(offsetArray, 1)
    offset = offsetArray(o, :);
    rowOffset = offset(1);
    colOffset = offset(2);
    sliceOffset = offset(3);
    for grayX = 1:NumLevel
        for grayY = 1:NumLevel
            for i = iMin:iMax
                for j = jMin:jMax
                    for k = kMin:kMax
                        val = SV(i, j, k);
                        if val == grayX
                            if isInBounds(i + rowOffset, iMin, iMax) && isInBounds(j + colOffset, jMin, jMax) && isInBounds(k + sliceOffset, kMin, kMax)
                                offsetVal = SV(i + rowOffset, j + colOffset, k + sliceOffset);
                                if offsetVal == grayY
                                    % add this to the co-occurrence matrix
                                    glcmArray(grayX, grayY, o) = glcmArray(grayX, grayY, o) + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

end

