clear all
close all
clc

%Prob of winning
x = [1:100];
Pw = x./100;
n = 4;
P = 1 - (1 - Pw).^n;

%P2 of winning
n = 4
k = 1
pp = x./100
P1 = binopdf(k,n,pp)
P2 = binopdf(2,n,pp)
P3 = binopdf(3,n,pp)
P4 = binopdf(4,n,pp)


%Twelve tickets purchased
Sq12 = 1 - (1 - 12/100).^n;
StrSq12= num2str(Sq12);

%25 tickets purchased
Sq25 = 1 - (1 - 25/100).^n;
StrSq25 = num2str(Sq25);

%Plotting probability of winning
figure
subplot(3,1,1)
plot(x,P)
title('Superbowl')
ylabel("Probability of Winning at Least Once")
text(12,Sq12,StrSq12)
text(25,Sq25,StrSq25)
xline(12)
xline(25)

%Plotting binomial PDF for 1,2,3,4 wins
subplot(3,1,2)
hold on
plot(x,P1)
plot(x,P2)
plot(x,P3)
plot(x,P4)
legend('1','2','3','4')
hold off


%Probabilty values for P
I = 1:100;
for i = I
    A(i,1) = i;
    A(i,2) = 1 - (1 - i./100).^n;
end
disp("Values of P")
disp(A)

%Joint Probability of [number of squares bought, iterations]
I = 1:100;
J = 1:5;
for i = I
    for j = J
        B(i,1) = i;
        B(i,(j+1)) = (i./100)^(j);
    end
end
disp("[number of squares bought, iterations]")
disp(B)

%Probability of winnign more than one quarter
Pq1 = (x./100).^1;
Pq2 = (x./100).^2;
Pq3 = (x./100).^3;
Pq4 = (x./100).^4;

%Plotting joing probability
subplot(3,1,3)
plot(x,Pq1,x,Pq2,x,Pq3,x,Pq4)
xline(12)
xline(25)
xlabel("Number of Squares Purchased")
ylabel("Probability of Winning")
legend('Winning 1 Game','2 Games', '3 Games',...
    '4 Games', 'location', 'northwest')

%Creating excel spreadsheet
filename = 'SuperBowlData.xlsx';
writematrix(A,filename,'Sheet',1)
writematrix(B,filename,'Sheet',2)

max(P1)
max(P2)
max(P3)
max(P4)
