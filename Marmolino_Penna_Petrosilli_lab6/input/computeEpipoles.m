function computeEpipoles(F_matrices, names)
    % computeEpipoles: Compute epipoles for given fundamental matrices
    % Inputs:
    %   F_matrices: fundamental matrices
    %   names: array containing names or descriptions for each matrix

    if nargin < 2
        error('Provide both F_matrices and names as inputs.');
    end
    
    for i = 1:length(F_matrices)
        F = F_matrices{i};
        name = names{i};
        
        % Perform Singular Value Decomposition (SVD)
        [U, ~, V] = svd(F);
        
        % Compute left and right epipoles
        e_left = U(:, end); % Last column of U
        e_right = V(:, end); % Last column of V
        
        % Normalize epipoles (ensure homogeneous coordinate w=1)
        e_left = e_left / e_left(end);
        e_right = e_right / e_right(end);
        
        % Display results
        disp(['Epipoles for ', name]);
        disp(['  Left Epipole: ', mat2str(e_left)]);
        disp(['  Right Epipole: ', mat2str(e_right)]);
        disp('---------------------------------------');
    end
end
