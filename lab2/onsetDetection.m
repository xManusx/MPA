function novelty = onsetDetection(x,N,H,J)
% x:      Input signal
% N:      Frame length
% H:      Hopsize
% J:      Neighborhood

%% short-time power
P = stp(x,N,H);

%% local average
%2J + 1 length
v = ones(2*J+1, 1);
v(:) = 1/(2*J+1);
P_tilde = conv(P, v, 'same');

%% novelty
novelty = zeros(size(P));
for index = [1:size(P,1)]
   novelty(index) = max(0, P(index) - P_tilde(index));
end
end