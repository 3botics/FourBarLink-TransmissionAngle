clear; close all; clc;

%% Tools
r2d = 180/pi;

%% Initial Parameters
L2  = 32.2
L3  = 83.2
L4  = 40
L1x = 50
L1y = 85

theta2_test = 0.0106;
theta4_test = -3.0312;

theta2 = linspace(-60/r2d,60/r2d,100);
theta2min = min(theta2);
theta2max = max(theta2);

L2array = linspace(22.2,42.2,5);
L4array = linspace(39,41,5);

gamma = zeros(length(L2array), length(theta2));

for i = 1:length(L2array)
    L2 = L2array(i);
    
    for j = 1:length(L4array)
        L4 = L4array(j)
     
        L3 = sqrt(L1x^2 + L1y^2 + L2^2 +L4^2 - 2*L1x*L2*cos(theta2_test) - 2*L1y*L2*sin(theta2_test) + ...
            cos(theta4_test)*(2*L1x*L4 - 2*L2*L4*cos(theta2_test)) + ...
            sin(theta4_test)*(2*L1y*L4 - 2*L2*L4*sin(theta2_test)));
     
        P1 = 2*L1y*L4 - 2*L2*L4*sin(theta2);
        P2 = 2*L1x*L4 - 2*L2*L4*cos(theta2);
        P3 = L1x^2 + L1y^2 + L2^2 - L3^2 + L4^2 - 2*L1x*L2*cos(theta2) - 2*L1y*L2*sin(theta2);

        theta4x = P3 - P2;
        theta4y = -P1 - sqrt(P1.^2 + P2.^2 - P3.^2);
        theta4 = 2*atan2(theta4y, theta4x);

        theta3x = L1x - L2*cos(theta2) + L4*cos(theta4);
        theta3y = L1y - L2*sin(theta2) + L4*sin(theta4);
        theta3 = atan2(theta3y, theta3x);
    
        L = (L1x - L2*cos(theta2)).^2 + (L1y - L2*sin(theta2)).^2;
        gamma(i,:) = acos((L3^2 + L4^2 - L)/(2*L3*L4));
        
        figure(j)
        plot(theta2*r2d, gamma(i,:)*r2d);
        legend('1','2','3','4','5');
        xlabel('\theta_2');
        ylabel('\gamma');
        title('\theta_4', j);
        hold on;
        grid on;
        grid minor;
    
    
        figure(j + length(L4array))
        plot(theta2*r2d, theta4*r2d);
        legend('1','2','3','4','5');
        xlabel('\theta_2');
        ylabel('\theta_4');
        title('\theta_4', j);
        hold on;
        grid on;
        grid minor;
    
        %immse(ones(1,length(theta2))*90/r2d,gamma(i,:))
    end
end

