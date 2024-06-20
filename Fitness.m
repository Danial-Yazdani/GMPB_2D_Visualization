%*********************************Generalized Moving Peaks Benchmark (GNBG)-VISUALIZATION******
%Author: Danial Yazdani
%Last Edited: June 03, 2021
%
% ------------
% Reference:
% ------------
%
%  D. Yazdani et al.,
%            "Benchmarking Continuous Dynamic Optimization: Survey and Generalized Test Suite,"
%            IEEE Transactions on Cybernetics (2020).
%
% --------
% License:
% --------
% This program is to be used under the terms of the GNU General Public License
% (http://www.gnu.org/copyleft/gpl.html).
% Author: Danial Yazdani
% e-mail: danial.yazdani AT gmail dot com
%         danial.yazdani AT yahoo dot com
% Copyright notice: (c) 2021 Danial Yazdani
%**************************************************************************************************
function [result,GMPB] = Fitness(X,GMPB)
    x = X';
    f=NaN(1,GMPB.ComponentNumber);
    for k=1 : GMPB.ComponentNumber
        a = Transform((x - GMPB.ComponentsPosition(k,:)')'*GMPB.RotationMatrix(:,:,k)',GMPB.tau(k),GMPB.eta(k,:));
        b = Transform(GMPB.RotationMatrix(:,:,k) * (x - GMPB.ComponentsPosition(k,:)'),GMPB.tau(k),GMPB.eta(k,:));
        f(k) = GMPB.ComponentsHeight(k) - sqrt( a * diag(GMPB.ComponentsWidth(k,:).^2) * b);
    end
    result = max(f);
end

function Y = Transform(X,tau,eta)
Y = X;
tmp = (X > 0);
Y(tmp) = log(X(tmp));
Y(tmp) = exp(Y(tmp) + tau*(sin(eta(1).*Y(tmp)) + sin(eta(2).*Y(tmp))));
tmp = (X < 0);
Y(tmp) = log(-X(tmp));
Y(tmp) = -exp(Y(tmp) + tau*(sin(eta(3).*Y(tmp)) + sin(eta(4).*Y(tmp))));
end