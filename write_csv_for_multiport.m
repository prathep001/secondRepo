function write_csv_for_multiport
% This get the output from multiport and write the data in csv.
output = evalin('base','output');
msg = evalin('base','msg');
input = evalin('base','input');
details = {input output msg};
details_table = cell2table(details);
details_table.Properties.VariableNames = {'Input','Output','Message'};
writetable(details_table,'multiport_details.csv');
end