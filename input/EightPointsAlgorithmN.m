function [F] = EightPointsAlgorithmN(P1,P2)

    %Calling function with transposed matrices according to how it has been
    %implemented

    [nP1, T1] = normalise2dpts(P1');
    [nP2, T2] = normalise2dpts(P2');

    %Transposing again obtained matrices
    nP1 = nP1';
    nP2 = nP2';

    F = EightPointsAlgorithm(nP1, nP2);

    F = T2'*F*T1;
end

