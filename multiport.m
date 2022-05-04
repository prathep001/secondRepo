function [input,output,msg] = multiport(a,b,choice)
% multiport switch.
msg = ['The choice selected is ' num2str(choice)];
input = [a b];
switch choice
    case 1
        output = a + b;
    case 2
        output = a-b;
    case 3
        output = a*b;
    otherwise
        msg = 'The choice selected is invalid';
        output = [];
end
end