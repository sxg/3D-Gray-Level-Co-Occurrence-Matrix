function [ glcms, SV ] = graycomatrix3D( V, varargin )
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

end

