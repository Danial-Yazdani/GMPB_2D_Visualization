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
close all;clear all;clc;
rng('shuffle');
GMPB                     = [];
GMPB.MinHeight           = 30;
GMPB.MaxHeight           = 70;
GMPB.MinWidth            = 1;
GMPB.MaxWidth            = 12;
GMPB.MaxTau              = 1;
GMPB.MinTau              = -1;
GMPB.MaxEta              = 20;
GMPB.MinEta              = -20;
GMPB.ComponentNumber     = 5;
GMPB.Dimension           = 2;
GMPB.MinCoordinate       = -100;
GMPB.MaxCoordinate       = 100;
GMPB.ComponentsHeight         = GMPB.MinHeight + (GMPB.MaxHeight-GMPB.MinHeight)*rand(GMPB.ComponentNumber,1);%this is generated randomly. It can be changed to be set manually. 
GMPB.ComponentsPosition       = GMPB.MinCoordinate + (GMPB.MaxCoordinate-GMPB.MinCoordinate)*rand(GMPB.ComponentNumber,GMPB.Dimension);%this is generated randomly. It can be changed to be set manually.
GMPB.ComponentsWidth          = GMPB.MinWidth + (GMPB.MaxWidth-GMPB.MinWidth)*rand(GMPB.ComponentNumber,GMPB.Dimension);%this is generated randomly. It can be changed to be set manually. For each component (peak), if the width values are identical, it will not be ill-conditioned.
GMPB.tau                 = GMPB.MinTau + (GMPB.MaxTau-GMPB.MinTau)*rand(GMPB.ComponentNumber,1);%this is generated randomly. It can be changed to be set manually.
GMPB.eta                 = GMPB.MinEta + (GMPB.MaxEta-GMPB.MinEta)*rand(GMPB.ComponentNumber,4);%this is generated randomly. It can be changed to be set manually.
GMPB.Rotation            = 1;%if it is set to 0, components are not rotated. Set it to one to have rotated components
if GMPB.Rotation==0
    GMPB.RotationMatrix=NaN(GMPB.Dimension,GMPB.Dimension,GMPB.ComponentNumber);
    for ii=1 : GMPB.ComponentNumber
        GMPB.RotationMatrix(:,:,ii) = eye(GMPB.Dimension);
    end
else
    GMPB.RotationMatrix=NaN(GMPB.Dimension,GMPB.Dimension,GMPB.ComponentNumber);
    for ii=1 : GMPB.ComponentNumber
        [GMPB.RotationMatrix(:,:,ii) , ~] = qr(rand(GMPB.Dimension));%if GMPB.Rotation==1, a random orthogonal matrix is generated for rotating each component
    end
end
%% Visualization
T = GMPB.MinCoordinate : ( GMPB.MaxCoordinate-GMPB.MinCoordinate)/500 :  GMPB.MaxCoordinate;
L=length(T);
F=zeros(L);
for i=1:L
    for j=1:L
        F(i,j) = Fitness([T(i), T(j)],GMPB);
    end
end
ax1 = subplot(1,2,1);
contour(ax1,T,T,F,40);
colormap jet
xlabel('x_1')
ylabel('x_2')
grid 'on'
title('Contour plot');
ax2 = subplot(1,2,2);
surf(ax2,T,T,F);
title('Surface plot');
colormap jet
xlabel('x_1')
ylabel('x_2')
zlabel('f(x_1 , x_2)')
box 'on'
shading interp
set(gcf, 'Position',  [100, 100, 1400, 600])
