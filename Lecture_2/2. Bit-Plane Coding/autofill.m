% ������ֲ�
% author: ����� 1120170852
function [output] = autofill(input)
a = length(input);
ze = '0 ';
b = repmat(ze,1,9-a);
output = str2num(strcat(b,num2str(input)));
end

